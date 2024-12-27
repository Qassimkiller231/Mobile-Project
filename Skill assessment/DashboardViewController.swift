//
//  DashboardViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 15/12/2024.
//

import UIKit

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
    @IBOutlet weak var languageTableView: UITableView!
    
    @IBOutlet weak var difficultyTableView: UITableView!
    
    @IBOutlet weak var testTableView: UITableView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    @IBOutlet weak var selectedTypeLabel: UILabel!
    
    @IBOutlet weak var selectedDiffLabel: UILabel!
    
    var dashboard : SkillAssessmentDashboard?
    var difficultyTableIsExpanded : Bool = false
    var languageTableIsExpanded : Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testTableView.register(TestTableViewCell.nib(), forCellReuseIdentifier: TestTableViewCell.identifier)
        languageTableView.delegate = self
        languageTableView.dataSource = self
        difficultyTableView.dataSource = self
        difficultyTableView.delegate = self
        testTableView.dataSource = self
        testTableView.delegate = self
        TitleLabel.text = dashboard?.name ?? "No name"
        languageTableView.register(HeaderDashboardTableViewCell.nib(), forCellReuseIdentifier: HeaderDashboardTableViewCell.identifier)
        difficultyTableView.register(HeaderDashboardTableViewCell.nib(), forCellReuseIdentifier: HeaderDashboardTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == languageTableView{
            
            return languageTableIsExpanded ? 1 + (dashboard?.filter1Options.count ?? 0) : 1
        } else if tableView == difficultyTableView{
            return difficultyTableIsExpanded ? 1 +  (dashboard?.difficultyOptions.count ?? 0) : 1
        } else {
            return dashboard?.tests.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderDashboardTableViewCell.identifier, for: indexPath) as! HeaderDashboardTableViewCell
            if tableView == languageTableView{
                cell.titleLabel.text = dashboard?.filter1 ?? ""
            } else {
                cell.titleLabel.text = dashboard?.difficulty ?? ""
            }
           
            return cell
        }
        if tableView == testTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.identifier, for: indexPath) as! TestTableViewCell
            cell.configure(with: dashboard?.tests[indexPath.row].testTitle ?? "")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if tableView == languageTableView{
                cell.textLabel?.text = dashboard?.filter1Options[indexPath.row - 1] ?? ""
            } else if tableView == difficultyTableView{
                cell.textLabel?.text = dashboard?.difficultyOptions[indexPath.row - 1] ?? ""
            }
            return cell
        }
         
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == languageTableView{
            languageTableIsExpanded.toggle()
            if indexPath.row != 0 {
                selectedTypeLabel.text = dashboard?.filter1Options[indexPath.row - 1]
            }
        } else if tableView == difficultyTableView{
            difficultyTableIsExpanded.toggle()
            if indexPath.row != 0 {
                selectedDiffLabel.text = dashboard?.difficultyOptions[indexPath.row - 1]
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func languageButtonTapped(_ sender: Any) {
        languageTableView.isHidden.toggle()
    }
    
    @IBAction func DifficultyButtonTapped(_ sender: Any) {
        difficultyTableView.isHidden.toggle()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
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
