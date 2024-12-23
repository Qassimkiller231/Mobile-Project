//
//  page2ViewController.swift
//  M12
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 08/12/2024.
//

import UIKit

class page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var sections: [Section1] = [
        Section1(title: "Section 1", text: ["Item 1", "Item 2", "Item 3"]),
        Section1(title: "Section 2", text: ["Item 4", "Item 5", "Item 6"]),
        Section1(title: "Section 3", text: ["Item 7", "Item 8", "Item 9"])
    ]
    override func viewDidLoad() {
        tableview.register(SuggestedPathsTableViewCell.nib(), forCellReuseIdentifier: SuggestedPathsTableViewCell.identifier)
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        // Do any additional setup after loading the view.
        
        
               
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].isExpanded ? 1 + sections[section].text.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
                // Header cell
                let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedPathsTableViewCell.identifier, for: indexPath) as! SuggestedPathsTableViewCell
                cell.configure(with: sections[indexPath.section].title) // Use the title for the header
                return cell
            } else {
                // Option cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath)
                cell.textLabel?.text = sections[indexPath.section].text[indexPath.row - 1] // Adjust the index
                return cell
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            sections[indexPath.section].isExpanded.toggle()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
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


