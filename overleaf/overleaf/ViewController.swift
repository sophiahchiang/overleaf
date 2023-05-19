//
//  ViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit
import Down
import LaTeXSwiftUI
import SwiftUI

//iosMATH is the ANSWER
//import Down



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var models: [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Documents"
    }
    
    @IBAction func didTapNewDoc() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? DocViewController else {
            return
        }
        vc.title = "New Document"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { docTitle, note in
            self.models.append((title: docTitle, note: note))
            self.label.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
            self.navigationController?.popToRootViewController(animated: true)

        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let model = models[indexPath.row]

        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note

//        let markdownString = model.note
//            downView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            cell.contentView.addSubview(downView ?? UIView())

        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = models[indexPath.row]
        
        // Show note controller
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? ListViewController else {
                return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Document"
        vc.docTitle = model.title
        vc.doc = model.note
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

}

