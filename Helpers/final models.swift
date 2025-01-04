////
////  final models.swift
////  testfinalfinal
////
////  Created by Sayed Qassim on 19/12/2024.
////

import Foundation
import FirebaseFirestore
// MARK: - Enums

enum UserType: String,Codable{
    case admin
    case jobSeeker
    case employer
    case guest
    
}
enum SkillNames : String{
    case skill1
    case skill2
}
enum jobTypes : String,Codable{
    case fullTime = "fulltime"
    case partTime = "part-time"
    case contract = "contract"
    case internship = "internship"
    case freelance = "freelance"
    case projectBased = "project based"
}
enum jobCategories : String, Codable{
    case software
    case hardware
    case finance
    case design
    case management
    case marketing
}
enum preferenceList: String,Codable{
    case experience
    case education
    case skills
}
enum jobPositions: String , Codable{
    case Designer = "Designer"
    case softwareDev = "Software Developer"
    case SoftwareEngineer = "Software Engineer"
    case CloudEngineer = "Cloud Engineer"
    case DataScientist = "Data Scientist"
    case CyberSecuritySpecialist = "Cyber Security Specialist"
    case NetworkAdministrator = "Network Administrator"
    case MobileAppDeveloper = "Mobile App Developer"
    case SystemArchitect = "System Architect"
    case FrontendDeveloper = "Frontend Developer"
    case DatabaseAdministrator = "Database Administrator"
    case ITSupportSpecialist = "IT Support Specialist"
    case MachineLearningEngineer = "Machine Learning Engineer"
    case DevOpsEngineer = "DevOps Engineer"
    case UXDesigner = "UX Designer"
    case EmbeddedSystemsEngineer = "Embedded Systems Engineer"
    case BlockchainDeveloper = "Blockchain Developer"
    case PenetrationTester = "Penetration Tester"
    case DataVisualizationSpecialist = "Data Visualization Specialist"
    case RoboticsEngineer = "Robotics Engineer"
    case GameDeveloper = "Game Developer"
    case ITManager = "IT Manager"
    case projectManager  = "Project Manager"
    case marketingSpecialist = "Marketing Specialist"
    case itSupport = "IT Support"
}
enum SalaryType : String, Codable{
    case hourly
    case monthly
    case yearly
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
    var isExpanded: Bool = false
    
}
struct Preference : Codable{
    var prefrence : String
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
    var applicationNo: Int?
    var dateOfApplication: String
    var jobSeeker: JobSeeker
    var isShortlisted: Bool = false
    var interview: Interview?
    var notes: String?
    var status: applicationStatus = .pending
    var jobTitle: String?
}
struct Interview : Codable {
    var interviewDate: String
    var interviewTime: String
    var nameOfIntervieweed: String
    var location: String?
    var jobTitle: String?
}

struct jobMarketTrend : Codable{
    var jobTitle: String
    var Skills: [Skill]
    var industry: String
    var growthRate: String
}
struct estimatedJob : Codable{
    var jobTitle: String
    var minimumSalary: String
    var maximumSalary: String
    var experience: String
    var industry: String
}
struct Article: Codable {
    var articleTitle: String
    var articleDescription: String
    
}
struct Guide: Codable {
    var guideTitle: String
    var guideDescription: String
    var guideVideo : String
    var guideAudio : String
    
    
}
struct Video : Codable {
    var videoTitle: String
    var videoURL: String
    var videoDescription: String
}

struct Webinar : Codable {
    var WebnarTitle: String
    var Date: String
    var filters: [String]
    var videoURL: String
    var webnarDescription: String
    var isRegistered: Bool = false
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
    
    func toDictionary() -> [String: Any] {
            return [
                "notificationName": notificationName,
                "notificationDescription": notificationDescription,
                "notificationDate": notificationDate,
                "category": category
            ]
        }
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
    var preferences: [String]?
    var cv: String
    var suggestedCareerPaths: [CareerPath]?
    var applications: [application]?

    // Custom initializer
    init(userID: String, personalSummary: String, educations: [Education]?, experiences: [Experience]?, skills: [Skill]?, preferences: [String]?, cv: String, suggestedCareerPaths: [CareerPath]?, applications: [application]?, firstName: String, lastName: String, email: String, password: String, type: UserType, profileImage: String, phoneNumber: String, location: String) {
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
        self.preferences = try container.decodeIfPresent([String].self, forKey: .preferences)
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
    var company: Company // Store the full Company object in memory (not optional)
    var companyID: String // Reference to the Company document in Firestore
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

    // MARK: Initializer
    init(jobTitle: String, company: Company, companyID: String, jobDescription: String, jobSalary: String, jobType: jobTypes, jobId: String, jobCategory: jobCategories, jobPosition: jobPositions, jobImage: String, jobSkills: [String], jobPostedDate: String, salaryType: SalaryType, timeFromPost: String, deadline: String, applications: [application]?, offer: String) {
        self.jobTitle = jobTitle
        self.company = company
        self.companyID = companyID
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
    private enum CodingKeys: String, CodingKey {
        case jobTitle
        case companyID // Decode only the reference to the Company document
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

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.jobTitle = try container.decode(String.self, forKey: .jobTitle)
        self.companyID = try container.decode(String.self, forKey: .companyID) // Decode only the companyID
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

        // Fetch the company object must be handled in the fetch function.
        self.company = Company(userID: "", companyName: "", industry: "", website: "", aboutUs: "", firstName: "", lastName: "", email: "", password: "", type: .employer, profileImage: "", phoneNumber: "", location: "") // Placeholder, to be replaced after fetching.
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(jobTitle, forKey: .jobTitle)
        try container.encode(companyID, forKey: .companyID) // Encode only the companyID
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
}
// MARK: Arrays / Models
var weightCategories : [String] =  ["Light", "Medium", "Heavy"]
var locations : [String] = [
    "Manama","Muharraq","Isa town"
]

var FinalEstimatedSalaries :[estimatedJob] = [
    estimatedJob(jobTitle: "IT Manager", minimumSalary: "500", maximumSalary: "750", experience: "3 years", industry: "IT"),
    estimatedJob(jobTitle: "Software Developer", minimumSalary: "800", maximumSalary: "1050", experience: "9 years", industry: "IT"),
    estimatedJob(jobTitle: "Systems Analyst", minimumSalary: "900", maximumSalary: "1150", experience: "11 years", industry: "IT")
]
var estimatedSalaries : [estimatedJob] = [
    estimatedJob(jobTitle: "Network Administrator", minimumSalary: "500", maximumSalary: "750", experience: "3 years", industry: "IT"),
    estimatedJob(jobTitle: "Database Administrator", minimumSalary: "600", maximumSalary: "850", experience: "5 years", industry: "IT"),
    estimatedJob(jobTitle: "DevOps Engineer", minimumSalary: "700", maximumSalary: "950", experience: "7 years", industry: "IT"),
    estimatedJob(jobTitle: "Cloud Solutions Architect", minimumSalary: "800", maximumSalary: "1050", experience: "9 years", industry: "IT"),
    estimatedJob(jobTitle: "Cybersecurity Analyst", minimumSalary: "900", maximumSalary: "1150", experience: "11 years", industry: "IT"),
    estimatedJob(jobTitle: "IT Support Specialist", minimumSalary: "1000", maximumSalary: "1250", experience: "13 years", industry: "IT")
]
var articles : [Article] = [
    Article(articleTitle: "Protecting Your Data in a Digital World", articleDescription: "In an age where our lives are increasingly intertwined with technology, safeguarding personal and sensitive information has never been more crucial. This article explores the various threats to data security in a digital landscape, including cyberattacks, data breaches, and identity theft.We delve into essential strategies for protecting your data, such as implementing strong passwords, using two-factor authentication, and recognizing phishing scams. Additionally, we discuss the importance of regular software updates and data encryption.With practical tips and expert insights, this article empowers readers to take control of their digital security. Whether you're an individual looking to protect personal information or a business aiming to secure client data, this guide provides valuable tools and knowledge to navigate the complexities of data protection in today's connected world."),
    Article(articleTitle: "Top Programming Languages to Learn in 2025", articleDescription: "As the tech landscape continues to evolve, staying ahead in the programming world is essential for both aspiring developers and seasoned professionals. This article highlights the top programming languages that are set to dominate the industry in 2025, offering insights into their applications, demand, and future prospects.We begin by examining the enduring popularity of languages like Python and JavaScript, known for their versatility and robust community support. Next, we explore emerging languages such as Rust and Go, which are gaining traction for their performance and efficiency in cloud computing and systems programming.Additionally, the article delves into the growing significance of languages tailored for data science and artificial intelligence, such as R and Julia. Readers will also discover the importance of learning languages suited for mobile app development, like Swift and Kotlin.Packed with expert opinions and real-world applications, this guide serves as a roadmap for anyone looking to enhance their programming skills and align their career with the future of technology. Whether you're starting your coding journey or looking to expand your repertoire, this article will help you make informed choices about which languages to focus on in the coming years."),
    Article(articleTitle: "Building a Successful Career in IT: Tips from Industry Experts", articleDescription: "Embarking on a career in information technology (IT) can be both exciting and challenging. In this article, we gather insights and advice from seasoned industry experts to help you navigate your path to success in the ever-evolving tech landscape.We explore key strategies for building a solid foundation, including the importance of continuous learning and staying updated with emerging technologies. The article highlights the value of networking and mentorship, providing actionable tips on how to connect with professionals who can guide you in your career journey.Moreover, we discuss the significance of soft skills—such as communication, teamwork, and problem-solving—that can set you apart in a competitive job market. Experts share their personal experiences, shedding light on the diverse career paths available in IT, from software development to cybersecurity.Whether you're a recent graduate or a professional seeking to pivot in your career, this article equips you with the knowledge and tools to make informed decisions and achieve your career goals in IT. With practical advice and real-world examples, you’ll be inspired to take proactive steps toward a fulfilling and successful career in the tech industry.")
]
var guides : [Guide] = [
    Guide(guideTitle: "Guide 1", guideDescription: "this is Guide 1 details, bro rbor bro", guideVideo: "test", guideAudio: "test2"),
    Guide(guideTitle: "Guide 2", guideDescription: "this is Guide 2 details, bro rbor bro", guideVideo: "test", guideAudio: "test2"),
    Guide(guideTitle: "Guide 3", guideDescription: "this is Guide 3 details, bro rbor bro", guideVideo: "test", guideAudio: "test2")
    ]

var videos : [Video] = [
    Video(videoTitle: "How to Pick Your Career", videoURL: "moQnoSYPMmY", videoDescription: "Discover ikigai framework’s limitations to inform career choices."),
    Video(videoTitle: "Helping People Find Their Perfect Job", videoURL: "0SHMSYGDJXQ", videoDescription: "career guide"),
    Video(videoTitle: "Your IT Career 2024 will depend on this video", videoURL: "5mL6c2UiEEY", videoDescription: "TIf you want to advance your IT career, this video is a must watch video. In this video I am going to take a look at the current state of IT and provide you with my input and guidance on how to position yourself for a successful career year 2024."),
    Video(videoTitle: "How To Get Into Tech In 2025", videoURL: "u8E0JC8C4-8", videoDescription: "Full Tech Career Roadmap + Action Steps | Zero To I.T. Hero"),
    Video(videoTitle: "How to switch from Non IT to IT", videoURL: "pVDVVksp4VI", videoDescription: "Are you considering a career shift from non-IT to IT? This comprehensive guide provides step-by-step instructions, essential resources, and valuable insights to help you navigate this transition successfully."),
    Video(videoTitle: "Managers & Executives Career Guide", videoURL: "uEdREDwcD_M", videoDescription: "Investing in your career is crucial not just for immediate success but for long-term sustainability and growth. Most professionals believe in investing in their careers and in professional development. "),
    Video(videoTitle: "Level Up Your IT Career", videoURL: "P4ZCs1gqc3I", videoDescription: "Ready to leap from Helpdesk Technician to IT Manager? Discover if you've got what it takes in our latest video!"),
    Video(videoTitle: "IT career paths", videoURL: "uibHDPDaUjo", videoDescription: "The best IT (information technology) career paths for beginners should also give you enough job opportunities later to develop a successful tech career."),
    Video(videoTitle: "Soft Skills", videoURL: "USxsTggFKhE", videoDescription: "The distinction between Soft Skills and The Complete Software Developer's Career Guide has been a topic of frequent questions from you folks."),
    Video(videoTitle: "the TOP 10 hottest IT Jobs", videoURL: "Y_coOg6oHAc", videoDescription: "In this video, we discuss the top 10 hottest IT jobs in 2023 and 2024 based on the 2023 Dice Tech Salary Survey."),
    Video(videoTitle: "the hacker’s roadmap", videoURL: "uTAaFExLgwQ", videoDescription: "Are you wanting to get started in IT in 2023? Do you want to become a Hacker? A Network Engineer? Cloud Engineer? System Administrator? In this video, NetworkChuck will show you the path to getting started in IT and Cybersecurity that will help you reach these goals. "),
    Video(videoTitle: "Top 5 Non-Coding Tech Jobs", videoURL: "JYub1Gnqllg", videoDescription: "Become and Information Security Analyst or Security Engineer"),
    Video(videoTitle: "Top 23 Tech Jobs", videoURL: "8Nzzk7TvLrE", videoDescription: "These are the top 23 highest paying jobs in tech, both non-technical and technical, so you can pick the right one for you or to better understand your teammates.")
    ]

var webinars: [Webinar] = [
    Webinar(WebnarTitle: "From Classroom to Boardroom: Navigating Career Paths in Tech", Date: "12:00", filters: ["Programming", "Software Engineer", "all IT"], videoURL: "mOCcnOBse4k", webnarDescription: "From Classroom to Boardroom: Navigating Career Paths in Tech, where we bring together industry leaders to share their insights and experiences as women in the field of Information and Communications Technology (ICT)."),
    Webinar(WebnarTitle: "Ace Your Interview: Don't Make These Mistakes", Date: "Running Now", filters: ["DataBase", "Networking", "Cyber Cecurity"], videoURL: "YLz5qjraJSE", webnarDescription: "Nothing's perfect, but some mistakes are certainly avoidable. The UA Eller MBA Program would like to help you prepare for your admissions interview, by reviewing common interviewing mistakes and providing you with tips to ensure you have a successful experience."),
    Webinar(WebnarTitle: "The Future of IT: Trends Shaping Tomorrow's Job Market", Date: "Running Now", filters: ["IoT", "Networking", "Cyber Cecurity"], videoURL: "o0szkK2vrMY", webnarDescription: "ech Trends Shaping the Future of Work - Data Science, AI & ML"),
    
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
var polyCompany = Company(userID: "poly", companyName: "Polytechnic", industry: "idk", website: "we do not have one", aboutUs: "we are a good college", firstName: "Ghassan", lastName: "Al Shajjar", email: "IDK", password: "mamamia", type: .employer, profileImage: "idk", phoneNumber: "2134", location: "Aali")
var jobs: [job] = []


//var jobs: [job] = [
//    job(
//        jobTitle: "Software Developer", company:polyCompany ,
//        companyID: "POLYISSHIT",
//        jobDescription: "This is a software engineering job, you have no rights to work in this job.",
//        jobSalary: "7800",
//        jobType: .fullTime,
//        jobId: "1",
//        jobCategory: .software,
//        jobPosition: .Designer,
//        jobImage: "no",
//        jobSkills: ["Swift", "iOS Development"],
//        jobPostedDate: "2024-12-20",
//        salaryType: .monthly,
//        timeFromPost: "1 hour ago",
//        deadline: "2024-12-31",
//        applications: [application(dateOfApplication:"20/12/2024", jobSeeker: JobSeekerSample, isShortlisted: true, status: .pending)],
//        offer: "This is our final offer, take it or leave it."
//    ),
//    job(
//        jobTitle: "Graphic Designer", company: polyCompany,
//        companyID: "POLYISSHIT",
//        jobDescription: "We need a creative graphic designer with a passion for visual storytelling.",
//        jobSalary: "5000",
//        jobType: .partTime,
//        jobId: "2",
//        jobCategory: .finance,
//        jobPosition: .Designer,
//        jobImage: "graphic_logo",
//        jobSkills: ["Photoshop", "Illustrator", "Figma"],
//        jobPostedDate: "2024-12-18",
//        salaryType: .hourly,
//        timeFromPost: "3 days ago",
//        deadline: "2025-01-05",
//        applications: nil,
//        offer: "Flexible working hours and competitive pay."
//    ),
//    job(
//        jobTitle: "Data Scientist", company: polyCompany,
//        companyID: "POLYISSHIT",
//        jobDescription: "Analyze and interpret complex data to help improve business outcomes.",
//        jobSalary: "12000",
//        jobType: .fullTime,
//        jobId: "3",
//        jobCategory: .finance,
//        jobPosition: .Designer,
//        jobImage: "data_logo",
//        jobSkills: ["Python", "Machine Learning", "SQL"],
//        jobPostedDate: "2024-12-22",
//        salaryType: .monthly,
//        timeFromPost: "2 days ago",
//        deadline: "2025-01-15",
//        applications: nil,
//        offer: "Generous benefits package and remote work options."
//    ),
//    job(
//        jobTitle: "Janitor", company: polyCompany,
//        companyID: "POLYISSHIT",
//        jobDescription: "Ensure cleanliness and orderliness in the office premises.",
//        jobSalary: "2500",
//        jobType: .fullTime,
//        jobId: "4",
//        jobCategory: .software,
//        jobPosition: .softwareDev,
//        jobImage: "janitor_logo",
//        jobSkills: ["Cleaning", "Organizing"],
//        jobPostedDate: "2024-12-10",
//        salaryType: .monthly,
//        timeFromPost: "14 days ago",
//        deadline: "2024-12-31",
//        applications: nil,
//        offer: "Flexible hours and supportive team environment."
//    ),
//    job(
//        jobTitle: "Marketing Specialist", company: polyCompany,
//        companyID: "POLYISSHIT",
//        jobDescription: "Develop marketing strategies to increase brand awareness.",
//        jobSalary: "8500",
//        jobType: .fullTime,
//        jobId: "5",
//        jobCategory: .software,
//        jobPosition: .softwareDev,
//        jobImage: "marketing_logo",
//        jobSkills: ["SEO", "Content Marketing", "Social Media"],
//        jobPostedDate: "2024-12-15",
//        salaryType: .monthly,
//        timeFromPost: "9 days ago",
//        deadline: "2025-01-10",
//        applications: nil,
//        offer: "Opportunity to work on high-impact campaigns."
//    )
//]
var adminSections : [Section] = [
    Section(title: "Job Type", options: [jobTypes.fullTime.rawValue,jobTypes.partTime.rawValue]),
    Section(title: "Industry",options: ["Software","Hardware","Finance","Healthcare","Education","Other"]),
    Section(title: "Location",options: locations),
    Section(title: "Experience level",options: ["Entry Level","Mid Level","Senior Level"]),
    Section(title: "Work preference",options: ["Remote","On-site"])
    
]

var employerInsights : [job] = []
var skillAssessmentDashboards : [SkillAssessmentDashboard] = [
    SkillAssessmentDashboard(name: "Programming", filter1: "Language", filter1Options: ["C#","Java","Python"], tests: []),
    SkillAssessmentDashboard(name: "Analytics", filter1: "Type", filter1Options: ["type1","type2","type3"], tests: []),
    SkillAssessmentDashboard(name: "Networking", filter1: "Type", filter1Options: ["IPV4","IPV6","DNS"], tests: []),
    SkillAssessmentDashboard(name: "Cyber Security", filter1: "Type", filter1Options: ["Ethical Hacking","Pen Testing","Malware Analysis"], tests: []),
    SkillAssessmentDashboard(name: "Artificial Intelligence", filter1: "Type", filter1Options: ["machine learning","deep learning","natural language processing"], tests: [])
]

var SQProfile = Profile(userID: "SayedQass", profileImage: "no", phoneNumber: "35140480", location: "Isa town", firstName: "Sayed Qassim AHmed", lastName: "Alsari", email: "Qassimahmed2111@gmail.com", password: "SQ", type: .employer)


var SayedHamed = JobSeeker(userID: "SHAMED", personalSummary: "no summary", educations: nil, experiences: nil, skills: nil, preferences: nil, cv: "idksk", suggestedCareerPaths: nil, applications: nil, firstName: "Sayed Hamed", lastName: "Mahmood", email: "SayedHamed231@gmail.com", password: "test", type: .jobSeeker, profileImage: "hello", phoneNumber: "1235", location: "Location")

var testJob = job(jobTitle: "Title1", company: polyCompany, companyID: polyCompany.userID , jobDescription: "IDK", jobSalary: "4500", jobType: .fullTime, jobId: "anything", jobCategory: .software, jobPosition: .Designer, jobImage: "test", jobSkills: ["whatever"], jobPostedDate: "now", salaryType: .monthly, timeFromPost: "now", deadline: "tom", applications: nil, offer: "this is a great offer")
var companyProfile = polyCompany


//
//
//
//
//
//
//
