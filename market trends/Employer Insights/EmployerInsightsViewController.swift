//
//  page4ViewController.swift
//  M12
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 09/12/2024.
//

import UIKit

class EmployerInsightsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var profile : JobSeeker?
    var profileApplications : [application]?
    override func viewDidLoad() {
        super.viewDidLoad()
        profile = SampleProfile2
        profileApplications = profile?.applications
        employerInsights = sampleJobs2
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployerInsightsTableViewCell.nib(), forCellReuseIdentifier: EmployerInsightsTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employerInsights.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployerInsightsTableViewCell.identifier, for: indexPath) as! EmployerInsightsTableViewCell
        cell.configure(with: employerInsights[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 158
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
