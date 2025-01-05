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
    var selectedFilters: [String:String] = [:]
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
        return 1
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
    
    // MARK: - Filtering Function
    
    func filterJobs(jobs: [estimatedJob], selectedFilters: [String: String]) -> [estimatedJob] {
        return jobs.filter { job in
            // Check if each filter is met
            var matches = true
            
            if let locationFilter = selectedFilters["Location"], !locationFilter.isEmpty {
                // Assuming job has a property 'location' that you need to compare
                // matches = matches && job.location == locationFilter
            }
            
            if let experienceFilter = selectedFilters["Experience"], !experienceFilter.isEmpty {
                matches = matches && job.experience == experienceFilter
            }
            
            if let industryFilter = selectedFilters["Industry"], !industryFilter.isEmpty {
                matches = matches && job.industry == industryFilter
            }
            
            return matches
        }
    }
}
