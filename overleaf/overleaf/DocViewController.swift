//
//  DocViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit
import SwiftUI
import Down

class DocViewController: UIViewController {
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var docField: UITextView!
    var additionalWindows = [UIWindow]()

    
    public var completion: ((String, NSAttributedString) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        
        
        NotificationCenter.default.addObserver(forName: UIScreen.didConnectNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            
            guard let newScreen = notification.object as? UIScreen else { return }
            let screenDimensions = newScreen.bounds
            
            let newWindow = UIWindow(frame: screenDimensions)
            newWindow.screen = newScreen
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController else {
                fatalError("Unable to find PreviewViewController")
            }
            
            newWindow.rootViewController = vc
            newWindow.isHidden = false
            self.additionalWindows.append(newWindow)
            
            self.textViewDidChange(self.docField) //Mistake?
        }
        
        NotificationCenter.default.addObserver(forName: UIScreen.didDisconnectNotification, object: nil, queue: nil) { [weak self] notification in
            guard let self = self else { return }
            
            guard let oldScreen = notification.object as? UIScreen else { return }
            
            if let window = self.additionalWindows.firstIndex(where: {
                $0.screen == oldScreen
            }) {
                self.additionalWindows.remove(at: window)
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let preview = additionalWindows.first?.rootViewController as? PreviewViewController {
            preview.text = textView.text
        }
        
        if let navController = splitViewController?.viewControllers.last as? UINavigationController {
            if let preview = navController.topViewController as? PreviewViewController {
                preview.text = textView.text
            }
        }
    }
    
    
    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !docField.text.isEmpty {
                var new: String = "" {
                didSet {
                    let down = Down(markdownString: new)
                    let style = "body { font: 200% sans-serif; }"
                    let attributedString = try? down.toAttributedString(stylesheet: style)
                    docField.attributedText = attributedString
                }
            }
            completion?(text, docField.attributedText)
        }
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

