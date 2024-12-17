//
//  Models.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import Foundation
// this is the job struct for the homepage
struct job {
    static var ids: Int = 1
    var id: Int
    var jobName: String
    var profilePicture: String
    var companyName: String
    var companyLocation: String
    var filters: [String]
    var time: String
    var salary: Int
    var type: String
    var isBookmarked: Bool = false
    init(jobName: String, profilePicture: String, companyName: String, companyLocation: String, filters: [String], time: String, salary: Int, type: String) {
        self.jobName = jobName
        self.profilePicture = profilePicture
        self.companyName = companyName
        self.companyLocation = companyLocation
        self.filters = filters
        self.time = time
        self.salary = salary
        self.type = type
        job.ids += 1
        self.id = job.ids
    }
}
// this is the jobSeeker homepage job listing model
var jobs: [job] = [
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain", companyLocation: "Aali,Bahrain", filters: ["Senior","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo")
    
]
var bookmarkedJobs: [job] = []

// this is the section for advanced filters
struct Section {
    let title: String
    var isExpanded: Bool
    var options: [String] // Dropdown options for sections that use dropdowns
    var selectedOption: String? // Selected dropdown option (if applicable)
    var minSalary: Int? // Minimum Salary (as an integer value)
    var maxSalary: Int? // Maximum Salary (as an integer value)
}

// this is the main advanced filters Model
var sections: [Section] = [
    Section(title: "Job Category", isExpanded: false, options: ["Option 1", "Option 2"], selectedOption: nil, minSalary: nil, maxSalary: nil),
    Section(title: "Industry", isExpanded: false, options: ["Option 1", "Option 2"], selectedOption: nil, minSalary: nil, maxSalary: nil),
    Section(title: "Location", isExpanded: false, options: ["Option 1", "Option 2","3","4"], selectedOption: nil, minSalary: nil, maxSalary: nil),
    Section(title: "Salary", isExpanded: false, options: [], selectedOption: nil, minSalary: 0, maxSalary: 5), // Default salary values
    Section(title: "Work Preference", isExpanded: false, options: ["Option 1", "Option 2"], selectedOption: nil, minSalary: nil, maxSalary: nil)
]

