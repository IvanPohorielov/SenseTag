//
//  NFCNDEFReaderSessionDelegateWrapper.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

@preconcurrency import CoreNFC
import Foundation

public final class NFCNDEFReaderSessionDelegateWrapper: NSObject,
    NFCNDEFReaderSessionDelegate
{
    // MARK: - Properties

    private var streamContinuation:
        AsyncThrowingStream<NFCNDEFTag, Error>.Continuation?

    // MARK: - Methods

    public func detect() -> AsyncThrowingStream<NFCNDEFTag, Error> {
        AsyncThrowingStream { continuation in
            self.streamContinuation = continuation
        }
    }

    // MARK: - NFCNDEFReaderSessionDelegate

    // Implemented to silence console warning
    public func readerSessionDidBecomeActive(_: NFCNDEFReaderSession) {}

    // Never called because (didDetect tags:) implemented
    public func readerSession(
        _: NFCNDEFReaderSession,
        didDetectNDEFs _: [NFCNDEFMessage]
    ) {}

    public func readerSession(
        _: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag]
    ) {
        for tag in tags {
            streamContinuation?.yield(tag)
        }
    }

    public func readerSession(
        _: NFCNDEFReaderSession, didInvalidateWithError error: any Error
    ) {
        if let continuation = streamContinuation,
            let nfcError = error as? NFCReaderError
        {
            switch nfcError {
            // User canceled NFC session
            case NFCReaderError.readerSessionInvalidationErrorUserCanceled:
                continuation.finish()
            // NFC session set to be canceled after first tag read
            // Works only if delegate method NOT implemented
            // readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag])
            case NFCReaderError.readerSessionInvalidationErrorFirstNDEFTagRead:
                continuation.finish()
            default:
                continuation.finish(throwing: error)
            }

            streamContinuation = nil
        }
    }
}
