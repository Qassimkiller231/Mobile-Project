//
//  AdminHomePageViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 25/12/2024.
//

import UIKit

class AdminHomePageViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var notificationImageView: UIImageView!
    
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var currentJob:job?
    var displayedJobs:[job] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(AdminJobListingCardTableViewCell.nib(), forCellReuseIdentifier: AdminJobListingCardTableViewCell.identifier)
        displayedJobs = jobs
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayedJobs = jobs
        tableView.reloadData()
        print("Table view reloaded when returning to main view controller")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedJobs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdminJobListingCardTableViewCell.identifier, for: indexPath) as! AdminJobListingCardTableViewCell
        cell.configure(with: displayedJobs[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentJob = displayedJobs[indexPath.row]
        performSegue(withIdentifier: "AdminToJobDetails", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            displayedJobs = jobs
        } else {
            displayedJobs = jobs.filter { $0.jobTitle.lowercased().starts(with:searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AdminToJobDetails" {
            let vc = segue.destination as! AdminJobDetailsViewController
            vc.job = currentJob
        }
        
    }
    

}
