//
//  PBPreferencesViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 23/12/2024.
//

import UIKit

class PBPreferencesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UISearchBarDelegate {
    
    
    
    
    var jobSeeker: JobSeeker?
    
    enum JobType: String {
        case fullTime = "Full-Time"
        case partTime = "Part-Time"
        case freelance = "Freelance"
        case internship = "Internship"
        case projectBased = "Project-Based"
    }

    var selectedJobType: JobType?
    var preferenceList: [String] = [] // List of selected preferences
      var model: [String] = ["Programming", "Design", "Marketing", "Finance","Test1","Test2","John"] // Example data
    var filteredModel : [String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fullTimeJobButton: UIButton!
    @IBOutlet weak var partTimeJobButton: UIButton!
    @IBOutlet weak var freelanceButton: UIButton!
    @IBOutlet weak var internshipButton: UIButton!
    @IBOutlet weak var projectBasedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        searchBar.delegate = self
        filteredModel = model
        collectionView.register(PreferenceCollectionViewCell.nib(), forCellWithReuseIdentifier: PreferenceCollectionViewCell.identifier)
        // Do any additional setup after loading the view.
            
    }
    

    @IBAction func fullTimeJobButtonPressed(_ sender: Any) {
        selectJobType(.fullTime)
    }
    @IBAction func partTimeJobButtonPressed(_ sender: Any) {
        selectJobType(.partTime)
    }
    @IBAction func freelanceButtonPressed(_ sender: Any) {
        selectJobType(.freelance)
    }
    @IBAction func internshipButtonPressed(_ sender: Any) {
        selectJobType(.internship)
    }
    @IBAction func projectBasedButtonPressed(_ sender: Any) {
        selectJobType(.projectBased)
    }
    
    @IBAction func saveAllButtonPressed(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToExperience" {
            if let expVC = segue.destination as? PBExperienceViewController {
                expVC.jobSeeker = self.jobSeeker
            }
        }
    }
    
    private func selectJobType(_ jobType: JobType) {
        selectedJobType = jobType

        // Reset opacity for all buttons
        fullTimeJobButton.alpha = 0.5
        partTimeJobButton.alpha = 0.5
        freelanceButton.alpha = 0.5
        internshipButton.alpha = 0.5
        projectBasedButton.alpha = 0.5

        // Set full opacity for the selected button
        switch jobType {
        case .fullTime:
            fullTimeJobButton.alpha = 1.0
        case .partTime:
            partTimeJobButton.alpha = 1.0
        case .freelance:
            freelanceButton.alpha = 1.0
        case .internship:
            internshipButton.alpha = 1.0
        case .projectBased:
            projectBasedButton.alpha = 1.0
        }
        
        print("selected job type: \(selectedJobType ?? .fullTime)")
    }
    
    
//    MARK: Collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreferenceCollectionViewCell", for: indexPath) as! PreferenceCollectionViewCell
        let preference = filteredModel[indexPath.row]
        cell.button.setTitle(preference, for: .normal)
//        cell.configure(with: preference)
        cell.onButtonToggle = { [weak self] title, isSelected in
            guard let self = self else { return }
            if isSelected {
                self.preferenceList.append(title) // Add to the list
            } else {
                self.preferenceList.removeAll { $0 == title } // Remove from the list
            }
            print("Updated Preference List: \(self.preferenceList)")
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredModel = model
        } 
        else {
            filteredModel = model.filter({ $0.lowercased().starts(with: searchText.lowercased())})
        }
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    


}


