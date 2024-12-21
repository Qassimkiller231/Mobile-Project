////
////  final models.swift
////  testfinalfinal
////
////  Created by Sayed Qassim on 19/12/2024.
////

import Foundation

// MARK: - Enums

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
struct Education {
    var educationFaculty: String
    var educationLevel: String
    var degree: String
    var startYear: Int
    var endYear: Int
    var city: String
    
}
struct Experience {
    var jobTitle: String
    var companyname: String
    var startYear: Int
    var endYear: Int
    var city: String
    
}

struct Skill {
    var skillName: SkillNames
    var skillLevel: Int
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
    var profile: Profile
    var isShortlisted: Bool
    var interview: Interview?
    var status: applicationStatus
}
struct Interview {
    var interviewDate: Date
    var interviewTime: String
    var nameOfIntervieweed: String
}

struct jobMarketTrend{
    var jobTitle: String
    var Skills: [Skill]
    var industry: String
    var growthRate: String
}
struct estimatedJob{
    var jobTitle: String
    var minimumSalary: String
    var maximumSalary: String
    var experience: String
    var industry: String
}
struct Article {
    var articleTitle: String
    var articleDescription: String
    
}
struct Guide {
    var guideTitle: String
    var guideDescription: String
    var guideVideo : String
    var guideAudio : String
    
    
}
struct Video {
    var videoTitle: String
    var videoURL: String
    var videoDescription: String
}

struct Webinar {
    var WebnarTitle: String
    var Date: String
    var filters: [String]
    var videoURL: String
    var webnarDescription: String
}

struct table{
    var title: String
    var isExpanded: Bool = false
    var options: [String]
    var selectedOption: String?
    
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
    var user : User
    var profileImage: String
    var phoneNumber: String
    var location: String
    
    init(user: User, profileImage: String, phoneNumber: String, location: String, firstName: String, lastName: String, email: String, password: String, type: UserType) {
        self.user = user
        self.profileImage = profileImage
        self.phoneNumber = phoneNumber
        self.location = location
        super.init(firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }
}

class Company: Profile {
    var industry: String
    var website: String
    var aboutUs: String
    init(industry: String, website: String, aboutUs: String, firstName: String, lastName: String, email: String, password: String, type: UserType, profileImage: String, phoneNumber: String, location: String) {
        self.industry = industry
        self.website = website
        self.aboutUs = aboutUs
        super.init(user: User(firstName: firstName, lastName: lastName, email: email, password: password, type: type), profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
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
        super.init(user: User(firstName: firstName, lastName: lastName, email: email, password: password, type: type), profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
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
class job1 {
    var jobTitle: String
    var company : Company
    var jobDescription: String
    var jobSalary: String
    var jobType: jobTypes1
    var jobId: String
    var jobCategory: jobCategories1
    var jobPosition : jobPositions
    var jobImage: String
    var jobSkills: [String]
    var jobPostedDate: String
    var SalaryType: SalaryType
    var timeFromPost: String
    var deadline: String
    var applications: [application]
    init(jobTitle: String, company: Company, jobDescription: String, jobSalary: String, jobType: jobTypes1, jobId: String, jobCategory: jobCategories1, jobPosition: jobPositions, jobImage: String, jobSkills: [String], jobPostedDate: String, SalaryType: SalaryType, timeFromPost: String, deadline: String, applications: [application]) {
        self.jobTitle = jobTitle
        self.company = company
        self.jobDescription = jobDescription
        self.jobSalary = jobSalary
        self.jobType = jobType
        self.jobId = jobId
        self.jobCategory = jobCategory
        self.jobPosition = jobPosition
        self.jobImage = jobImage
        self.jobSkills = jobSkills
        self.jobPostedDate = jobPostedDate
        self.SalaryType = SalaryType
        self.timeFromPost = timeFromPost
        self.deadline = deadline
        self.applications = applications
    }
}

// MARK: Arrays / Models
var weightCategories : [String] =  ["Light", "Medium", "Heavy"]


var FinalEstimatedSalaries :[estimatedJob] = [
    estimatedJob(jobTitle: "job1", minimumSalary: "500", maximumSalary: "750", experience: "3 years", industry: "IT"),
    estimatedJob(jobTitle: "job4", minimumSalary: "800", maximumSalary: "1050", experience: "9 years", industry: "IT"),
    estimatedJob(jobTitle: "job5", minimumSalary: "900", maximumSalary: "1150", experience: "11 years", industry: "IT")
]
var estimatedSalaries : [estimatedJob] = [
    estimatedJob(jobTitle: "job1", minimumSalary: "500", maximumSalary: "750", experience: "3 years", industry: "IT"),
    estimatedJob(jobTitle: "job2", minimumSalary: "600", maximumSalary: "850", experience: "5 years", industry: "IT"),
    estimatedJob(jobTitle: "job3", minimumSalary: "700", maximumSalary: "950", experience: "7 years", industry: "IT"),
    estimatedJob(jobTitle: "job4", minimumSalary: "800", maximumSalary: "1050", experience: "9 years", industry: "IT"),
    estimatedJob(jobTitle: "job5", minimumSalary: "900", maximumSalary: "1150", experience: "11 years", industry: "IT"),
    estimatedJob(jobTitle: "job6", minimumSalary: "1000", maximumSalary: "1250", experience: "13 years", industry: "IT")
]
var articles : [Article] = [
    Article(articleTitle: "Article1", articleDescription: "this is article 1"),
    Article(articleTitle: "Article2", articleDescription: "this is article 2"),
    Article(articleTitle: "Article3", articleDescription: "this is article 3")
]
var guides : [Guide] = [
    Guide(guideTitle: "Guide 1", guideDescription: "this is Guide 1 details, bro rbor bro", guideVideo: "test", guideAudio: "test2"),
    Guide(guideTitle: "Guide 2", guideDescription: "this is Guide 2 details, bro rbor bro", guideVideo: "test", guideAudio: "test2"),
    Guide(guideTitle: "Guide 3", guideDescription: "this is Guide 3 details, bro rbor bro", guideVideo: "test", guideAudio: "test2")
    ]

var videos : [Video] = [
    Video(videoTitle: "Video1", videoURL: "test", videoDescription: "This is the first video"),
    Video(videoTitle: "Video2", videoURL: "test", videoDescription: "This is the second video"),
    Video(videoTitle: "Video3", videoURL: "test", videoDescription: "This is the third video"),
    Video(videoTitle: "Video1", videoURL: "test", videoDescription: "This is the first video"),
    Video(videoTitle: "Video2", videoURL: "test", videoDescription: "This is the second video"),
    Video(videoTitle: "Video3", videoURL: "test", videoDescription: "This is the third video"),
    Video(videoTitle: "Video1", videoURL: "test", videoDescription: "This is the first video"),
    Video(videoTitle: "Video2", videoURL: "test", videoDescription: "This is the second video"),
    Video(videoTitle: "Video3", videoURL: "test", videoDescription: "This is the third video"),
    Video(videoTitle: "Video1", videoURL: "test", videoDescription: "This is the first video"),
    Video(videoTitle: "Video2", videoURL: "test", videoDescription: "This is the second video"),
    Video(videoTitle: "Video3", videoURL: "test", videoDescription: "This is the third video"),
    Video(videoTitle: "Video3", videoURL: "test", videoDescription: "This is the third video")

]
var webinars: [Webinar] = [
    Webinar(WebnarTitle: "Webinar1", Date: "starting today", filters: ["Filter1", "Filter2", "Filter3"], videoURL: "test", webnarDescription: "This is the first webinar"),
    Webinar(WebnarTitle: "Webinar2", Date: "starting today", filters: ["Filter1", "Filter2", "Filter3"], videoURL: "test", webnarDescription: "This is the second webinar"),
    Webinar(WebnarTitle: "Webinar3", Date: "starting today", filters: ["Filter1", "Filter2", "Filter3"], videoURL: "test", webnarDescription: "This is the third webinar"),
    
]

var tableData: [table] = [
    table(title: "Pick an Application", options: ["Application 1","Application 2","Application 3","Application 4","Application 5"]),
    table(title: "Choose Weight", options: ["Default","Custom"])
]

//
//
//
//
//
//
//