//
//  ViewController.swift
//  VulnerableWebServer
//
//  Created by Kristiina Rahkema on 11.07.2022.
//

import UIKit
import UniformTypeIdentifiers
import GCDWebServer

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet var urlField: UILabel?
    @IBOutlet var folderPath: UITextField?
    @IBOutlet var hiddenFilesToggle: UISwitch?
    
    var webUploader: GCDWebUploader!
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction
    func shareButtonPressed() {
        if let url = self.url {
            webUploader = GCDWebUploader(uploadDirectory:url.path)
            
            if let hiddenFilesToggle = hiddenFilesToggle {
                webUploader.allowHiddenItems = hiddenFilesToggle.isOn
            }
            
            webUploader.start()
        
            if let url = webUploader.serverURL {
                print("Visit \(url) in your web browser")
                self.urlField?.text = "\(url)"
            }
        }
    }
    
    @IBAction
    func urlFieldClicked() {
        folderPath?.endEditing(true)
        displayDocumentPicker()
    }

    
    func displayDocumentPicker() {
        let supportedTypes: [UTType] = [UTType.folder]
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        
        pickerViewController.delegate = self
        pickerViewController.modalPresentationStyle = .overFullScreen

        present(pickerViewController, animated: true)
        pickerViewController.allowsMultipleSelection = false
    }
    
    func documentPicker(_ picker: UIDocumentPickerViewController, didPickDocumentsAt: [URL]) {
        self.url = didPickDocumentsAt.first // there should only be one
        self.folderPath?.text = self.url?.lastPathComponent
        
        if let url = self.url {
            print("Chosen folder: \(url.path)")
        }
    }

}

