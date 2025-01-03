//
//  CheckCompatibilityViewController.swift
//  testfinalfinal
//
//  Created by Scoobysnac on 15/12/2024.
//

import UIKit


class CheckCompatibilityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model: [table] = sampleTableData
    var filteredApplications : [application] = []
    var currentProfile : JobSeeker?
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var CheckResultButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentProfile = SampleProfile
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DropDownTableViewCell.nib(), forCellReuseIdentifier: DropDownTableViewCell.identifier)
//        tableView.backgroundColor = .clear
        filteredApplications = filterApplicationsByProfile(applications: sampleApplications, profile: currentProfile! )
        updateModelData()
    }

    // MARK: - TableView Methods
    
    func updateModelData() {
        for application in filteredApplications {
            if let jobTitle = application.jobTitle{
                model[0].options.append(jobTitle)
            }

        }
    }
    
    func filterApplicationsByProfile(applications: [application], profile: JobSeeker) -> [application] {
        return applications.filter { $0.jobSeeker.userID == profile.userID }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].isExpanded ? model[section].options.count + 1 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier) as! DropDownTableViewCell
            let title = model[indexPath.section].selectedOption ?? model[indexPath.section].title
            cell.configure(with: title)
//            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Options", for: indexPath)
            cell.textLabel?.text = model[indexPath.section].options[indexPath.row - 1]
            cell.backgroundColor = .clear
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model[indexPath.section].isExpanded.toggle()
        if indexPath.row != 0 {
            let selectedOption = model[indexPath.section].options[indexPath.row - 1]
            model[indexPath.section].selectedOption = selectedOption
        }
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 181
        }else {
            return 80
        }
    }
    
    @IBAction func CheckResultTapped(_ sender: Any) {
        var identifier: String = ""
        if model[1].selectedOption == "Custom" {
            identifier = "compatibilityToCustomWeight"
        } else {
            identifier = "CompatibilityToResults"
        }
        performSegue(withIdentifier: identifier, sender: nil)
    }
    

    // Prepare for segue to Controller 2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "compatibilityToResult" {
            let vc = segue.destination as! compatabilityResult
            vc.application =  model[0].selectedOption
        }
    }
}
