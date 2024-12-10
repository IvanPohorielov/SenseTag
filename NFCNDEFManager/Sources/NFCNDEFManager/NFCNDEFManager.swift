
@preconcurrency import CoreNFC

public final actor NFCNDEFManager {
    
    // MARK: - Properties
    
    private var session: NFCNDEFReaderSession?
    private let sessionDelegate: NFCNDEFReaderSessionDelegateWrapper = NFCNDEFReaderSessionDelegateWrapper()
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Public Methods
    
    public func read() async throws -> [NFCNDEFManagerPayload] {
        
        guard NFCNDEFReaderSession.readingAvailable else {
            throw NFCError.nfcNotAvailable
        }
        
        guard session == nil else {
            throw NFCError.sessionAlreadyRunning
        }
        
        self.startSession(
            alertMessage: "Hold your iPhone near the tag."
        )
        
        var payloads: [NFCNDEFManagerPayload] = []
        
        do {
            for try await tag in sessionDelegate.detect() {
                
                let tagPayloads = try await self.handleRead(tag)
                payloads.append(contentsOf: tagPayloads)
                
                // Close sesion after first tag readed
                self.invalidateSession()
            }
        } catch {
            self.invalidateSession(with: error.localizedDescription)
            throw error
        }
        
        return payloads
    }
    
    public func write(_ payload: NFCNDEFManagerPayload) async throws {
        
        guard NFCNDEFReaderSession.readingAvailable else {
            throw NFCError.nfcNotAvailable
        }
        
        guard session == nil else {
            throw NFCError.sessionAlreadyRunning
        }
        
        self.startSession(
            alertMessage: "Hold your iPhone near the tag."
        )
        
        do {
            for try await tag in sessionDelegate.detect() {
                
                try await self.handleWrite(to: tag, payload: payload)
                
                // Close sesion after first tag readed
                self.invalidateSession()
            }
        } catch {
            self.invalidateSession(with: error.localizedDescription)
            throw error
        }
    }
    
    // MARK: - Private Methods
    
    private func startSession(alertMessage: String) {
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
        return try getPayloads(message)
    }
    
    private func getPayloads(_ message: NFCNDEFMessage) throws -> [NFCNDEFManagerPayload] {
        let result = try message.records.map { record in
            
            guard let recordType = NFCNDEFPayloadType(
                rawValue: String(
                    decoding: record.type,
                    as: UTF8.self
                )
            ) else {
                throw NFCError.noPayload
            }
            
            switch recordType {
            case .text:
                
                guard let text = record.wellKnownTypeTextPayload().0 else {
                    throw NFCError.noPayload
                }
                
                return NFCNDEFManagerPayload(text: text)
            case .url:
                
                guard let url = record.wellKnownTypeURIPayload() else {
                    throw NFCError.noPayload
                }
                
                return NFCNDEFManagerPayload(url: url)
            }
        }
        
        return result
    }
    
    // MARK: - Writing
    
    private func handleWrite(to tag: NFCNDEFTag, payload: NFCNDEFManagerPayload) async throws {
        
        let (status, capacity) = try await { try await tag.queryNDEFStatus() }()
        
        switch status {
        case .readOnly:
            throw NFCError.readOnlyTagStatus
        case .notSupported:
            throw NFCError.notSupportedTagStatus
        case .readWrite:
            let record: NFCNDEFPayload?
            
            switch payload.type {
            case .text:
                let text = try payload.extractText()
                record = NFCNDEFPayload.wellKnownTypeTextPayload(
                    string: text,
                    locale: Locale.current
                )
            case .url:
                let url = try payload.extractURL()
                record = NFCNDEFPayload.wellKnownTypeURIPayload(url: url)
            }
            
            guard let record else {
                throw NFCError.noPayload
            }
            
            let message = NFCNDEFMessage(records: [record])
            
            try await { try await tag.writeNDEF(message) }()
            
        @unknown default:
            throw NFCError.unknownTagStatus
        }
    }
}
