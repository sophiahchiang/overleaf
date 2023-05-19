//
//  ViewController.swift
//  overleaf
//
//  Created by Sophia Chiang on 5/18/23.
//

import UIKit
import Down
import MobileCoreServices



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate, ListViewControllerDelegate {

    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    var models: [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Documents"
        
        table.dragInteractionEnabled = true
        table.dragDelegate = self
        table.dropDelegate = self
        
        let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.spacing = 10
                stackView.alignment = .center
            
                let imageView = UIImageView(image: UIImage(named: "Overleaf_Logo.png"))
                imageView.alpha = 0.5
                imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                imageView.contentMode = .scaleAspectFit
                
                stackView.addArrangedSubview(imageView)
                
                view.addSubview(stackView)
                view.sendSubviewToBack(stackView)
                
                stackView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.attributedText = renderMarkdown(markdownText: models[indexPath.row].note)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = models[indexPath.row]

        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? ListViewController else {
                return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Document"
        vc.docTitle = model.title
        vc.doc = model.note
        vc.delegate = self
        vc.selectedIndex = indexPath.row
        
        vc.updateTitleHandler = { [weak self] newTitle in
                self?.models[indexPath.row].title = newTitle
                self?.table.reloadData()
            }
        
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func updateDocument(doc: String, atIndex index: Int) {
            models[index].note = doc
            table.reloadData()
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
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let model = models[indexPath.row]
        let itemProvider = NSItemProvider(object: model.title as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = model
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }

        for item in coordinator.items {
            if let sourceIndexPath = item.sourceIndexPath, let model = item.dragItem.localObject as? (title: String, note: String) {
                tableView.performBatchUpdates {
                    models.remove(at: sourceIndexPath.row)
                    models.insert(model, at: destinationIndexPath.row)
                    tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
                }
                coordinator.drop(item.dragItem, toRowAt: destinationIndexPath)
            }
        }
    }
    
        func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
            return session.hasItemsConforming(toTypeIdentifiers: [kUTTypePlainText as String])
        }

        func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
            if session.localDragSession != nil {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    

}

