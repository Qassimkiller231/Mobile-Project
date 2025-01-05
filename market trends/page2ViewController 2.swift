//
//  page2ViewController.swift
//  M12
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 08/12/2024.
//

import UIKit

class page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var careerPaths: [(category: String, matches: [CareerPath], isExpanded: Bool)] = []
    var currentProfile: JobSeeker?
    override func viewDidLoad() {
        currentProfile = Utilities.DataManager.shared.profile as? JobSeeker
        
        tableview.register(SuggestedPathsTableViewCell.nib(), forCellReuseIdentifier: SuggestedPathsTableViewCell.identifier)
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        Utilities.DataManager.shared.fetchAllCareerPaths {
            [weak self] fetchedPaths in DispatchQueue.main.async { [self] in
                allCareerPaths = fetchedPaths
                self?.loadCareerPathsGrouped()
                self?.careerPaths = (self?.getMatchedCategories(for: self!.currentProfile!, from: careerPathsGrouped))!
                self?.tableview.reloadData()
            }
        }
        // Do any additional setup after loading the view.
        
               
    }
    
    func loadCareerPathsGrouped() {
         careerPathsGrouped  = [
            (
                category: "Software Development",
                paths: allCareerPaths.filter { $0.position == .SoftwareEngineer || $0.position == .MobileAppDeveloper || $0.position == .EmbeddedSystemsEngineer || $0.position == .GameDeveloper }
            ),
            (
                category: "Data and Analytics",
                paths: allCareerPaths.filter { $0.position == .DataScientist || $0.position == .DatabaseAdministrator || $0.position == .DataVisualizationSpecialist || $0.position == .MachineLearningEngineer }
            ),
            (
                category: "Networking and Cloud",
                paths: allCareerPaths.filter { $0.position == .CloudEngineer || $0.position == .NetworkAdministrator || $0.position == .DevOpsEngineer || $0.position == .SystemArchitect }
            ),
            (
                category: "Security and IT Support",
                paths: allCareerPaths.filter { $0.position == .CyberSecuritySpecialist || $0.position == .PenetrationTester || $0.position == .ITSupportSpecialist }
            ),
            (
                category: "IT Leadership and Management",
                paths: allCareerPaths.filter { $0.position == .ITManager || $0.position == .UXDesigner || $0.position == .RoboticsEngineer || $0.position == .BlockchainDeveloper }
            )
        ]
        
    }
    func getMatchedCategories(for jobSeeker: JobSeeker, from allCareerPathsGrouped: [(category: String, paths: [CareerPath])]) -> [(category: String, matches: [CareerPath], isExpanded: Bool)] {
        var matchedCategories: [(category: String, matches: [CareerPath], isExpanded: Bool)] = []

        for (category, paths) in allCareerPathsGrouped {
            // Find matching CareerPaths for skills or preferences
            let matchingPaths = paths.filter { careerPath in
                // Check if any JobSeeker skill matches the CareerPath skills
                let skillMatch = jobSeeker.skills?.contains { seekerSkill in
                    careerPath.skills.contains { pathSkill in pathSkill.skillName == seekerSkill.skillName }
                } ?? false

                // Check if any JobSeeker preference matches the CareerPath interests
                let preferenceMatch = jobSeeker.preferences?.contains { preference in
                    careerPath.interests.contains(preference)
                } ?? false

                return skillMatch || preferenceMatch
            }

            // Add category with `isExpanded = false` if there are matching paths
            if !matchingPaths.isEmpty {
                matchedCategories.append((category: category, matches: matchingPaths, isExpanded: false))
            }
        }

        return matchedCategories
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return careerPaths.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return careerPaths[section].isExpanded ?  1 + careerPaths[section].matches.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
                // Header cell
                let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedPathsTableViewCell.identifier, for: indexPath) as! SuggestedPathsTableViewCell
            cell.configure(with: careerPaths[indexPath.section].category) // Use the title for the header
                return cell
            } else {
                // Option cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath)
                cell.textLabel?.text = careerPaths[indexPath.section].matches[indexPath.row - 1].position .rawValue// Adjust the index
                return cell
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            careerPaths[indexPath.section].isExpanded.toggle()
            tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
        }
        
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


