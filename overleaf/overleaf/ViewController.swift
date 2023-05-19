//
//  ViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit

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
            self.navigationController?.popToRootViewController(animated: true)
            self.models.append((title: docTitle, note: note))
            self.label.isHidden = true
            self.table.isHidden = false
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Show note controller
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? ListViewController else {
                return
        }
        vc.title = "Document"
        navigationController?.pushViewController(vc, animated: true)
    }

}

