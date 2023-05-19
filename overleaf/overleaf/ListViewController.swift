//
//  ListViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit
import LaTeXSwiftUI
import Down
import MathJaxSwift
import SwiftUI


class ListViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var docLabel: UITextView!
    @IBOutlet weak var latex: UIView!
    var additionalWindows = [UIWindow]()

    
    public var docTitle: String = ""
    public var doc = NSAttributedString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = docTitle
        docLabel.attributedText = doc
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
