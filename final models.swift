////
////  final models.swift
////  testfinalfinal
////
////  Created by Sayed Qassim on 19/12/2024.
////

import Foundation

// MARK: - Enums

enum UserType: String,Codable{
    case admin
    case jobSeeker
    case employer
    
}
enum SkillNames : String{
    case skill1
    case skill2
}
enum jobTypes : String,Codable{
    case fullTime = "fulltime"
    case partTime = "part-time"
}
enum jobCategories : String, Codable{
    case software
    case hardware
    case finance
}
enum preferenceList: String,Codable{
    case experience
    case education
    case skills
}
enum jobPositions: String , Codable{
    case Designer = "Designer"
    case softwareDev = "Software Developer"
}
enum SalaryType : String, Codable{
    case hourly
    case monthly
}
enum applicationStatus : String,Codable{
    case pending
    case accepted
    case rejected
}







// MARK: Structs
struct Education: Equatable,Codable {
    var educationFacility: String
    var educationLevel: String
    var degree: String
    var startDate: String
    var endDate: String
    var city: String
    
}
struct Experience: Equatable,Codable {
    var jobTitle: String
    var companyName: String
    var startDate: String
    var endDate: String
    var city: String
    
}

struct Skill: Codable {
    var skillName: String
    var skillLevel: String
}
struct CareerPath :Codable{
    var interests: [String]
    var skills: [Skill]
    var position: jobPositions
    var description: String
    
}
struct Preference : Codable{
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
struct application : Codable {
    var dateOfApplication: Date
    var jobSeeker: JobSeeker
    var isShortlisted: Bool = false
    var interview: Interview?
    var notes: String?
    var status: applicationStatus = .pending
}
struct Interview : Codable {
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
struct NotificationItem : Codable {
    var notificationName: String
    var notificationDescription: String
    var notificationDate: String
    var category: String
}


// MARK: Classes


class AppUser: Codable {
    var userID: String
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var type: UserType

    init(userID:String,firstName: String, lastName: String, email: String, password: String, type: UserType) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.type = type
        self.userID = userID
    }

    enum CodingKeys: String, CodingKey {
        case userID = "userID"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case password = "password"
        case type = "type"
    }
}
class Profile: AppUser {
    var profileImage: String
    var phoneNumber: String
    var location: String
    var notifications: [NotificationItem] = []

    // Custom initializer
    init(userID: String, profileImage: String, phoneNumber: String, location: String, firstName: String, lastName: String, email: String, password: String, type: UserType) {
        self.profileImage = profileImage
        self.phoneNumber = phoneNumber
        self.location = location
        super.init(userID: userID, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }

    // MARK: Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode properties of Profile
        self.profileImage = try container.decode(String.self, forKey: .profileImage)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.location = try container.decode(String.self, forKey: .location)
        self.notifications = try container.decodeIfPresent([NotificationItem].self, forKey: .notifications) ?? []

        // Decode properties of the parent class
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        // Encode properties of Profile
        try container.encode(profileImage, forKey: .profileImage)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(location, forKey: .location)
        try container.encode(notifications, forKey: .notifications)

        // Encode properties of the parent class
        try super.encode(to: encoder)
    }

    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case profileImage
        case phoneNumber
        case location
        case notifications
    }
}

class Company: Profile {
    var companyName: String
    var industry: String
    var website: String
    var aboutUs: String

    // Custom initializer
    init(userID: String, companyName: String, industry: String, website: String, aboutUs: String, firstName: String, lastName: String, email: String, password: String, type: UserType, profileImage: String, phoneNumber: String, location: String) {
        self.companyName = companyName
        self.industry = industry
        self.website = website
        self.aboutUs = aboutUs
        super.init(userID: userID, profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }

    // MARK: Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode properties of Company
        self.companyName = try container.decode(String.self, forKey: .companyName)
        self.industry = try container.decode(String.self, forKey: .industry)
        self.website = try container.decode(String.self, forKey: .website)
        self.aboutUs = try container.decode(String.self, forKey: .aboutUs)

        // Decode properties of the parent class (Profile)
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        // Encode properties of Company
        try container.encode(companyName, forKey: .companyName)
        try container.encode(industry, forKey: .industry)
        try container.encode(website, forKey: .website)
        try container.encode(aboutUs, forKey: .aboutUs)

        // Encode properties of the parent class (Profile)
        try super.encode(to: encoder)
    }

    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case companyName
        case industry
        case website
        case aboutUs
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

    // Custom initializer
    init(userID: String, personalSummary: String, educations: [Education]?, experiences: [Experience]?, skills: [Skill]?, preferences: [Preference]?, cv: String, suggestedCareerPaths: [CareerPath]?, applications: [application]?, firstName: String, lastName: String, email: String, password: String, type: UserType, profileImage: String, phoneNumber: String, location: String) {
        self.personalSummary = personalSummary
        self.educations = educations
        self.experiences = experiences
        self.skills = skills
        self.preferences = preferences
        self.cv = cv
        self.suggestedCareerPaths = suggestedCareerPaths
        self.applications = applications
        super.init(userID: userID, profileImage: profileImage, phoneNumber: phoneNumber, location: location, firstName: firstName, lastName: lastName, email: email, password: password, type: type)
    }

    // MARK: Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Decode properties of JobSeeker
        self.personalSummary = try container.decode(String.self, forKey: .personalSummary)
        self.educations = try container.decodeIfPresent([Education].self, forKey: .educations)
        self.experiences = try container.decodeIfPresent([Experience].self, forKey: .experiences)
        self.skills = try container.decodeIfPresent([Skill].self, forKey: .skills)
        self.preferences = try container.decodeIfPresent([Preference].self, forKey: .preferences)
        self.cv = try container.decode(String.self, forKey: .cv)
        self.suggestedCareerPaths = try container.decodeIfPresent([CareerPath].self, forKey: .suggestedCareerPaths)
        self.applications = try container.decodeIfPresent([application].self, forKey: .applications)

        // Decode properties of the parent class (Profile)
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        // Encode properties of JobSeeker
        try container.encode(personalSummary, forKey: .personalSummary)
        try container.encodeIfPresent(educations, forKey: .educations)
        try container.encodeIfPresent(experiences, forKey: .experiences)
        try container.encodeIfPresent(skills, forKey: .skills)
        try container.encodeIfPresent(preferences, forKey: .preferences)
        try container.encode(cv, forKey: .cv)
        try container.encodeIfPresent(suggestedCareerPaths, forKey: .suggestedCareerPaths)
        try container.encodeIfPresent(applications, forKey: .applications)

        // Encode properties of the parent class (Profile)
        try super.encode(to: encoder)
    }

    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case personalSummary
        case educations
        case experiences
        case skills
        case preferences
        case cv
        case suggestedCareerPaths
        case applications
    }
}

class SkillAssessmentDashboard {
    var name: String
    var filter1: String
    var filter1Options: [String]
    var difficulty: String = "Difficulty"
    var difficultyOptions : [String] = ["Easy","Medium","Hard"]
    var tests: [Test]
    init(name: String,filter1: String, filter1Options: [String],  tests: [Test]) {
        self.filter1 = filter1
        self.filter1Options = filter1Options
        self.tests = tests
        self.name = name
    }
    

}
class job: Codable {
    var jobTitle: String
    var company: Company
    var jobDescription: String
    var jobSalary: String
    var jobType: jobTypes
    var jobId: String
    var jobCategory: jobCategories
    var jobPosition: jobPositions
    var jobImage: String
    var jobSkills: [String]
    var jobPostedDate: String
    var salaryType: SalaryType
    var timeFromPost: String
    var deadline: String
    var offer: String
    var isBookmarked: Bool = false
    var applications: [application]?

    // Custom initializer
    init(jobTitle: String, company: Company, jobDescription: String, jobSalary: String, jobType: jobTypes, jobId: String, jobCategory: jobCategories, jobPosition: jobPositions, jobImage: String, jobSkills: [String], jobPostedDate: String, salaryType: SalaryType, timeFromPost: String, deadline: String, applications: [application]?, offer: String) {
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
        self.salaryType = salaryType
        self.timeFromPost = timeFromPost
        self.deadline = deadline
        self.applications = applications
        self.offer = offer
    }

    // MARK: Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.jobTitle = try container.decode(String.self, forKey: .jobTitle)
        self.company = try container.decode(Company.self, forKey: .company)
        self.jobDescription = try container.decode(String.self, forKey: .jobDescription)
        self.jobSalary = try container.decode(String.self, forKey: .jobSalary)
        self.jobType = try container.decode(jobTypes.self, forKey: .jobType)
        self.jobId = try container.decode(String.self, forKey: .jobId)
        self.jobCategory = try container.decode(jobCategories.self, forKey: .jobCategory)
        self.jobPosition = try container.decode(jobPositions.self, forKey: .jobPosition)
        self.jobImage = try container.decode(String.self, forKey: .jobImage)
        self.jobSkills = try container.decode([String].self, forKey: .jobSkills)
        self.jobPostedDate = try container.decode(String.self, forKey: .jobPostedDate)
        self.salaryType = try container.decode(SalaryType.self, forKey: .salaryType)
        self.timeFromPost = try container.decode(String.self, forKey: .timeFromPost)
        self.deadline = try container.decode(String.self, forKey: .deadline)
        self.offer = try container.decode(String.self, forKey: .offer)
        self.isBookmarked = try container.decode(Bool.self, forKey: .isBookmarked)
        self.applications = try container.decodeIfPresent([application].self, forKey: .applications)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(jobTitle, forKey: .jobTitle)
        try container.encode(company, forKey: .company)
        try container.encode(jobDescription, forKey: .jobDescription)
        try container.encode(jobSalary, forKey: .jobSalary)
        try container.encode(jobType, forKey: .jobType)
        try container.encode(jobId, forKey: .jobId)
        try container.encode(jobCategory, forKey: .jobCategory)
        try container.encode(jobPosition, forKey: .jobPosition)
        try container.encode(jobImage, forKey: .jobImage)
        try container.encode(jobSkills, forKey: .jobSkills)
        try container.encode(jobPostedDate, forKey: .jobPostedDate)
        try container.encode(salaryType, forKey: .salaryType)
        try container.encode(timeFromPost, forKey: .timeFromPost)
        try container.encode(deadline, forKey: .deadline)
        try container.encode(offer, forKey: .offer)
        try container.encode(isBookmarked, forKey: .isBookmarked)
        try container.encodeIfPresent(applications, forKey: .applications)
    }

    // MARK: Coding Keys
    private enum CodingKeys: String, CodingKey {
        case jobTitle
        case company
        case jobDescription
        case jobSalary
        case jobType
        case jobId
        case jobCategory
        case jobPosition
        case jobImage
        case jobSkills
        case jobPostedDate
        case salaryType
        case timeFromPost
        case deadline
        case offer
        case isBookmarked
        case applications
    }
}

// MARK: Arrays / Models
var weightCategories : [String] =  ["Light", "Medium", "Heavy"]
var locations : [String] = [
    "Manama","Muharraq","Isa town"
]

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

var companySample = Company(userID: "string", companyName: "Bahrain Polytechnic",industry: "IT", website: "no website", aboutUs: "this is Bahrain Polytechnic", firstName: "Ghassan", lastName: "Alshajjar", email: "Qassimahmed231@gmail.com", password: "1319", type: .employer, profileImage: "no", phoneNumber: "35140480", location: "Aali")
var JobSeekerSample = JobSeeker(userID: "UID",personalSummary: "this is my summary, i am a slave to my master", educations: [Education(educationFacility: "ABG", educationLevel: "highSchool", degree: "highschool", startDate:"11/06/2004", endDate:"25/12/2024", city: "JidHafs")], experiences: nil, skills: nil, preferences: nil, cv: "idk", suggestedCareerPaths: nil, applications: nil, firstName: "Sayed Hamed", lastName: "idk", email: "SayedHamed2004@gmail.com", password: "slave", type: .jobSeeker, profileImage: "noimage", phoneNumber: "idk his phone num", location: "i forgot the location")


var sections: [Section] = [
    Section(title: "Job Category",options:["\(jobCategories.software)","\(jobCategories.hardware)","\(jobCategories.finance)"] ),
    Section(title: "Location", options: locations),
    Section(title: "Salary"), // Default salary values
    Section(title: "Job Type", options: [jobTypes.fullTime.rawValue, jobTypes.partTime.rawValue]),
    Section(title: "Position", options: [jobPositions.Designer.rawValue , jobPositions.softwareDev.rawValue])
]
var SQuser = AppUser(userID: "UserIDDD", firstName: "Sayed Qassim", lastName: "Alsari", email: "Qassimahmed231@gmail.com", password: "1319", type: .employer)




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
//var types :[Profile] = [companySample,JobSeekerSample]
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
        salaryType: .monthly,
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
        salaryType: .hourly,
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
        salaryType: .monthly,
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
        salaryType: .monthly,
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
        salaryType: .monthly,
        timeFromPost: "9 days ago",
        deadline: "2025-01-10",
        applications: nil,
        offer: "Opportunity to work on high-impact campaigns."
    )
]
var adminSections : [Section] = [
    Section(title: "Job Type", options: [jobTypes.fullTime.rawValue,jobTypes.partTime.rawValue]),
    Section(title: "Industry",options: ["Software","Hardware","Finance","Healthcare","Education","Other"]),
    Section(title: "Location",options: locations),
    Section(title: "Experience level",options: ["Entry Level","Mid Level","Senior Level"]),
    Section(title: "Work preference",options: ["Remote","On-site"])
    
]
var jobRecommendations : [job] = jobs
var employerInsights : [job] = jobs
var skillAssessmentDashboards : [SkillAssessmentDashboard] = [
    SkillAssessmentDashboard(name: "Programming", filter1: "Language", filter1Options: ["C#","Java","Python"], tests: []),
    SkillAssessmentDashboard(name: "Analytics", filter1: "Type", filter1Options: ["type1","type2","type3"], tests: []),
    SkillAssessmentDashboard(name: "Networking", filter1: "Type", filter1Options: ["IPV4","IPV6","DNS"], tests: []),
    SkillAssessmentDashboard(name: "Cyber Security", filter1: "Type", filter1Options: ["Ethical Hacking","Pen Testing","Malware Analysis"], tests: []),
    SkillAssessmentDashboard(name: "Artificial Intelligence", filter1: "Type", filter1Options: ["machine learning","deep learning","natural language processing"], tests: [])
]

var SQProfile = Profile(userID: "SayedQass", profileImage: "no", phoneNumber: "35140480", location: "Isa town", firstName: "Sayed Qassim AHmed", lastName: "Alsari", email: "Qassimahmed2111@gmail.com", password: "SQ", type: .employer)

var polyCompany = Company(userID: "POLYISSHIT", companyName: "Polytechnic", industry: "idk", website: "we do not have one", aboutUs: "we are a shit college", firstName: "Ghassan", lastName: "Al IDK", email: "ALQAWAd", password: "mamamia", type: .employer, profileImage: "idk", phoneNumber: "2134", location: "Aali")
var SayedHamed = JobSeeker(userID: "SHAMED", personalSummary: "no summary", educations: nil, experiences: nil, skills: nil, preferences: nil, cv: "idksk", suggestedCareerPaths: nil, applications: nil, firstName: "Sayed Hamed", lastName: "Mahmood", email: "SayedHamed231@gmail.com", password: "test", type: .jobSeeker, profileImage: "hello", phoneNumber: "1235", location: "Location")

var testJob = job(jobTitle: "Title1", company: polyCompany , jobDescription: "IDK", jobSalary: "4500", jobType: .fullTime, jobId: "anything", jobCategory: .software, jobPosition: .Designer, jobImage: "test", jobSkills: ["whatever"], jobPostedDate: "now", salaryType: .monthly, timeFromPost: "now", deadline: "tom", applications: nil, offer: "this is a great offer")
//
//
//
//
//
//
//
