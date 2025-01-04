//
//  SampleDateM12.swift
//  Project
//
//  Created by Guest User on 02/01/2025.
//

import Foundation
struct MarketTrend {
    var jobTitle: String
    var jobDescription: String
    var growthRate: Double
}

var allMarketTrends: [MarketTrend] = [
    MarketTrend(jobTitle: "Software Developer", jobDescription: "High demand due to increased digital transformation.", growthRate: 22.0),
    MarketTrend(jobTitle: "Data Scientist", jobDescription: "Significant growth driven by data-driven decision-making.", growthRate: 60.0),
    MarketTrend(jobTitle: "UX Designer", jobDescription: "Rising importance of user experience in digital products.", growthRate: 25.0),
    MarketTrend(jobTitle: "Cyber Security Analyst", jobDescription: "Increased threats have heightened demand for security experts.", growthRate: 75.0),
    MarketTrend(jobTitle: "Cloud Engineer", jobDescription: "Growth in cloud adoption across various industries.", growthRate: 50.0),
    MarketTrend(jobTitle: "Digital Marketing Specialist", jobDescription: "E-commerce growth has led to a higher demand for digital marketing.", growthRate: 20.0),
    MarketTrend(jobTitle: "DevOps Engineer", jobDescription: "Demand for agile development practices has surged.", growthRate: 35.0),
    MarketTrend(jobTitle: "AI/Machine Learning Engineer", jobDescription: "Rapid advancements in AI technology have driven job creation.", growthRate: 90.0),
    MarketTrend(jobTitle: "Healthcare Administrator", jobDescription: "Increased focus on healthcare management post-pandemic.", growthRate: 15.0),
    MarketTrend(jobTitle: "Product Manager", jobDescription: "Growing need for aligning product strategy with market needs.", growthRate: 10.0)
]

var SampleProfile2 = JobSeeker(userID: "1", personalSummary: "hi", educations: nil, experiences: [Experience(jobTitle: "Bachelor's Degree in Design", companyName: "SampleCompany", startDate: "10/10/2013", endDate: "12/06/2015", city: "Manama")], skills: [Skill(skillName: "Programming", skillLevel: "advanced")], preferences:["Skill Development","Mentorship","Full-time work","Professional Certifications"], cv: "nil", suggestedCareerPaths: nil, applications: nil, firstName: "Muntadher", lastName: "Abdulrahman", email: "202203075@student.polytechnic.bh", password: "Scoobysnac77!", type: .jobSeeker, profileImage: "nil", phoneNumber: "39658382", location: "Malkiya")
var SampleProfile3 = JobSeeker(userID: "2", personalSummary: "hola", educations: nil, experiences: [Experience(jobTitle: "Bachelor's Degree in Developing", companyName: "SampleCompany", startDate: "10/10/2015", endDate: "12/06/2020", city: "Diraz")], skills: [Skill(skillName: "DataBase", skillLevel: "advanced")], preferences:["Skill Development","Networking","Part-time work","Professional Certifications"], cv: "nil", suggestedCareerPaths: nil, applications: nil, firstName: "Hussain", lastName: "AlAkraf", email: "197201111@student.polytechnic.bh", password: "Akrafy!", type: .jobSeeker, profileImage: "nil", phoneNumber: "38353928", location: "Diraz")
//var careerPaths : [CareerPath] = [
//    CareerPath(interests: ["Programming","Design","Marketing"], skills: [], position: .Designer, description: <#T##String#>)
//]
let allPreferences = ["Skill Development", "Remote Work", "Career Advice", "Industry News", "Professional Certifications", "Networking", "Freelance Work", "Workshops & Events", "Mentorship", "Diversity & Inclusion","Coding","Full-time work","Part-time work"]
var skillsArray : [Skill] = [
    
]
func filterCareerPaths(for jobSeeker: JobSeeker, allPaths: [CareerPath]) -> [String: [CareerPath]] {
    // Grouped career paths
    var groupedPaths: [String: [CareerPath]] = [:]

    // Iterate over career paths
    for path in allPaths {
        // Check if the user's skills match the required skills
        let matchingSkills = path.skills.filter { requiredSkill in
            jobSeeker.skills?.contains(where: { $0.skillName == requiredSkill.skillName }) == true
        }
        
        // Check if user's preferences align with the career path interests
        let matchingPreferences = path.interests.filter { interest in
            jobSeeker.preferences?.contains(interest) == true
        }

        // If there are matches, add to group
        if !matchingSkills.isEmpty || !matchingPreferences.isEmpty {
            let groupKey = path.position.rawValue // Example: "Designer", "Developer"
            groupedPaths[groupKey, default: []].append(path)
        }
    }
    return groupedPaths
}

let allCareerPaths = [
    CareerPath(interests: ["Skill Development", "Professional Certifications"], skills: [Skill(skillName: "Programming", skillLevel: "Advanced")], position: .SoftwareEngineer, description: "Software Engineer specializing in full-stack development"),
    CareerPath(interests: ["Remote Work", "Industry News"], skills: [Skill(skillName: "Cloud Computing", skillLevel: "Intermediate")], position: .CloudEngineer, description: "Cloud Engineer managing scalable cloud solutions"),
    CareerPath(interests: ["Career Advice", "Networking"], skills: [Skill(skillName: "Data Analysis", skillLevel: "Advanced")], position: .DataScientist, description: "Data Scientist focusing on predictive analytics"),
    CareerPath(interests: ["Industry News", "Workshops & Events"], skills: [Skill(skillName: "Cybersecurity", skillLevel: "Expert")], position: .CyberSecuritySpecialist, description: "Cybersecurity Specialist protecting IT infrastructure"),
    CareerPath(interests: ["Professional Certifications", "Mentorship"], skills: [Skill(skillName: "Network Configuration", skillLevel: "Advanced")], position: .NetworkAdministrator, description: "Network Administrator managing enterprise networks"),
    CareerPath(interests: ["Skill Development", "Freelance Work"], skills: [Skill(skillName: "App Development", skillLevel: "Intermediate")], position: .MobileAppDeveloper, description: "Mobile App Developer building Android and iOS apps"),
    CareerPath(interests: ["Networking", "Diversity & Inclusion"], skills: [Skill(skillName: "System Design", skillLevel: "Expert")], position: .SystemArchitect, description: "System Architect designing enterprise IT systems"),
    CareerPath(interests: ["Remote Work", "Freelance Work"], skills: [Skill(skillName: "Web Development", skillLevel: "Intermediate")], position: .FrontendDeveloper, description: "Frontend Developer creating responsive web interfaces"),
    CareerPath(interests: ["Industry News", "Skill Development"], skills: [Skill(skillName: "Database Management", skillLevel: "Advanced")], position: .DatabaseAdministrator, description: "Database Administrator optimizing database performance"),
    CareerPath(interests: ["Mentorship", "Career Advice"], skills: [Skill(skillName: "Technical Support", skillLevel: "Intermediate")], position: .ITSupportSpecialist, description: "IT Support Specialist resolving technical issues"),
    CareerPath(interests: ["Skill Development", "Professional Certifications"], skills: [Skill(skillName: "Machine Learning", skillLevel: "Advanced")], position: .MachineLearningEngineer, description: "Machine Learning Engineer creating AI models"),
    CareerPath(interests: ["Remote Work", "Networking"], skills: [Skill(skillName: "DevOps", skillLevel: "Expert")], position: .DevOpsEngineer, description: "DevOps Engineer ensuring smooth deployment pipelines"),
    CareerPath(interests: ["Freelance Work", "Workshops & Events"], skills: [Skill(skillName: "UI/UX Design", skillLevel: "Intermediate")], position: .UXDesigner, description: "UX Designer crafting user-friendly interfaces"),
    CareerPath(interests: ["Skill Development", "Industry News"], skills: [Skill(skillName: "Embedded Systems", skillLevel: "Advanced")], position: .EmbeddedSystemsEngineer, description: "Embedded Systems Engineer developing IoT devices"),
    CareerPath(interests: ["Networking", "Mentorship"], skills: [Skill(skillName: "Blockchain Development", skillLevel: "Intermediate")], position: .BlockchainDeveloper, description: "Blockchain Developer creating decentralized apps"),
    CareerPath(interests: ["Professional Certifications", "Workshops & Events"], skills: [Skill(skillName: "Penetration Testing", skillLevel: "Advanced")], position: .PenetrationTester, description: "Penetration Tester identifying system vulnerabilities"),
    CareerPath(interests: ["Industry News", "Remote Work"], skills: [Skill(skillName: "Data Visualization", skillLevel: "Advanced")], position: .DataVisualizationSpecialist, description: "Data Visualization Specialist creating dashboards"),
    CareerPath(interests: ["Skill Development", "Mentorship"], skills: [Skill(skillName: "Robotics Programming", skillLevel: "Intermediate")], position: .RoboticsEngineer, description: "Robotics Engineer developing automation solutions"),
    CareerPath(interests: ["Freelance Work", "Networking"], skills: [Skill(skillName: "Game Development", skillLevel: "Intermediate")], position: .GameDeveloper, description: "Game Developer creating immersive experiences"),
    CareerPath(interests: ["Skill Development", "Career Advice"], skills: [Skill(skillName: "IT Management", skillLevel: "Expert")], position: .ITManager, description: "IT Manager overseeing IT operations")
]
let careerPathsGrouped: [(category: String, paths: [CareerPath])] = [
    (
        category: "Software Development",
        paths: allCareerPaths.filter { $0.position == .SoftwareEngineer || $0.position == .MobileAppDeveloper || $0.position == .EmbeddedSystemsEngineer || $0.position == .GameDeveloper }
    ),
    (
        category: "Data and Analytics",
        paths: allCareerPaths.filter { $0.position == .DataScientist || $0.position == .DatabaseAdministrator || $0.position == .DataVisualizationSpecialist || $0.position == .MachineLearningEngineer }
    ),
    (
        category: "Networking and Cloud",
        paths: allCareerPaths.filter { $0.position == .CloudEngineer || $0.position == .NetworkAdministrator || $0.position == .DevOpsEngineer || $0.position == .SystemArchitect }
    ),
    (
        category: "Security and IT Support",
        paths: allCareerPaths.filter { $0.position == .CyberSecuritySpecialist || $0.position == .PenetrationTester || $0.position == .ITSupportSpecialist }
    ),
    (
        category: "IT Leadership and Management",
        paths: allCareerPaths.filter { $0.position == .ITManager || $0.position == .UXDesigner || $0.position == .RoboticsEngineer || $0.position == .BlockchainDeveloper }
    )
]


let sampleJobs2: [job] = [
    job(
        jobTitle: "AI Developer",
        company: sampleCompanies[0],
        companyID: sampleCompanies[0].userID,
        jobDescription: "Develop AI algorithms and machine learning models.",
        jobSalary: "$90,000 - $120,000",
        jobType: .fullTime,
        jobId: "jobAIDev001",
        jobCategory: .software,
        jobPosition: .softwareDev,
        jobImage: "ai_developer.png",
        jobSkills: ["Python", "Machine Learning", allPreferences[4]], // Skill Development
        jobPostedDate: "2025-01-01",
        salaryType: .monthly,
        timeFromPost: "2 days ago",
        deadline: "2025-03-01",
        applications: nil,
        offer: "Full-time, health benefits"
    ),
    job(
        jobTitle: "UI/UX Designer",
        company: sampleCompanies[1],
        companyID: sampleCompanies[1].userID,
        jobDescription: "Design user-friendly interfaces for web and mobile apps.",
        jobSalary: "$70,000 - $100,000",
        jobType: .fullTime,
        jobId: "jobUIDesign002",
        jobCategory: .design,
        jobPosition: .Designer,
        jobImage: "ui_ux_designer.png",
        jobSkills: ["Adobe XD", "Figma", allPreferences[1]], // Networking
        jobPostedDate: "2025-01-02",
        salaryType: .yearly,
        timeFromPost: "1 day ago",
        deadline: "2025-02-15",
        applications: nil,
        offer: "Remote work options available"
    ),
    job(
        jobTitle: "Data Scientist",
        company: sampleCompanies[0],
        companyID: sampleCompanies[0].userID,
        jobDescription: "Analyze data and develop machine learning solutions.",
        jobSalary: "$100,000 - $140,000",
        jobType: .fullTime,
        jobId: "jobDataSci003",
        jobCategory: .software,
        jobPosition: .DataScientist,
        jobImage: "data_scientist.png",
        jobSkills: ["Python", "Data Analysis", allPreferences[3]], // Industry News
        jobPostedDate: "2025-01-01",
        salaryType: .monthly,
        timeFromPost: "3 days ago",
        deadline: "2025-03-10",
        applications: nil,
        offer: "Flexible work hours"
    ),
    job(
        jobTitle: "Project Manager",
        company: sampleCompanies[3],
        companyID: sampleCompanies[3].userID,
        jobDescription: "Lead teams to deliver projects on time and within scope.",
        jobSalary: "$110,000 - $150,000",
        jobType: .fullTime,
        jobId: "jobProjMan004",
        jobCategory: .management,
        jobPosition: .projectManager,
        jobImage: "project_manager.png",
        jobSkills: ["Leadership", allPreferences[7], allPreferences[2]], // Workshops & Events, Career Advice
        jobPostedDate: "2025-01-03",
        salaryType: .yearly,
        timeFromPost: "1 day ago",
        deadline: "2025-02-28",
        applications: nil,
        offer: "Healthcare and stock options"
    ),
    job(
        jobTitle: "Frontend Developer",
        company: sampleCompanies[0],
        companyID: sampleCompanies[0].userID,
        jobDescription: "Develop responsive front-end web applications.",
        jobSalary: "$80,000 - $110,000",
        jobType: .fullTime,
        jobId: "jobFrontend005",
        jobCategory: .software,
        jobPosition: .FrontendDeveloper,
        jobImage: "frontend_dev.png",
        jobSkills: ["JavaScript", "React", allPreferences[11]], // Remote Work
        jobPostedDate: "2025-01-01",
        salaryType: .monthly,
        timeFromPost: "4 days ago",
        deadline: "2025-02-20",
        applications: nil,
        offer: "Hybrid work policy"
    ),
    job(
        jobTitle: "Digital Marketing Specialist",
        company: sampleCompanies[6],
        companyID: sampleCompanies[6].userID,
        jobDescription: "Execute marketing campaigns across digital channels.",
        jobSalary: "$60,000 - $90,000",
        jobType: .fullTime,
        jobId: "jobDigiMark006",
        jobCategory: .marketing,
        jobPosition: .marketingSpecialist,
        jobImage: "digital_marketing.png",
        jobSkills: ["SEO", "Content Writing", allPreferences[5]], // Mentorship
        jobPostedDate: "2025-01-04",
        salaryType: .yearly,
        timeFromPost: "Just posted",
        deadline: "2025-03-01",
        applications: nil,
        offer: "Performance bonuses available"
    ),
    job(
        jobTitle: "Cloud Engineer",
        company: sampleCompanies[0],
        companyID: sampleCompanies[0].userID,
        jobDescription: "Build and maintain cloud infrastructure.",
        jobSalary: "$100,000 - $130,000",
        jobType: .fullTime,
        jobId: "jobCloudEng007",
        jobCategory: .software,
        jobPosition: .CloudEngineer,
        jobImage: "cloud_engineer.png",
        jobSkills: ["AWS", "Cloud Computing", allPreferences[10]], // Professional Certifications
        jobPostedDate: "2025-01-02",
        salaryType: .monthly,
        timeFromPost: "2 days ago",
        deadline: "2025-03-10",
        applications: nil,
        offer: "401k and stock options"
    ),
    job(
        jobTitle: "Cybersecurity Analyst",
        company: sampleCompanies[0],
        companyID: sampleCompanies[0].userID,
        jobDescription: "Monitor and protect IT infrastructure from threats.",
        jobSalary: "$95,000 - $125,000",
        jobType: .fullTime,
        jobId: "jobCyberSec008",
        jobCategory: .software,
        jobPosition: .CyberSecuritySpecialist,
        jobImage: "cybersecurity.png",
        jobSkills: ["Cybersecurity", "Penetration Testing", allPreferences[7]], // Workshops & Events
        jobPostedDate: "2025-01-05",
        salaryType: .monthly,
        timeFromPost: "Just posted",
        deadline: "2025-02-28",
        applications: nil,
        offer: "Health insurance and paid vacation"
    ),
    job(
        jobTitle: "IT Support Specialist",
        company: sampleCompanies[7],
        companyID: sampleCompanies[7].userID,
        jobDescription: "Provide technical support to employees and clients.",
        jobSalary: "$50,000 - $70,000",
        jobType: .fullTime,
        jobId: "jobITSupport009",
        jobCategory: .software,
        jobPosition: .itSupport,
        jobImage: "it_support.png",
        jobSkills: ["Technical Support", "Troubleshooting", allPreferences[2]], // Career Advice
        jobPostedDate: "2025-01-03",
        salaryType: .yearly,
        timeFromPost: "2 days ago",
        deadline: "2025-03-05",
        applications: nil,
        offer: "Employee discounts"
    ),
    job(
        jobTitle: "Blockchain Developer",
        company: sampleCompanies[0],
        companyID: sampleCompanies[0].userID,
        jobDescription: "Develop decentralized applications and smart contracts.",
        jobSalary: "$110,000 - $140,000",
        jobType: .fullTime,
        jobId: "jobBlockchain010",
        jobCategory: .software,
        jobPosition: .BlockchainDeveloper,
        jobImage: "blockchain_dev.png",
        jobSkills: ["Blockchain", "Smart Contracts", allPreferences[4]], // Skill Development
        jobPostedDate: "2025-01-01",
        salaryType: .monthly,
        timeFromPost: "3 days ago",
        deadline: "2025-03-10",
        applications: nil,
        offer: "Full-time, remote options available"
    )
]

let allApplications: [application] = [
    application(applicationNo: 1, dateOfApplication: "2025-01-01", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 2, dateOfApplication: "2025-01-02", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Follow up after two weeks", status: .pending, jobTitle: ""),
    application(applicationNo: 3, dateOfApplication: "2025-01-03", jobSeeker: SampleProfile2, isShortlisted: true, interview: nil, notes: "Awaiting interview date", status: .accepted, jobTitle: ""),
    application(applicationNo: 4, dateOfApplication: "2025-01-04", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 5, dateOfApplication: "2025-01-05", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Requested portfolio", status: .pending, jobTitle: ""),
    application(applicationNo: 6, dateOfApplication: "2025-01-06", jobSeeker: SampleProfile2, isShortlisted: true, interview: nil, notes: nil, status: .accepted, jobTitle: ""),
    application(applicationNo: 7, dateOfApplication: "2025-01-07", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 8, dateOfApplication: "2025-01-08", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Contact hiring manager", status: .pending, jobTitle: ""),
    application(applicationNo: 9, dateOfApplication: "2025-01-09", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Check application status", status: .pending, jobTitle: ""),
    application(applicationNo: 10, dateOfApplication: "2025-01-10", jobSeeker: SampleProfile2, isShortlisted: true, interview: nil, notes: nil, status: .accepted, jobTitle: ""),
    application(applicationNo: 11, dateOfApplication: "2025-01-11", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 12, dateOfApplication: "2025-01-12", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 13, dateOfApplication: "2025-01-13", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Requested additional documents", status: .pending, jobTitle: ""),
    application(applicationNo: 14, dateOfApplication: "2025-01-14", jobSeeker: SampleProfile2, isShortlisted: true, interview: nil, notes: "Awaiting decision", status: .accepted, jobTitle: ""),
    application(applicationNo: 15, dateOfApplication: "2025-01-15", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Pending approval from HR", status: .pending, jobTitle: ""),
    application(applicationNo: 16, dateOfApplication: "2025-01-16", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: "Follow up after a week", status: .pending, jobTitle: ""),
    application(applicationNo: 17, dateOfApplication: "2025-01-17", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 18, dateOfApplication: "2025-01-18", jobSeeker: SampleProfile2, isShortlisted: true, interview: nil, notes: "Awaiting interview schedule", status: .accepted, jobTitle: ""),
    application(applicationNo: 19, dateOfApplication: "2025-01-19", jobSeeker: SampleProfile2, isShortlisted: false, interview: nil, notes: nil, status: .pending, jobTitle: ""),
    application(applicationNo: 20, dateOfApplication: "2025-01-20", jobSeeker: SampleProfile2, isShortlisted: true, interview: nil, notes: nil, status: .accepted, jobTitle: "")
]

