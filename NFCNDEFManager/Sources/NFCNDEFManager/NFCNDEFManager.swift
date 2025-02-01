
@preconcurrency import CoreNFC

public final actor NFCNDEFManager {
    
    // MARK: - Properties
    
    private var session: NFCNDEFReaderSession?
    private let sessionDelegate: NFCNDEFReaderSessionDelegateWrapper = NFCNDEFReaderSessionDelegateWrapper()
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Public Methods
    
    public func read() async throws -> [NFCNDEFManagerPayload] {
        
        try self.startSession(
            alertMessage: "Hold your iPhone near the NFC tag to read it."
        )
        
        var payloads: [NFCNDEFManagerPayload] = []
        
        do {
            for try await tag in sessionDelegate.detect() {
                
                let tagPayloads = try await self.handleRead(tag)
                payloads.append(contentsOf: tagPayloads)
                
                // Close sesion after first tag readed
                self.invalidateSession()
            }
            // Close sesion if user cancelled session
            self.invalidateSession()
        } catch {
            self.invalidateSession(with: error.localizedDescription)
            throw error
        }
        return payloads
    }
    
    public func write(_ payloads: [NFCNDEFManagerPayload]) async throws {
        
        try self.startSession(
            alertMessage: "Hold your iPhone near the NFC tag to record."
        )
        
        do {
            for try await tag in sessionDelegate.detect() {
                
                try await self.handleWrite(to: tag, payloads: payloads)
                
                // Close sesion after first tag readed
                self.invalidateSession()
            }
            // Close sesion if user cancelled session
            self.invalidateSession()
        } catch {
            self.invalidateSession(with: error.localizedDescription)
            throw error
        }
    }
    
    public func clear() async throws {
        
        try self.startSession(
            alertMessage: "Hold your iPhone near the NFC tag to clear."
        )
        
        do {
            for try await tag in sessionDelegate.detect() {
                
                try await self.handleWrite(to: tag, payloads: [])
                
                // Close sesion after first tag readed
                self.invalidateSession()
            }
            // Close sesion if user cancelled session
            self.invalidateSession()
        } catch {
            self.invalidateSession(with: error.localizedDescription)
            throw error
        }
    }
    
    public func lock() async throws {
        
        try self.startSession(
            alertMessage: "Hold your iPhone near the NFC tag to lock."
        )
        
        do {
            for try await tag in sessionDelegate.detect() {
                
                try await self.handleLock(tag)
                
                // Close sesion after first tag readed
                self.invalidateSession()
            }
            // Close sesion if user cancelled session
            self.invalidateSession()
        } catch {
            self.invalidateSession(with: error.localizedDescription)
            throw error
        }
    }
    
    // MARK: - Private Methods
    
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

private extension NFCNDEFManager {
    
    // MARK: - Reading
    
    private func handleRead(_ tag: NFCNDEFTag) async throws -> [NFCNDEFManagerPayload] {
        let message = try await { try await tag.readNDEF() }()
        return getPayloads(message)
    }
    
    private func getPayloads(_ message: NFCNDEFMessage) -> [NFCNDEFManagerPayload] {
        message.records.map { $0.mapped() }
    }
    
    // MARK: - Writing
    
    private func handleWrite(to tag: NFCNDEFTag, payloads: [NFCNDEFManagerPayload]) async throws {
        
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
