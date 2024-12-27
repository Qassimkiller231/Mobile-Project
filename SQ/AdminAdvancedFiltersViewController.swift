//
//  AdminAdvancedFiltersViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 26/12/2024.
//

import UIKit

class AdminAdvancedFiltersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var selectedSection:Section?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(dropdownCell.nib(), forCellReuseIdentifier: dropdownCell.identifier)
        // Do any additional setup after loading the view.
    }
//    //    update the viewWillAppear so that the tabBar is hidden in this page
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            self.tabBarController?.tabBar.isHidden = true // Hide the tab bar
//        }
//        
//        
//    // add the tabbar back before going to another page
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            self.tabBarController?.tabBar.isHidden = false // Show the tab bar again
//        }
    func numberOfSections(in tableView: UITableView) -> Int {
        return adminSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adminSections[section].isExpanded ? adminSections[section].options!.count + 1 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: dropdownCell.identifier, for: indexPath) as! dropdownCell
            cell.configure(with: adminSections[indexPath.section].title)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
            cell.textLabel?.text = adminSections[indexPath.section].options![indexPath.row - 1]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        adminSections[indexPath.section].isExpanded.toggle()
        if indexPath.row != 0 {
            selectedSection = adminSections[indexPath.section]
            performSegue(withIdentifier: "AdminFilterToManageFilter", sender: nil)
            
        }
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdminFilterToManageFilter" {
            let destinationVC = segue.destination as! ManageFilterViewController
            destinationVC.selectedSection = selectedSection
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
