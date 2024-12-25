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
enum jobTypes : String{
    case fullTime = "fulltime"
    case partTime = "part-time"
}
enum jobCategories : String{
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
    case Designer = "Designer"
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

var locations : [String] = [
    "Manama","Muharraq","Isa town"
]





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
    var jobType: jobTypes
    
    
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
    var isShortlisted: Bool = false
    var interview: Interview?
    var status: applicationStatus = .pending
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

struct Section {
    var title: String
    var isExpanded: Bool = false
    var options: [String]? = nil // Dropdown options for sections that use dropdowns
    var selectedOption: String? = nil // Selected dropdown option (if applicable)
    var minSalary: Int? = nil // Minimum Salary (as an integer value)
    var maxSalary: Int? = nil // Maximum Salary (as an integer value)
}


// MARK: Classes


class User {
    static var IDS = 1
    var userID: Int
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var type: UserType
    init(firstName: String, lastName: String, email: String, password: String, type: UserType) {
        self.userID = User.IDS
        User.IDS += 1
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
    init(companyName: String,industry: String, website: String, aboutUs: String, firstName: String, lastName: String, email: String, password: String, type: UserType, profileImage: String, phoneNumber: String, location: String) {
        self.companyName = companyName
        self.industry = industry
        self.website = website
        self.aboutUs = aboutUs
        super.init(profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }
}

class JobSeeker: Profile {
    var personalSummary: String
    var educations: [Education]?
    var experiences: [Experience]?
    var skills: [Skill]?
    var preferences: [Preference]?
    var cv: String
    var suggestedCareerPaths: [CareerPath]?
    var applications: [application]?
    init(personalSummary: String, educations: [Education]?, experiences: [Experience]?, skills: [Skill]?, preferences: [Preference]?, cv: String, suggestedCareerPaths: [CareerPath]?, firstName: String, lastName: String, email: String, password: String, type: UserType,profileImage: String, phoneNumber: String, location: String) {
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
class job {
    var jobTitle: String
    var company : Company
    var jobDescription: String
    var jobSalary: String
    var jobType: jobTypes
    var jobId: String
    var jobCategory: jobCategories
    var jobPosition : jobPositions
    var jobImage: String
    var jobSkills: [String]
    var jobPostedDate: String
    var SalaryType: SalaryType
    var timeFromPost: String
    var deadline: String
    var offer : String
    var isBookmarked: Bool = false
    var applications: [application]?
    init(jobTitle: String, company: Company, jobDescription: String, jobSalary: String, jobType: jobTypes, jobId: String, jobCategory: jobCategories, jobPosition: jobPositions, jobImage: String, jobSkills: [String], jobPostedDate: String, SalaryType: SalaryType, timeFromPost: String, deadline: String, applications: [application]?, offer: String) {
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
        self.offer = offer
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

var companySample = Company(companyName: "Bahrain Polytechnic",industry: "IT", website: "no website", aboutUs: "this is Bahrain Polytechnic", firstName: "Ghassan", lastName: "Alshajjar", email: "Qassimahmed231@gmail.com", password: "1319", type: .employer, profileImage: "no", phoneNumber: "35140480", location: "Aali")
var JobSeekerSample = JobSeeker(personalSummary: "this is my summary, i am a slave to my master", educations: [Education(educationFaculty: "ABG", educationLevel: "highSchool", degree: "highschool", startYear: 2010, endYear: 2022, city: "JidHafs")], experiences: nil, skills: nil, preferences: nil, cv: "idk", suggestedCareerPaths: nil, firstName: "Sayed Hamed", lastName: "idk", email: "SayedHamed2004@gmail.com", password: "slave", type: .jobSeeker, profileImage: "noimage", phoneNumber: "idk his phone num", location: "i forgot the location")


var sections: [Section] = [
    Section(title: "Job Category",options:["\(jobCategories.software)","\(jobCategories.hardware)","\(jobCategories.finance)"] ),
    Section(title: "Location", options: locations),
    Section(title: "Salary"), // Default salary values
    Section(title: "Job Type", options: [jobTypes.fullTime.rawValue, jobTypes.partTime.rawValue]),
    Section(title: "Position", options: [jobPositions.Designer.rawValue , jobPositions.softwareDev.rawValue])
]



//var positionsArray : [String] = [
//    "Senior Developer","designer"
//]
//enum jobCategories {
//    case design
//    case softwareDevelopment
//    case cyberSecurity
//}
//
//var jobCategoriesArray :[String] = [
//    "design","software development","Cyber security"
//]

//var jobTypes :[String] = [
//    "Full-time","Part-time","Project-based","Per hour"
//]
var types :[Profile] = [companySample,JobSeekerSample]
var jobs: [job] = [
    job(
        jobTitle: "Software Developer",
        company: companySample,
        jobDescription: "This is a software engineering job, you have no rights to work in this job.",
        jobSalary: "7800",
        jobType: .fullTime,
        jobId: "1",
        jobCategory: .software,
        jobPosition: .Designer,
        jobImage: "no",
        jobSkills: ["Swift", "iOS Development"],
        jobPostedDate: "2024-12-20",
        SalaryType: .monthly,
        timeFromPost: "1 hour ago",
        deadline: "2024-12-31",
        applications: nil,
        offer: "This is our final offer, take it or leave it."
    ),
    job(
        jobTitle: "Graphic Designer",
        company: companySample,
        jobDescription: "We need a creative graphic designer with a passion for visual storytelling.",
        jobSalary: "5000",
        jobType: .partTime,
        jobId: "2",
        jobCategory: .finance,
        jobPosition: .Designer,
        jobImage: "graphic_logo",
        jobSkills: ["Photoshop", "Illustrator", "Figma"],
        jobPostedDate: "2024-12-18",
        SalaryType: .hourly,
        timeFromPost: "3 days ago",
        deadline: "2025-01-05",
        applications: nil,
        offer: "Flexible working hours and competitive pay."
    ),
    job(
        jobTitle: "Data Scientist",
        company: companySample,
        jobDescription: "Analyze and interpret complex data to help improve business outcomes.",
        jobSalary: "12000",
        jobType: .fullTime,
        jobId: "3",
        jobCategory: .finance,
        jobPosition: .Designer,
        jobImage: "data_logo",
        jobSkills: ["Python", "Machine Learning", "SQL"],
        jobPostedDate: "2024-12-22",
        SalaryType: .monthly,
        timeFromPost: "2 days ago",
        deadline: "2025-01-15",
        applications: nil,
        offer: "Generous benefits package and remote work options."
    ),
    job(
        jobTitle: "Janitor",
        company: companySample,
        jobDescription: "Ensure cleanliness and orderliness in the office premises.",
        jobSalary: "2500",
        jobType: .fullTime,
        jobId: "4",
        jobCategory: .software,
        jobPosition: .softwareDev,
        jobImage: "janitor_logo",
        jobSkills: ["Cleaning", "Organizing"],
        jobPostedDate: "2024-12-10",
        SalaryType: .monthly,
        timeFromPost: "14 days ago",
        deadline: "2024-12-31",
        applications: nil,
        offer: "Flexible hours and supportive team environment."
    ),
    job(
        jobTitle: "Marketing Specialist",
        company: companySample,
        jobDescription: "Develop marketing strategies to increase brand awareness.",
        jobSalary: "8500",
        jobType: .fullTime,
        jobId: "5",
        jobCategory: .software,
        jobPosition: .softwareDev,
        jobImage: "marketing_logo",
        jobSkills: ["SEO", "Content Marketing", "Social Media"],
        jobPostedDate: "2024-12-15",
        SalaryType: .monthly,
        timeFromPost: "9 days ago",
        deadline: "2025-01-10",
        applications: nil,
        offer: "Opportunity to work on high-impact campaigns."
    )
]



//
//
//
//
//
//
//
