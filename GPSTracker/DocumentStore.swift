import Foundation
import os

/**
 DocumentStore stores a Codable document in the documents directory of the app.

 - Loading and saving happens on the thread you call it on, typically the main thread.
 - This should be only used for small documents (recommendation: smaller than 1KB). For larger documents, or if you want features like schema migration, Core Data (or some other database framework for apps like Realm) will be a better fit.
 - This is a starting point and not to be used for critical app data: If the document cannot be loaded (f.e. because of an incompatible change of the Document type), the Document will silently be nil and be overwritten on the next save. If the document cannot be saved, it will crash.
 */
class DocumentStore<DocumentType: Codable> {
    private let documentUrl: URL
    private let log = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "DocumentStore")

    var document: DocumentType? {
        didSet {
            if let document = document {
                self.save(document: document)
            } else {
                self.delete()
            }
        }
    }

    init(filename: String) {
        self.documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        self.document = self.load()
    }

    private func load() -> DocumentType? {
        let jsonDecoder = JSONDecoder()
        if FileManager.default.fileExists(atPath: self.documentUrl.path) {
            do {
                let data = try Data(contentsOf: documentUrl)
                return try jsonDecoder.decode(DocumentType.self, from: data)
            } catch {
                self.log.error("DocumentStore failed to load from URL \(self.documentUrl)")
                return nil
            }
        } else {
            return nil
        }
    }

    private func save(document: DocumentType) {
        let jsonEncoder = JSONEncoder()
        let data = try! jsonEncoder.encode(document)
        try! data.write(to: self.documentUrl, options: .atomic)
    }

    private func delete() {
        try? FileManager.default.removeItem(at: self.documentUrl)
    }
}
