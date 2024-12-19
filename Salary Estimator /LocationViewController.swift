//
//  LocationViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 14/12/2024.
//

import UIKit

class LocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var locations:[String]=[
        "Bahrain","Saudi","India"
    ]
    var filteredLocations:[String]=[]
    
    var experience:[String]=[
        "no experience","some experience","very experience"
    ]
    var filteredExperiences:[String]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredLocations=locations
        filteredExperiences=experience
        
        for Subview in view.subviews{
            if let tableView=Subview as? UITableView{
                tableView.delegate=self
                tableView.dataSource=self
            }
            if let searchBar=Subview as? UISearchBar{
                searchBar.delegate=self
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag==1{
            return filteredLocations.count
        } else if tableView.tag==2{
            return filteredExperiences.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath)
        
        if tableView.tag==1{
            let job = filteredLocations[indexPath.row]
            cell.textLabel?.text=job
        } else if tableView.tag==2{
            let job = filteredExperiences[indexPath.row]
            cell.textLabel?.text=job
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.tag==1{
            if searchText.isEmpty{
                filteredLocations=locations
            } else {
                filteredLocations=locations.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
        } else if searchBar.tag==2{
            if searchText.isEmpty{
                filteredExperiences=experience
            } else {
                filteredExperiences=experience.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
        }
        if let tablevView = view.viewWithTag(searchBar.tag) as? UITableView{
            tablevView.reloadData()
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

}
