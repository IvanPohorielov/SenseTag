@preconcurrency import CoreNFC
import enum SwiftUI.AccessibilityNotification

public final actor NFCNDEFManager {
    // MARK: - Properties

    private var session: NFCNDEFReaderSession?
    private let sessionDelegate: NFCNDEFReaderSessionDelegateWrapper =
        NFCNDEFReaderSessionDelegateWrapper()

    // MARK: - Init

    public init() {}

    // MARK: - Public Methods

    public func read() async throws -> [NFCNDEFManagerPayload] {
        var payloads: [NFCNDEFManagerPayload] = []
        
        let message = LocalizedStringResource(
            "NFCNDEFManager.readerSession.message.read",
            defaultValue: "Hold your iPhone close to the NFC tag to start scanning.",
            bundle: .atURL(Bundle.module.bundleURL),
            comment: "Message shown to the user when NFC read session is started."
        )

        try await detectTag(message) { tag in
            let tagPayloads = try await self.handleRead(tag)
            await MainActor.run {
                payloads.append(contentsOf: tagPayloads)
            }
        }

        return payloads
    }

    public func write(_ payloads: [NFCNDEFManagerPayload]) async throws {
        let message = LocalizedStringResource(
            "NFCNDEFManager.readerSession.message.write",
            defaultValue: "Hold your iPhone close to the NFC tag to write data.",
            bundle: .atURL(Bundle.module.bundleURL),
            comment: "Message shown to the user when NFC write session is started."
        )
        
        try await detectTag(message) { tag in
            try await self.handleWrite(to: tag, payloads: payloads)
        }
    }

    public func clear() async throws {
        let message = LocalizedStringResource(
            "NFCNDEFManager.readerSession.message.clear",
            defaultValue: "Hold your iPhone close to the NFC tag to erase its data.",
            bundle: .atURL(Bundle.module.bundleURL),
            comment: "Message shown to the user when NFC clear session is started."
        )
        try await detectTag(message) { tag in
            try await self.handleWrite(to: tag, payloads: [])
        }
    }

    public func lock() async throws {
        let message = LocalizedStringResource(
            "NFCNDEFManager.readerSession.message.lock",
            defaultValue: "Hold your iPhone close to the NFC tag to lock it permanently.",
            bundle: .atURL(Bundle.module.bundleURL),
            comment: "Message shown to the user when NFC lock session is started."
        )
        try await detectTag(message) { tag in
            try await self.handleLock(tag)
        }
    }
    
    public func parseNDEFMessage(_ message: NFCNDEFMessage) -> [NFCNDEFManagerPayload]
    {
        message.records.map { $0.mapped() }
    }

    // MARK: - Private Methods

    private func detectTag(_ message: LocalizedStringResource, handle: @Sendable @escaping (NFCNDEFTag) async throws -> Void) async throws {

        try self.startSession(
            alertMessage: String(localized: message)
        )
        
        AccessibilityNotification.ScreenChanged().post()

        do {
            for try await tag in sessionDelegate.detect() {
                try await handle(tag)

                // Exit after first tag readed
                self.invalidateSession()
            }
            self.invalidateSession()
        } catch {
            if let nfcError = error as? NFCReaderError {
                self.invalidateSession(with: String(localized: nfcError.localizedString))
            } else {
                self.invalidateSession(with: error.localizedDescription)
            }
            throw error
        }
    }

    private func startSession(alertMessage: String) throws {
        guard NFCNDEFReaderSession.readingAvailable else {
            throw NFCError.readerNFCUnsupported
        }

        guard session == nil else {
            throw NFCError.sessionAlreadyRunning
        }

        self.session = NFCNDEFReaderSession(
            delegate: sessionDelegate,
            queue: nil,
            // Set to false
            // Because sessionDelegate implement
            // readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag])
            // See NFCNDEFReaderSessionDelegateWrapper
            invalidateAfterFirstRead: false
        )
        self.session?.alertMessage = alertMessage
        self.session?.begin()
    }

    private func invalidateSession(with error: String? = nil) {
        if let error {
            // Invalidate session with error message displayed
            self.session?.invalidate(errorMessage: error)
        } else {
            self.session?.invalidate()
        }

        self.clearSession()
    }

    private func clearSession() {
        self.session = nil
    }
}

// MARK: - Handler methods

extension NFCNDEFManager {
    // MARK: - Reading

    private func handleRead(_ tag: NFCNDEFTag) async throws
        -> [NFCNDEFManagerPayload]
    {
        let message = try await { try await tag.readNDEF() }()
        return parseNDEFMessage(message)
    }
    
    // MARK: - Writing

    private func handleWrite(
        to tag: NFCNDEFTag, payloads: [NFCNDEFManagerPayload]
    ) async throws {

        try await self.handleTagStatus(tag)

        let records = payloads.map { $0.mapped() }

        let message = NFCNDEFMessage(records: records)

        try await { try await tag.writeNDEF(message) }()
    }

    private func handleLock(_ tag: NFCNDEFTag) async throws {

        try await self.handleTagStatus(tag)

        try await { try await tag.writeLock() }()
    }

    // MARK: - Common

    private func handleTagStatus(_ tag: NFCNDEFTag) async throws {

        let (status, _) = try await { try await tag.queryNDEFStatus() }()

        switch status {
        case .readOnly:
            throw NFCError.tagReadOnlyStatus
        case .notSupported:
            throw NFCError.tagNotSupportedStatus
        case .readWrite:
            break
        @unknown default:
            throw NFCError.tagUnknownStatus
        }
    }
}
