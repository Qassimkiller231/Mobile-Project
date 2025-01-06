//
//  LocationViewController.swift
//  testfinalfinal
//
//
//

import UIKit

class LocationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    var locations:[String]=[
        "Bahrain","Saudi Arabia","India"
    ]
    var filteredLocations:[String]=[]
    
    var experience:[String]=[
        "no experience" ,"1 year","2 years","3 years","4 years","5 years","6 years","7 years","8 years","9 years","10 years","11 years","12 years","13 years","14 years","15 years","16 years","17 years","18 years","19 years","20 years","21 years","22 years","23 years","24 years","25 years","26 years","27 years","28 years","29 years","30 years"
    ]
    
    var filteredExperiences:[String]=[]
    
    @IBOutlet weak var selectedLocation: UILabel!
    
    @IBOutlet weak var selectedExperience: UILabel!
    
    var selectedFilters:[String:String]=[:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredLocations=locations // this is to show all locations at first
        filteredExperiences=experience // this is to show all experiences at first
        
        for Subview in view.subviews{
            if let tableView=Subview as? UITableView{
                tableView.delegate=self
                tableView.dataSource=self
            }
            if let searchBar=Subview as? UISearchBar{
                searchBar.delegate=self
            }
        } // i did this because i used tags
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag==1{
            selectedLocation.text = filteredLocations[indexPath.row]
            selectedFilters["Location"]=filteredLocations[indexPath.row]
        } else {
            selectedExperience.text = filteredExperiences[indexPath.row]
            selectedFilters["Experience"]=filteredExperiences[indexPath.row]
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.tag==1{
            if searchText.isEmpty{
                filteredLocations=locations
            } else {
                filteredLocations=locations.filter({ $0.lowercased().starts(with:searchText.lowercased()) })
            }
        } else if searchBar.tag==2{
            if searchText.isEmpty{
                filteredExperiences=experience
            } else {
                filteredExperiences=experience.filter({ $0.lowercased().starts(with: searchText.lowercased()) })
            }
        }
        if let tablevView = view.viewWithTag(searchBar.tag) as? UITableView{
            tablevView.reloadData()
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIndustry"{
            let vc = segue.destination as! IndustryTypeViewController
            vc.selectedFilters = self.selectedFilters
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
