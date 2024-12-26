//
//  CompanyProfileTableViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 26/12/2024.
//

import UIKit

class CompanyProfileTableViewController: UITableViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var industryTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var aboutUsTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Populate the UI elements
        companyNameTextField.text = companyProfile.companyName
        industryTextField.text = companyProfile.industry
        websiteTextField.text = companyProfile.website
        locationTextField.text = companyProfile.location
        aboutUsTextField.text = companyProfile.aboutUs
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
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
