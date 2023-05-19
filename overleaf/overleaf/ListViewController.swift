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


class LaTeXData: ObservableObject {
    @Published var latex: String = ""
}

class ListViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var docLabel: UITextView!
    
    var latexData = LaTeXData()
    public var docTitle: String = ""
    public var doc: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = docTitle
        docLabel.text = doc
            
//        do {
//                let down = Down(markdownString: doc)
//                let latex = try down.toLaTeX()
//                docLabel.text = latex
//            } catch {
//                print("Error converting markdown to LaTeX: \(error)")
//            }
        
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
