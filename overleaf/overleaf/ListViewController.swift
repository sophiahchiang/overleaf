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


class ListViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var docLabel: UITextView!
    @IBOutlet weak var latex: UIView!
    
    public var docTitle: String = ""
    public var doc: String = ""
    public var lat: UIView? {
        let text = "this is in **bold**"
            let downView = try? DownView(frame: CGRect(x: 0, y: 0, width: 200, height: 50), markdownString: text)
            return downView
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = docTitle
        docLabel.text = doc
        latex.addSubview(lat!)
        

            
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
