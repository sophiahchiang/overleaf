//
//  ListViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit
import Down

protocol ListViewControllerDelegate: AnyObject {
    func updateDocument(doc: String, atIndex index: Int)
}

class ListViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var docLabel: UITextView!
    @IBOutlet var latexField: UITextView!
        
    public var docTitle: String = ""
    public var doc: String = ""
    public var date: Date = Date()
    
    var updateTitleHandler: ((String) -> Void)?
    weak var delegate: ListViewControllerDelegate?
    var selectedIndex: Int = -1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = docTitle
        docLabel.text = doc
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let stringDate = formatter.string(from: date)
        dateLabel.text = stringDate
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTitleLabelTap))
                titleLabel.addGestureRecognizer(tapGestureRecognizer)
                titleLabel.isUserInteractionEnabled = true
                
                updateUI()
        
        let tapDocGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDocLabelTap))
                docLabel.addGestureRecognizer(tapDocGestureRecognizer)
                docLabel.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: docLabel)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))

        }
    
        @objc func doneButtonPressed() {
            hideTextView(latexField)
            print("donebuttonpressed")
        }
    
        func hideTextView(_ textView: UITextView) {
            textView.isHidden = true
        }
        
        
        func updateUI() {
            titleLabel.text = docTitle
            docLabel.text = doc
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let stringDate = formatter.string(from: date)
            dateLabel.text = stringDate
            
            if let attributedString = renderMarkdown(markdownText: docLabel.text) {
                docLabel.attributedText = attributedString
            }
        }
    
        @objc func handleTitleLabelTap() {
            let alertController = UIAlertController(title: "Edit Title", message: "Please edit the title", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = self.docTitle
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let okayAction = UIAlertAction(title: "OK", style: .default) { _ in
                if let newTitle = alertController.textFields?.first?.text {
                    self.docTitle = newTitle
                    self.updateTitleHandler?(newTitle)
                    self.updateUI()
                }
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(okayAction)
            
            present(alertController, animated: true, completion: nil)
        }
    
        @objc func handleDocLabelTap() {
            docLabel.isEditable = true
            docLabel.becomeFirstResponder()
            
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing))
            navigationItem.rightBarButtonItem = doneButton
        }
    
        @objc func doneEditing() {
            docLabel.isEditable = false
            docLabel.resignFirstResponder()
            
            // Retrieve the updated document content
            if let newDoc = docLabel.text {
                doc = newDoc
                updateUI()
                delegate?.updateDocument(doc: newDoc, atIndex: selectedIndex)

            }
            
            // Remove the "Done" button from the navigation bar
            navigationItem.rightBarButtonItem = nil
        }
            
                
        func renderMarkdown(markdownText: String) -> NSAttributedString? {
            let down = Down(markdownString: markdownText)
            do {
                let attributedString = try down.toAttributedString()
                return attributedString
            } catch {
                print("Error parsing Markdown: \(error)")
                return nil
            }
        }
    
    @objc func textDidChange() {
            // Update the text in latexField
        guard let docText = docLabel.text else {
            latexField.text = nil
            return
        }
        
        let newText = renderMarkdown(markdownText: docText)
        latexField.attributedText = newText
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


