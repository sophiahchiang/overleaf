//
//  PreviewViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/19/23.
//

import Down
import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet var outputView: UITextView!
    
    var text: String = "" {
        didSet {
            let down = Down(markdownString: text)
            let style = "body { font: 200% sans-serif; }"
            let attributedString = try? down.toAttributedString(stylesheet: style)
            outputView.attributedText = attributedString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
