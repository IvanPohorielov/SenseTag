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
    public func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {}

    // Never called because (didDetect tags:) implemented
    public func readerSession(
        _ session: NFCNDEFReaderSession,
        didDetectNDEFs messages: [NFCNDEFMessage]
    ) {}

    public func readerSession(
        _ session: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag]
    ) {
        for tag in tags {
            self.streamContinuation?.yield(tag)
        }
    }

    public func readerSession(
        _ session: NFCNDEFReaderSession, didInvalidateWithError error: any Error
    ) {

        let nsError = error as NSError

        if let continuation = streamContinuation {
            switch nsError.code {
            // User canceled NFC session
            case NFCReaderError.readerSessionInvalidationErrorUserCanceled
                .rawValue:
                continuation.finish()
            // NFC session set to be canceled after first tag read
            // Works only if delegate method NOT implemented
            // readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [any NFCNDEFTag])
            case NFCReaderError.readerSessionInvalidationErrorFirstNDEFTagRead
                .rawValue:
                continuation.finish()
            default:
                continuation.finish(throwing: error)
            }

            self.streamContinuation = nil
        }
    }
}
