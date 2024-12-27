//
//  JobSeekerHomepageViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class employerHomePage: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var CompanyJobs : [job]?
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOverlayButton(_:)))
            profilePicImage.addGestureRecognizer(tapGesture)
            
            // Set up layout
//            table view commands
            tableView.delegate = self
            tableView.dataSource = self
//            tableView.register(applicationTableViewCell.nib(), forCellReuseIdentifier: applicationTableViewCell.identifier)
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CompanyJobs?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: applicationTableViewCell.identifier, for: indexPath) as! applicationTableViewCell
//        cell.configure(with: CompanyJobs![indexPath.row])
//        return cell
        let cell = UITableViewCell()
        return cell
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
    
    }



    
//    Table view functions
    
    

