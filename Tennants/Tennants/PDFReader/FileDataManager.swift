import Foundation
import SwiftUI
import FirebaseStorage
import PDFKit
import OSLog

protocol PDFManager {
    func handleImportedFile(url: URL)
    func uploadFile(url: Data?, completion: @escaping (String?, Error?) -> Void)
    func validateFileURL(_ fileURL: URL) -> Bool
}

final class FPDDataManager: ObservableObject, PDFManager {
    let storageRef = Storage.storage().reference()
    var bankTypes: [String] = ["Standard", "FNB", "Capitec"]
    var storagePath = ""
    
    @Published var selectedBankType = "Standard"
    @Published var showPDFImporter: Bool = false
    @Published var isCompleteUploading: Bool = false
    
    init() {
        
    }
    
    func handleImportedFile(url: URL) {
        if validateFileURL(url) {
            do {
                let data = try Data(contentsOf: url)
                uploadFile(url: data) { success, error in
                    if let error = error {
                        os_log("Failed to upload: %@", type: .debug, error.localizedDescription)
                        return
                    }
                    
                    print("\(String(describing: success))")
                    self.isCompleteUploading = true
                }
            } catch {
                os_log("Error reading file data: %@", type: .debug, error.localizedDescription)
            }
        }
    }
    
    #warning("Get userID/name to pass in to make folder unique")
    internal func uploadFile(url: Data?, completion: @escaping (String?, Error?) -> Void) {
        guard let localFile = url else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "application/pdf"
        storagePath = setUpStoragePath()
        
        let statementRef = storageRef.child(storagePath)
        if let url = url {
            _ = statementRef.putData(localFile, metadata: metadata) { metadata, error in
                guard let metadata = metadata else {
                    os_log("An error occurred: %@", type: .debug,  error?.localizedDescription ?? "Failed to reading metadata")
                    completion(nil, error)
                    return
                }
                
                let name = metadata.name ?? ""
                completion("PDF file \(name) uploaded successfully", nil)
            }
        }
    }
    
    internal func validateFileURL(_ fileURL: URL) -> Bool {
        let fileManager = FileManager.default
        
        guard fileURL.isFileURL else {
            os_log("The URL is not a file URL.", type: .debug)
            return false
        }
        
        do {
            let fileAttributes = try fileManager.attributesOfItem(atPath: fileURL.path)
            
            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeDirectory {
                os_log("The URL is a directory.", type: .debug)
                return false
            }
            
            if let fileType = fileAttributes[FileAttributeKey.type] as? FileAttributeType, fileType == .typeSymbolicLink {
                os_log("The URL is a symbolic link.", type: .debug)
                return false
            }
        } catch {
            os_log("The URL is invalid or cannot be accessed:", type: .debug, error.localizedDescription)
            return false
        }
        
        return true
    }
    
    private func setUpStoragePath() -> String {
        let date = Date.now
        let day = date.formatted(.dateTime.weekday(.twoDigits))
        let month = date.formatted(.dateTime.month(.twoDigits))
        let year = date.formatted(.dateTime.year(.extended(minimumLength: 2)))
        return "statements/userID/\(day)_\(month)_\(year)_\(selectedBankType)_statement.pdf"
    }
}
