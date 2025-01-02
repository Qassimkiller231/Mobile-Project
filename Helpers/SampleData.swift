//
//  SampleData.swift
//  Project
//
//  Created by Guest User on 02/01/2025.
//

import Foundation
var SampleProfile = JobSeeker(userID: "1", personalSummary: "hi", educations: nil, experiences: nil, skills: nil, preferences: nil, cv: "nil", suggestedCareerPaths: nil, applications: nil, firstName: "Muntadher", lastName: "Abdulrahman", email: "202203075@student.polytechnic.bh", password: "Scoobysnac77!", type: .jobSeeker, profileImage: "nil", phoneNumber: "39658382", location: "Malkiya")

var SampleCompany = Company(userID: "poly", companyName:"reboot" , industry: "ITCS", website: "reboot.com", aboutUs: "nil", firstName: "Ali", lastName: "abdulla", email: "aliabdulla@gmail.com", password: "1234", type:.employer, profileImage: "nil", phoneNumber: "84325634", location: "aldana")

var jobseeker2 = JobSeeker(userID: "2", personalSummary: "this is jobSeeker 2", educations: nil, experiences: nil, skills: nil, preferences: nil, cv: "CV", suggestedCareerPaths: nil, applications: nil, firstName: "Ammar", lastName: "AlAradi", email: "Ammar@gmail.com", password: "1319S!", type: .jobSeeker, profileImage: "nil", phoneNumber: "21342342", location: "Aali")

var sampleJobs: [job] = [
    job(
        jobTitle: "Software Engineer",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Build and maintain software applications.",
        jobSalary: "$80,000 - $100,000",
        jobType: .fullTime,  // Enum: jobTypes
        jobId: "job001",
        jobCategory: .software, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions
        jobImage: "software_engineer.png",
        jobSkills: ["Swift", "Java", "iOS Development"], // Custom skill names
        jobPostedDate: "2025-01-01",
        salaryType: .monthly,  // Enum: SalaryType
        timeFromPost: "2 days ago",
        deadline: "2025-03-01",
        applications: nil,  // Applications first
        offer: "Full-time, health benefits" // Offer second
    ),
    
    job(
        jobTitle: "Product Manager",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Manage the lifecycle of tech products.",
        jobSalary: "$120,000 - $150,000",
        jobType: .fullTime,  // Enum: jobTypes
        jobId: "job002",
        jobCategory: .software, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions
        jobImage: "product_manager.png",
        jobSkills: ["Agile", "Scrum", "Product Roadmap"],
        jobPostedDate: "2025-01-02",
        salaryType: .monthly,  // Enum: SalaryType
        timeFromPost: "1 day ago",
        deadline: "2025-04-01",
        applications: nil,  // Applications first
        offer: "Full-time, bonus eligible" // Offer second
    ),
    
    job(
        jobTitle: "Marketing Specialist",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Develop and execute marketing campaigns.",
        jobSalary: "$70,000 - $85,000",
        jobType: .partTime,  // Enum: jobTypes
        jobId: "job003",
        jobCategory: .finance, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions (custom value)
        jobImage: "marketing_specialist.png",
        jobSkills: ["SEO", "Social Media", "Content Marketing"],
        jobPostedDate: "2025-01-03",
        salaryType: .monthly,  // Enum: SalaryType
        timeFromPost: "Today",
        deadline: "2025-03-01",
        applications: nil,  // Applications first
        offer: "Part-time, health insurance" // Offer second
    ),
    
    job(
        jobTitle: "UX/UI Designer",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Design user interfaces and improve user experiences.",
        jobSalary: "$75,000 - $95,000",
        jobType: .fullTime,  // Enum: jobTypes
        jobId: "job004",
        jobCategory: .software, // Enum: jobCategories
        jobPosition: .Designer, // Enum: jobPositions
        jobImage: "ux_ui_designer.png",
        jobSkills: ["Figma", "Sketch", "Adobe XD"],
        jobPostedDate: "2025-01-04",
        salaryType: .monthly,  // Enum: SalaryType
        timeFromPost: "3 days ago",
        deadline: "2025-02-28",
        applications: nil,  // Applications first
        offer: "Full-time, flexible hours" // Offer second
    ),
    
    job(
        jobTitle: "Data Scientist",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Analyze data to provide actionable insights.",
        jobSalary: "$100,000 - $120,000",
        jobType: .contract,  // Enum: jobTypes
        jobId: "job005",
        jobCategory: .software, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions
        jobImage: "data_scientist.png",
        jobSkills: ["Python", "SQL", "Machine Learning"],
        jobPostedDate: "2025-01-05",
        salaryType: .monthly,  // Enum: SalaryType
        timeFromPost: "4 days ago",
        deadline: "2025-02-15",
        applications: nil,  // Applications first
        offer: "Contract-based, performance bonus" // Offer second
    ),
    
    job(
        jobTitle: "HR Manager",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Manage recruitment and employee relations.",
        jobSalary: "$85,000 - $105,000",
        jobType: .fullTime,  // Enum: jobTypes
        jobId: "job006",
        jobCategory: .finance, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions (custom value)
        jobImage: "hr_manager.png",
        jobSkills: ["Recruitment", "Employee Relations", "Compliance"],
        jobPostedDate: "2025-01-06",
        salaryType: .monthly,  // Enum: SalaryType
        timeFromPost: "Today",
        deadline: "2025-03-15",
        applications: nil,  // Applications first
        offer: "Full-time, health benefits" // Offer second
    ),
    
    job(
        jobTitle: "Sales Executive",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Drive sales and manage client accounts.",
        jobSalary: "$65,000 - $85,000",
        jobType: .freelance,  // Enum: jobTypes
        jobId: "job007",
        jobCategory: .finance, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions (custom value)
        jobImage: "sales_executive.png",
        jobSkills: ["Sales Strategy", "Client Management", "Negotiation"],
        jobPostedDate: "2025-01-07",
        salaryType: .hourly,  // Enum: SalaryType
        timeFromPost: "5 days ago",
        deadline: "2025-03-01",
        applications: nil,  // Applications first
        offer: "Freelance, commission-based" // Offer second
    ),
    
    job(
        jobTitle: "Business Analyst",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Analyze business processes and provide recommendations.",
        jobSalary: "$90,000 - $110,000",
        jobType: .projectBased,  // Enum: jobTypes
        jobId: "job008",
        jobCategory: .software, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions (custom value)
        jobImage: "business_analyst.png",
        jobSkills: ["Data Analysis", "Business Process Modeling", "Excel"],
        jobPostedDate: "2025-01-08",
        salaryType: .hourly,  // Enum: SalaryType
        timeFromPost: "6 days ago",
        deadline: "2025-03-10",
        applications: nil,  // Applications first
        offer: "Project-based, health benefits" // Offer second
    ),
    
    job(
        jobTitle: "Customer Support Representative",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Provide support for customers and resolve their issues.",
        jobSalary: "$45,000 - $60,000",
        jobType: .partTime,  // Enum: jobTypes
        jobId: "job009",
        jobCategory: .finance, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions (custom value)
        jobImage: "customer_support.png",
        jobSkills: ["Communication", "Problem-solving", "Customer Service"],
        jobPostedDate: "2025-01-09",
        salaryType: .hourly,  // Enum: SalaryType
        timeFromPost: "7 days ago",
        deadline: "2025-04-01",
        applications: nil,  // Applications first
        offer: "Part-time, bonuses available" // Offer second
    ),
    
    job(
        jobTitle: "Software Tester",
        company: SampleCompany,
        companyID: SampleCompany.userID,
        jobDescription: "Test and validate software to ensure it meets the required standards.",
        jobSalary: "$60,000 - $80,000",
        jobType: .fullTime,  // Enum: jobTypes
        jobId: "job010",
        jobCategory: .software, // Enum: jobCategories
        jobPosition: .softwareDev, // Enum: jobPositions
        jobImage: "software_tester.png",
        jobSkills: ["Automated Testing", "Manual Testing", "QA"],
        jobPostedDate: "2025-01-10",
        salaryType: .hourly,  // Enum: SalaryType
        timeFromPost: "8 days ago",
        deadline: "2025-03-15",
        applications: nil,  // Applications first
        offer: "Full-time, bonuses available" // Offer second
    )
]

let sampleApplications: [application] = [
    application(applicationNo: 1, dateOfApplication: "2025-01-01", jobSeeker: SampleProfile, isShortlisted: true, interview: nil, notes: nil, status: .pending),
    application(applicationNo: 2, dateOfApplication: "2025-01-02", jobSeeker: jobseeker2, isShortlisted: false, interview: nil, notes: "Need to improve portfolio.", status: .rejected),
    application(applicationNo: 3, dateOfApplication: "2025-01-03", jobSeeker: SampleProfile, isShortlisted: true, interview: nil, notes: "Looking forward to the opportunity.", status: .pending),
    application(applicationNo: 4, dateOfApplication: "2025-01-04", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "Strong fit for the role.", status: .accepted),
    application(applicationNo: 5, dateOfApplication: "2025-01-05", jobSeeker: SampleProfile, isShortlisted: false, interview: nil, notes: "Resume needs work.", status: .rejected),
    application(applicationNo: 6, dateOfApplication: "2025-01-06", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "Eager to contribute.", status: .pending),
    application(applicationNo: 7, dateOfApplication: "2025-01-07", jobSeeker: SampleProfile, isShortlisted: false, interview: nil, notes: "Not the right fit for the company culture.", status: .rejected),
    application(applicationNo: 8, dateOfApplication: "2025-01-08", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "Looks like a great company.", status: .pending),
    application(applicationNo: 9, dateOfApplication: "2025-01-09", jobSeeker: SampleProfile, isShortlisted: true, interview: nil, notes: "I'm excited to talk with the team.", status: .pending),
    application(applicationNo: 10, dateOfApplication: "2025-01-10", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "Great match with the job description.", status: .accepted),
    application(applicationNo: 11, dateOfApplication: "2025-01-11", jobSeeker: SampleProfile, isShortlisted: false, interview: nil, notes: "Lack of relevant experience.", status: .rejected),
    application(applicationNo: 12, dateOfApplication: "2025-01-12", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: nil, status: .pending),
    application(applicationNo: 13, dateOfApplication: "2025-01-13", jobSeeker: jobseeker2, isShortlisted: false, interview: nil, notes: "Job responsibilities unclear.", status: .rejected),
    application(applicationNo: 14, dateOfApplication: "2025-01-14", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "I'm very interested in this opportunity.", status: .pending),
    application(applicationNo: 15, dateOfApplication: "2025-01-15", jobSeeker: jobseeker2, isShortlisted: false, interview: nil, notes: "Could not match expectations.", status: .rejected),
    application(applicationNo: 16, dateOfApplication: "2025-01-16", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: nil, status: .pending),
    application(applicationNo: 17, dateOfApplication: "2025-01-17", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "Strong background in data analysis.", status: .accepted),
    application(applicationNo: 18, dateOfApplication: "2025-01-18", jobSeeker: jobseeker2, isShortlisted: false, interview: nil, notes: "Not enough experience in the field.", status: .rejected),
    application(applicationNo: 19, dateOfApplication: "2025-01-19", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: "Impressed with the company culture.", status: .pending),
    application(applicationNo: 20, dateOfApplication: "2025-01-20", jobSeeker: jobseeker2, isShortlisted: true, interview: nil, notes: nil, status: .pending)
]



// Assuming sampleJobs is already populated



