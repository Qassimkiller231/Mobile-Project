//
//  IndustryTypeViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 14/12/2024.
//

import UIKit

class IndustryTypeViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    var industries: [String] = ["Agriculture","Automotive","Banking","Consulting","Education","Healthcare","Energy","Finance","Food","Fitness","Insurance","Technology","Travel"]
    var filteredIndustries: [String] = []
    @IBOutlet var tableview: UITableView!
    @IBOutlet var searchbar: UISearchBar!
    var selectedFilters: [String:String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        searchbar.delegate = self
        filteredIndustries = industries
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredIndustries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = filteredIndustries[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilters["Industry"] = filteredIndustries[indexPath.row]
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                    if searchText.isEmpty{
                        filteredIndustries = industries
            } else {
                filteredIndustries = industries.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
        
    tableview.reloadData()
        
    }
    
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFinalFilters" {
            let vc = segue.destination as! FinalEstimatedSalaryViewController
            vc.selectedFilters = self.selectedFilters
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
