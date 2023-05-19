//
//  ListViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var docLabel: UITextView!
    
    public var docTitle: String = ""
    public var doc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = docTitle
        docLabel.text = doc
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
