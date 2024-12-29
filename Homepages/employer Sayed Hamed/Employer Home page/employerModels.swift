////
////  Models.swift
////  testfinalfinal
////
////  Created by Guest User on 18/12/2024.
////
//
import Foundation
//
let df = DateFormatter()
//
//// NEW APPLICATION
////struct application {
////    var dateOfApplication: Date
////    var profile: Profile
////    var isShortlisted: Bool
////    var interview: Interview?
////    var status: applicationStatus
////}
//
//// OLD APPLICATION
////struct application {
////    var applicantName: String
////    var currentTitle: String
////    var yearsOfExperience: Int
////    var dateOfApplication: Date
////    var isShortlisted: Bool = false
////
////}
//
//    
let sampleJobSeeker1 = JobSeeker(
    userID: "testsds",
    personalSummary: "",
    educations: [],
    experiences: [
        Experience(
            jobTitle: "Senior Developer",
            companyName: "Tech Innovators",
            startDate: "01/06/2022",
            endDate: "Ongoing",
            city: "Manama"
        ),
        Experience(
            jobTitle: "Mid-Level Developer",
            companyName: "App Makers",
            startDate: "01/01/2020",
            endDate: "31/05/2022",
            city: "Riffa"
        )
    ],
    skills: [],
    preferences: [],
    cv: "",
    suggestedCareerPaths: [],
    applications: nil,
    firstName: "John",
    lastName: "Doe",
    email: "john.doe@example.com",
    password: "password123",
    type: .jobSeeker,
    profileImage: "https://example.com/profile1.jpg",
    phoneNumber: "12345678",
    location: "Manama"
)

let sampleJobSeeker2 = JobSeeker(
    userID: "skajdsa",
    personalSummary: "",
    educations: [],
    experiences: [
        Experience(
            jobTitle: "Marketing Manager",
            companyName: "BrandHub",
            startDate: "01/03/2018",
            endDate: "30/06/2020",
            city: "Isa Town"
        ),
        Experience(
            jobTitle: "Marketing Assistant",
            companyName: "Creative Minds Co.",
            startDate: "01/07/2016",
            endDate: "28/02/2018",
            city: "Muharraq"
        )
    ],
    skills: [],
    preferences: [],
    cv: "",
    suggestedCareerPaths: [],
    applications: nil,
    firstName: "Jane",
    lastName: "Smith",
    email: "jane.smith@example.com",
    password: "securepass",
    type: .jobSeeker,
    profileImage: "https://example.com/profile2.jpg",
    phoneNumber: "98765432",
    location: "Isa Town"
)

let sampleJobSeeker3 = JobSeeker(
    userID: "sadsa",
    personalSummary: "",
    educations: [],
    experiences: [],
    skills: [],
    preferences: [],
    cv: "",
    suggestedCareerPaths: [],
    applications: nil,
    firstName: "Alice",
    lastName: "Brown",
    email: "alice.brown@example.com",
    password: "mypassword",
    type: .jobSeeker,
    profileImage: "https://example.com/profile3.jpg",
    phoneNumber: "44556677",
    location: "Hamad Town"
)


let application1 = application(dateOfApplication: "", jobSeeker: sampleJobSeeker1, isShortlisted: false,interview: nil, status: .pending)
let application2 = application(dateOfApplication: "", jobSeeker: sampleJobSeeker2, isShortlisted: true,interview: nil, status: .pending)
let application3 = application(dateOfApplication: "", jobSeeker: sampleJobSeeker3, isShortlisted: false,interview: Interview(interviewDate: "28/12/2024", interviewTime: "10:10 AM", nameOfIntervieweed: "Alice Brown"), status: .pending)

//
//
//func makeDateFormatter(){
//    df.dateFormat = "dd/MM/yyyy"
//}
//
var applications: [application] = [application1,application2,application3]
//
//
//let companyProfile = Company(companyName:"Tech Summy",industry: "Tech", website: "Tech.com", aboutUs: "We are a tech company for techies", firstName: "Mohamed", lastName: "Abdo", email: "mohamedAbdo@example.com", password: "HAHA", type: .employer, profileImage: "", phoneNumber: "33445566", location: "Manama")
