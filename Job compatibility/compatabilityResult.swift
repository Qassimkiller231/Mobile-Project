//
//  compatabilityResult.swift
//  testfinalfinal
//
//  Created by Guest User on 19/12/2024.
//

import UIKit

class compatabilityResult: UIViewController {
    @IBOutlet weak var salaryPercentLabel: UILabel!
    @IBOutlet weak var qualificationsPercentLabel: UILabel!
    @IBOutlet weak var distancePercentLabel: UILabel!
    @IBOutlet weak var preferencesPercentLabel: UILabel!
    @IBOutlet weak var finalPercentLabel: UILabel!
    
    
    
    enum CompatibilityResult {
        case defaultWeight
        case customWeight
    }
    var currentUser: JobSeeker?
    var currentJob: job?
    var application : String?
    var jobCompat: JobCompatibility?
    var resultType : CompatibilityResult = .defaultWeight

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the selected option is already passed, update the label
        
        currentUser = SampleProfile
        if let jobTitle = currentJob?.jobTitle {
                   jobCompat = jobCompatibilities.first { $0.jobTitle == jobTitle }
        }
        calculatePercentages()
    }
    
    // MARK: - Delegate Method (if you want to use it here)
    func calculatePercentages() {
        if resultType == .defaultWeight {
            // Safely unwrap currentJob and jobCompat
            if let currentJob = currentJob, let jobCompat = jobCompat {
                // Calculate salary percentage
                let salaryPercent = ((Double(currentJob.jobSalary) ?? 0) / jobCompat.salary) * 100
                salaryPercentLabel.text = String(salaryPercent) + "%"
            } else {
                print("Current job or job compatibility is nil.")

            }
            
            if let experiences = currentUser?.experiences,
               let qualifications = jobCompat?.qualifications {
                
                var matchCount = 0

                for experience in experiences {
                    for qualification in qualifications {
                        if experience.jobTitle == qualification {
                            matchCount += 1
                        }
                    }
                }
                let qualiPercent = matchCount/qualifications.count*100
                
            }

        }
    }
    
}
