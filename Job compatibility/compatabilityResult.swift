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
        
        
        
        guard let currentJob = currentJob, let jobCompat = jobCompat else {
                    print("Missing currentJob or jobCompat.")
                    updateLabelsToZero()
                    return
                }

                // Salary Percentage
                let salaryPercent = ((Double(currentJob.jobSalary) ?? 0) / jobCompat.salary) * 100
                salaryPercentLabel.text = String(format: "%.0f%%", salaryPercent)

                // Qualifications Percentage
                let qualiPercent = calculateQualificationsCompatibility()
                qualificationsPercentLabel.text = String(format: "%.0f%%", qualiPercent)

                // Preferences Percentage
                let preferencesPercent = calculatePreferencesCompatibility()
                preferencesPercentLabel.text = String(format: "%.0f%%", preferencesPercent)

                // Distance Percentage
                let distancePercent = calculateDistancePercentage()
                distancePercentLabel.text = String(format: "%.0f%%", distancePercent)

                // Final Compatibility Score
                let finalScore = (salaryPercent + qualiPercent + preferencesPercent + distancePercent) / 4
                finalPercentLabel.text = String(format: "%.0f%%", finalScore)
            }

            func calculateQualificationsCompatibility() -> Double {
                guard let experiences = currentUser?.experiences,
                      let qualifications = jobCompat?.qualifications else {
                    return 0.0
                }

                let matchCount = experiences.filter { qualifications.contains($0.jobTitle) }.count
                return (Double(matchCount) / Double(qualifications.count)) * 100
            }

            func calculatePreferencesCompatibility() -> Double {
                guard let jobCompat = jobCompat,
                      let preferences = jobCompat.preferences as? [String],
                      let userPreferences = currentUser?.preferences as? [String] else {
                    return 0.0
                }

                let matchCount = preferences.filter { userPreferences.contains($0) }.count
                return (Double(matchCount) / Double(preferences.count)) * 100
            }

    func calculateDistancePercentage() -> Double {
        if let jobCompat = jobCompat,
           let jobLocation = currentUser?.location,
           let userLocation = currentUser?.location {
            
            // Calculate distance
            if let distance = calculateDistance(jobLocation: jobLocation, userLocation: userLocation) {
                let maxDistance = categoryDistances.map { $0.distance }.max() ?? 1.0
                return max(0.0, (1 - (distance / maxDistance)) * 100)
            }
        }
        return 0.0
    }


            func calculateDistance(jobLocation: String, userLocation: String) -> Double? {
                let jobCategory = locationCategories.first { $0.locations.contains(jobLocation) }?.name
                let userCategory = locationCategories.first { $0.locations.contains(userLocation) }?.name

                if let jobCat = jobCategory, let userCat = userCategory {
                    return categoryDistances.first {
                        ($0.from == jobCat && $0.to == userCat) || ($0.from == userCat && $0.to == jobCat)
                    }?.distance
                }
                return nil
            }

            func updateLabelsToZero() {
                salaryPercentLabel.text = "0%"
                qualificationsPercentLabel.text = "0%"
                preferencesPercentLabel.text = "0%"
                distancePercentLabel.text = "0%"
                finalPercentLabel.text = "0%"
                
                
//        if resultType == .defaultWeight {
//            // Safely unwrap currentJob and jobCompat
//            if let currentJob = currentJob, let jobCompat = jobCompat {
//                // Calculate salary percentage
//                let salaryPercent = ((Double(currentJob.jobSalary) ?? 0) / jobCompat.salary) * 100
//                salaryPercentLabel.text = String(format: "%.0f%%", salaryPercent)
//            } else {
//                print("Current job or job compatibility is nil.")
//
//            }
//            
//            if let experiences = currentUser?.experiences,
//               let qualifications = jobCompat?.qualifications {
//                
//                var matchCount = 0
//
//                for experience in experiences {
//                    for qualification in qualifications {
//                        if experience.jobTitle == qualification {
//                            matchCount += 1
//                        }
//                    }
//                }
//                //let qualiPercent = matchCount/qualifications.count*100
//                let qualiPercent = (Double(matchCount) / Double(qualifications.count)) * 100
//                                   qualificationsPercentLabel.text = String(format: "%.0f%%", qualiPercent)
//                               } else {
//                                   qualificationsPercentLabel.text = "0%"
//                               }
//            
//            // Calculate preferences percentage
//                        let preferencesPercent = calculatePreferencesCompatibility()
//                        preferencesPercentLabel.text = String(format: "%.0f%%", preferencesPercent)
//
//            // Calculate distance percentage
//                        let distancePercent = calculateDistancePercentage()
//                        distancePercentLabel.text = String(format: "%.0f%%", distancePercent)
//            }
//
//        }
//    func calculatePreferencesCompatibility() -> Double {
//            guard let jobCompat = jobCompat,
//                  let preferences = jobCompat.preferences as? [String],
//                  let userPreferences = currentUser?.preferences as? [String] else {
//                return 0.0
//            }
//            
//            let matchCount = preferences.filter { userPreferences.contains($0) }.count
//            let preferencesPercent = (Double(matchCount) / Double(preferences.count)) * 100
//            
//            return preferencesPercent
//        
//    }
//    
//    func calculateDistancePercentage() -> Double {
//        guard let jobCompat = jobCompat else {
//            return 0.0
//        }
//        
//        let jobLocation = jobCompat.location // Directly use jobLocation
//        guard let userLocation = currentUser?.location else {
//            return 0.0 // Return 0 if userLocation is nil
//        }
//        
//        // Calculate the distance between job's location and user's location
//        if let distance = calculateDistance(jobLocation: jobLocation, userLocation: userLocation) {
//            // Assuming the maximum distance is the highest value in categoryDistances
//            let maxDistance = categoryDistances.map { $0.distance }.max() ?? 1.0 // Avoid division by zero
//            let distancePercent = (1 - (distance / maxDistance)) * 100 // Inverted percentage
//            return distancePercent
//        }
//        return 0.0
//            }
//
//            func calculateDistance(jobLocation: String, userLocation: String) -> Double? {
//                // Determine job category
//                let jobCategory = locationCategories.first { category in
//                    category.locations.contains(jobLocation)
//                }?.name
//
//                // Determine user category
//                let userCategory = locationCategories.first { category in
//                    category.locations.contains(userLocation)
//                }?.name
//
//                // If both categories are found, calculate distance
//                if let jobCat = jobCategory, let userCat = userCategory {
//                    return categoryDistances.first { (dist) in
//                        (dist.from == jobCat && dist.to == userCat) || (dist.from == userCat && dist.to == jobCat)
//                    }?.distance
//                }
//                return nil // Return nil if no category found
            }
    
        }
    
    

