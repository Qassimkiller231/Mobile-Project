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

// this is the section for advanced filters
struct Section {
    var title: String
    var isExpanded: Bool = false
    var options: [String]? = nil // Dropdown options for sections that use dropdowns
    var selectedOption: String? = nil // Selected dropdown option (if applicable)
    var minSalary: Int? = nil // Minimum Salary (as an integer value)
    var maxSalary: Int? = nil // Maximum Salary (as an integer value)
}



// Arrays
enum jobCategories {
    case design
    case softwareDevelopment
    case cyberSecurity
}

var jobCategoriesArray :[String] = [
    "design","software development","Cyber security"
]
var locations : [String] = [
    "Manama","Muharraq","Isa town"
]
var jobTypes :[String] = [
    "Full-time","Part-time","Project-based","Per hour"
]
//struct position {
//    var jobCategory:jobCategories
//    var name:String
//}
//var positions: [position] = [
//    position(jobCategory: jobCategories.design, name: "designer"),
//    position(jobCategory: jobCategories.softwareDevelopment, name: "Software Developer")
//]
var positionsArray : [String] = [
    "Senior Developer","designer"
]





// this is the jobSeeker homepage job listing model
var jobs: [job] = [
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain", companyLocation: "Aali,Bahrain", filters: ["Senior","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Designer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["\(jobCategories.design)","\(jobCategories.design)","\(jobCategories.design)"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Help plz", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Janitor", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo")
    
]
var bookmarkedJobs: [job] = []



// this is the main advanced filters Model
var sections: [Section] = [
    Section(title: "Job Category",options: jobCategoriesArray),
    Section(title: "Location", options: locations),
    Section(title: "Salary"), // Default salary values
    Section(title: "Job Type", options: jobTypes),
    Section(title: "Position", options: positionsArray)
]



