//
//  Models.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import Foundation
struct job {
    var jobName: String
    var profilePicture: String
    var companyName: String
    var companyLocation: String
    var filters: [String]
    var time: String
    var salary: Int
    var type: String
    init(jobName: String, profilePicture: String, companyName: String, companyLocation: String, filters: [String], time: String, salary: Int, type: String) {
        self.jobName = jobName
        self.profilePicture = profilePicture
        self.companyName = companyName
        self.companyLocation = companyLocation
        self.filters = filters
        self.time = time
        self.salary = salary
        self.type = type
    }
}

var jobs: [job] = [
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo"),
    job(jobName: "Senior Developer", profilePicture: "poly logo 4", companyName: "Bahrain Polytechnic", companyLocation: "Aali,Bahrain", filters: ["Senior develeoper","Designer","Full-time"], time: "25", salary: 60000, type: "Mo")
    
]

