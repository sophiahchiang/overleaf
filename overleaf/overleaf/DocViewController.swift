//
//  DocViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit
import Down


class DocViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var docField: UITextView!
    @IBOutlet var latexField: UITextView!
    
    public var completion: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: docField)

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: docField)
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
            //latexField.text = docField.text
        guard let docText = docField.text else {
            latexField.text = nil
            return
        }
        
        let newText = renderMarkdown(markdownText: docText)
        latexField.attributedText = newText
    }
        
    
    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !docField.text.isEmpty {
            completion?(text, docField.text)
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

}
