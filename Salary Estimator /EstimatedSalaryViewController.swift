//
//  EstimatedSalaryViewController.swift
//  testfinalfinal
//
//
//

import UIKit

class EstimatedSalaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var model = estimatedSalaries
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        Task {
            do {
                let estimatedJobs1 = try await Utilities.DataManager.shared.fetchAllEstimatedJobs()
                model = estimatedJobs1 // this is for the page only
                estimatedSalaries = estimatedJobs1 // this is for filtering for next pages
                tableView.reloadData()
                print("Fetched Estimated Jobs: \(estimatedJobs1)")
            } catch {
                print("Error fetching estimated jobs: \(error.localizedDescription)")
            }
        } // fetching
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifier, for: indexPath) as! MyTableViewCell
        cell.configure(with: model[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
