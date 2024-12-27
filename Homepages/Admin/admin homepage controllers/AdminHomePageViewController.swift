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
    
    @IBOutlet weak var profilePicImage: UIImageView!
    var currentJob:job?
    var displayedJobs:[job] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.register(AdminJobListingCardTableViewCell.nib(), forCellReuseIdentifier: AdminJobListingCardTableViewCell.identifier)
        displayedJobs = jobs
        profilePicImage.isUserInteractionEnabled = true

            // Create and add the tap gesture recognizer
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOverlayButton(_:)))
            profilePicImage.addGestureRecognizer(tapGesture)
        
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
    
    @IBAction func showOverlayButton(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
            
            // Instantiate ProfileOverlayViewController
            let overlayVC = ProfileOverlayViewController(nibName: "ProfileOverlayViewController", bundle: nil)
            
            // Set the presentation style for an overlay effect
            overlayVC.modalPresentationStyle = .overCurrentContext
            overlayVC.modalTransitionStyle = .crossDissolve // Smooth fade-in effect
            
            // Present the overlay and show the tab bar again after dismissing
            overlayVC.dismissCompletion = { [weak self] in
                self?.tabBarController?.tabBar.isHidden = false
            }
            
            self.present(overlayVC, animated: true, completion: nil)
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
