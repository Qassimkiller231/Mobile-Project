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
        Task {
            do {
                let jobs = try await Utilities.DataManager.shared.fetchAllJobs()
                currentJob = getJobByJobTitle(applicationJobTitle: application!, allJobs: jobs)
                print("\(currentJob!.jobTitle), \(currentJob!.jobSalary), \(currentJob!.company.location), \(currentJob!.jobSkills)")
                print("test2 \(currentUser?.skills)")
                if let compatibility = compareJobWithCompatibility(currentJob: currentJob!, jobCompatibilities: jobCompatibilities, profile: currentUser!) {
                    print("Salary Compatibility: \(compatibility.salary)%")
                    print("Qualifications Compatibility: \(compatibility.qualifications)%")
                    print("Commute Compatibility: \(compatibility.commute)%")
                    print("Preferences Compatibility: \(compatibility.preferences)%")
                    print("Final Compatibility: \(compatibility.final)%")
                } else {
                    print("No matching JobCompatibility object found.")
                }
                
            } catch {
                print("Failed to fetch jobs: \(error.localizedDescription)")
            }
        }
        
    }
    
    func compareJobWithCompatibility(
        currentJob: job,
        jobCompatibilities: [JobCompatibility],
        profile: JobSeeker
    ) -> (salary: Double, qualifications: Double, commute: Double, preferences: Double, final: Double)? {
        // Find the corresponding JobCompatibility object
        guard let jobCompatibility = jobCompatibilities.first(where: { $0.jobTitle == currentJob.jobTitle }) else {
            print("No JobCompatibility object found for the current job: \(currentJob.jobTitle)")
            return nil
        }

        // Weights for different attributes
        let salaryWeight = 20.0
        let qualificationsWeight = 30.0
        let commuteWeight = 20.0
        let preferencesWeight = 30.0
        let totalWeight = salaryWeight + qualificationsWeight + commuteWeight + preferencesWeight

        var salaryScore = 0.0
        var qualificationsScore = 0.0
        var commuteScore = 0.0
        var preferencesScore = 0.0

        // 1. Salary and Benefits
        if let currentJobSalary = Double(currentJob.jobSalary.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")) {
            let jobCompatibilitySalary = jobCompatibility.salary
            let difference = abs(currentJobSalary - jobCompatibilitySalary)
            salaryScore = difference <= 20000 ? salaryWeight : salaryWeight * (1 - (difference / 50000))
        }

        // 2. Qualifications Match
        if let profileSkills = profile.skills {
            let matchingQualifications = jobCompatibility.qualifications.filter { profileSkills.map { $0.skillName }.contains($0) }
            let qualificationsMatchRatio = Double(matchingQualifications.count) / Double(jobCompatibility.qualifications.count)
            qualificationsScore = qualificationsMatchRatio * qualificationsWeight
        } else if let profileExperience = profile.experiences {
            let relevantExperience = profileExperience.filter { $0.jobTitle == currentJob.jobTitle }
            qualificationsScore = !relevantExperience.isEmpty ? qualificationsWeight : 0
        }

        // 3. Commute Distance
        // Get categories for job and user locations
        print("Current job location: " + currentJob.company.location)
        commuteScore = calculateLocationScore(profileLocation: profile.location, jobLocation: currentJob.company.location, locationCategories: locationCategories, categoryDistances: categoryDistances)


        // 4. Preferences Match
        if let profilePreferences = profile.preferences {
            let matchingPreferences = jobCompatibility.preferences.filter { profilePreferences.contains($0) }
            let preferencesMatchRatio = Double(matchingPreferences.count) / Double(jobCompatibility.preferences.count)
            preferencesScore = preferencesMatchRatio * preferencesWeight
        }

        // Calculate final compatibility percentage
        let finalScore = (salaryScore + qualificationsScore + commuteScore + preferencesScore) / totalWeight * 100
        salaryPercentLabel.text = "\(Int((salaryScore / salaryWeight) * 100))%"
            qualificationsPercentLabel.text = "\(Int((qualificationsScore / qualificationsWeight) * 100))%"
            distancePercentLabel.text = "\(Int((commuteScore / commuteWeight) * 100))%"
            preferencesPercentLabel.text = "\(Int((preferencesScore / preferencesWeight) * 100))%"
            finalPercentLabel.text = "\(Int(finalScore))%"
        return (
            salary: (salaryScore / salaryWeight) * 100,
            qualifications: (qualificationsScore / qualificationsWeight) * 100,
            commute: (commuteScore / commuteWeight) * 100,
            preferences: (preferencesScore / preferencesWeight) * 100,
            final: finalScore
        )
    }
    
    func calculateLocationScore(profileLocation: String, jobLocation: String, locationCategories: [LocationCategory], categoryDistances: [CategoryDistance], maxDistanceThreshold: Double = 50.0) -> Double {
        // Helper function to get the category of a location
        func getCategory(for location: String) -> String? {
            for category in locationCategories {
                if category.locations.contains(location) {
                    return category.name
                }
            }
            return nil
        }
        


        // Get the categories for the profile location and job location
        let profileCategory = getCategory(for: profileLocation)
        let jobCategory = getCategory(for: jobLocation)

        print("Progile categ: \(profileCategory)")
        print("job Cat: \(jobCategory)")
        // Calculate the location score
        if let profileCategory = profileCategory, let jobCategory = jobCategory {
            if profileCategory == jobCategory {
                // Perfect match if the locations belong to the same category
                return 100.0 / 5
            } else if let distance = categoryDistances.first(where: { $0.from == profileCategory && $0.to == jobCategory })?.distance {
                // Normalize the distance to a percentage
                return min(100,(100 - distance)/10)
            }
        }

        // Return 0 if no matching category or distance is found
        return 0.0
    }
    
    
    
    
    
    
    func getJobByJobTitle(applicationJobTitle: String, allJobs: [job]) -> job? {
        // Iterate through all jobs
        for job in allJobs {
            // Check if the job has any applications
            if let jobApplications = job.applications, !jobApplications.isEmpty {
                // Check if the job title matches the provided application job title
                if job.jobTitle == applicationJobTitle {
                    return job // Return the matching job
                }
            }
        }
        
        print("No job found with title: \(applicationJobTitle)")
        return nil // Return nil if no match is found
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
    
    

