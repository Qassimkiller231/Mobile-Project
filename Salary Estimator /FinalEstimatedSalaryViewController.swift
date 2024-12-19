//
//  FinalEstimatedSalaryViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 14/12/2024.
//

import UIKit

class FinalEstimatedSalaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var model: [estimatedJob] = FinalEstimatedSalaries
    var filteredModel: [estimatedJob] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        filteredModel = model
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        cell.configure(with: filteredModel[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredModel = model
        } else {
            filteredModel = model.filter({ $0.jobTitle.lowercased().starts(with: searchText.lowercased()) })
            
        }
        tableView.reloadData()
    }
    

}
