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

enum UserType: String{
    case admin
    case jobSeeker
    case employer
    
}
enum SkillNames : String{
    case skill1
    case skill2
}
enum jobTypes1 : String{
    case fullTime
    case partTime
}
enum jobCategories1 : String{
    case software
    case hardware
    case finance
}
enum preferenceList: String{
    case experience
    case education
    case skills
}
enum jobPositions: String{
    case Designer
    case softwareDev = "Software Developer"
}
enum SalaryType : String{
    case hourly
    case monthly
}
enum applicationStatus : String{
    case pending
    case accepted
    case rejected
}





// MARK: Structs
struct Education: Equatable {
    var educationFacility: String
    var educationLevel: String
    var degree: String
    var startDate: String
    var endDate: String
    var city: String
    
}
struct Experience: Equatable {
    var jobTitle: String
    var companyName: String
    var startDate: String
    var endDate: String
    var city: String
    
}

struct Skill {
    var skillName: String
    var skillLevel: String
}

struct CareerPath{
    var interests: [String]
    var skills: [Skill]
    var position: jobPositions
    var description: String
    
}
struct Preference{
    var prefrence : preferenceList
    var jobType: jobTypes1
    
    
}
struct Question {
    let questionText: String          // The question text
    let options: [String]             // An array of MCQ options
    let correctAnswer: String         // The correct answer from the options
    
    // Function to check if a given answer is correct
    func isCorrectAnswer(_ answer: String) -> Bool {
        return answer == correctAnswer
    }
}

struct Test {
    let testTitle: String             // Title of the test
    var questions: [Question]         // A set of questions
    
    // Function to calculate the total score based on answers provided
    func calculateScore(for answers: [String]) -> Int {
        guard answers.count == questions.count else {
            print("The number of answers doesn't match the number of questions.")
            return 0
        }
        return zip(questions, answers).filter { $0.isCorrectAnswer($1) }.count
    }
}

struct application {
    var dateOfApplication: Date
    var jobSeeker: JobSeeker
    var isShortlisted: Bool
    var interview: Interview?
    var status: applicationStatus
    var notes: String?
}

struct Interview {
    var interviewDate: String
    var interviewTime: String
    var nameOfIntervieweed: String
}

struct jobMarketTrend{
    var jobTitle: String
    var Skills: [Skill]
    var industry: String
    var growthRate: String
}
struct estimatedJobs{
    var jobTitle: String
    var minimumSalary: String
    var maximumSalary: String
    var experience: String
    var industry: String
}


// MARK: Classes


class User {
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var type: UserType
    init(firstName: String, lastName: String, email: String, password: String, type: UserType) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.type = type
    }
}
class Profile: User {
    var profileImage: String
    var phoneNumber: String
    var location: String
    
    init(profileImage: String, phoneNumber: String, location: String, firstName: String, lastName: String, email: String, password: String, type: UserType) {
        self.profileImage = profileImage
        self.phoneNumber = phoneNumber
        self.location = location
        super.init(firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }
}

class Company: Profile {
    var companyName: String
    var industry: String
    var website: String
    var aboutUs: String
    init(companyName:String, industry: String, website: String, aboutUs: String, firstName: String, lastName: String, email: String, password: String, type: UserType, profileImage: String, phoneNumber: String, location: String) {
        self.companyName = companyName
        self.industry = industry
        self.website = website
        self.aboutUs = aboutUs
        super.init(profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }
}

class JobSeeker: Profile {
    var personalSummary: String
    var educations: [Education]
    var experiences: [Experience]
    var skills: [Skill]
    var preferences: [Preference]
    var cv: String
    var suggestedCareerPaths: [CareerPath]
    init(personalSummary: String, educations: [Education], experiences: [Experience], skills: [Skill], preferences: [Preference], cv: String, suggestedCareerPaths: [CareerPath], firstName: String, lastName: String, email: String, password: String, type: UserType,profileImage: String, phoneNumber: String, location: String) {
        self.personalSummary = personalSummary
        self.educations = educations
        self.experiences = experiences
        self.skills = skills
        self.preferences = preferences
        self.cv = cv
        self.suggestedCareerPaths = suggestedCareerPaths
        super.init(profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }
    
    
}

class SkillAssessmentDashboard {
    var filter1: String
    var filter1Options: [String]
    var difficulty1: String = "Difficulty"
    var tests1: [Test]
    init(filter1: String, filter1Options: [String], difficulty1: String, tests1: [Test]) {
        self.filter1 = filter1
        self.filter1Options = filter1Options
        self.difficulty1 = difficulty1
        self.tests1 = tests1
    }
    

}
//
//class job1 {
//    var jobTitle: String
//    var company : Company
//    var jobDescription: String
//    var jobSalary: String
//    var jobType: jobTypes1
//    var jobId: String
//    var jobCategory: jobCategories1
//    var jobPosition : jobPositions
//    var jobImage: String
//    var jobSkills: [String]
//    var jobPostedDate: String
//    var SalaryType: SalaryType
//    var timeFromPost: String
//    var deadline: String
//    var applications: [application]
//    init(jobTitle: String, company: Company, jobDescription: String, jobSalary: String, jobType: jobTypes1, jobId: String, jobCategory: jobCategories1, jobPosition: jobPositions, jobImage: String, jobSkills: [String], jobPostedDate: String, SalaryType: SalaryType, timeFromPost: String, deadline: String, applications: [application]) {
//        self.jobTitle = jobTitle
//        self.company = company
//        self.jobDescription = jobDescription
//        self.jobSalary = jobSalary
//        self.jobType = jobType
//        self.jobId = jobId
//        self.jobCategory = jobCategory
//        self.jobPosition = jobPosition
//        self.jobImage = jobImage
//        self.jobSkills = jobSkills
//        self.jobPostedDate = jobPostedDate
//        self.SalaryType = SalaryType
//        self.timeFromPost = timeFromPost
//        self.deadline = deadline
//        self.applications = applications
//    }
//}

// MARK: Arrays / Models
let weightCategories : [String] =  ["Light", "Medium", "Heavy"]
