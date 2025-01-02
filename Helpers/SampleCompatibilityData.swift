//
//  SampleCompatibilityData.swift
//  Project
//
//  Created by Guest User on 02/01/2025.
//

import Foundation


struct JobCompatibility {
    var jobTitle :String
    var salary: Double
    var qualifications: [String]
    var preferences: [String]
}

let jobCompatibilities: [JobCompatibility] = [
    JobCompatibility(
        jobTitle: "AI Developer",
        salary: 105000, // Average salary for the role
        qualifications: ["Bachelor's Degree in Computer Science", "AI/ML", "Programming"],
        preferences: ["Remote work", "Flexible hours"]
    ),
    
    JobCompatibility(
        jobTitle: "Designer",
        salary: 70000,
        qualifications: ["Bachelor's Degree in Design", "Portfolio of work", "Proficiency in design software"],
        preferences: ["Creative environment", "Opportunities for professional development"]
    ),
    
    JobCompatibility(
        jobTitle: "Analyst",
        salary: 85000,
        qualifications: ["Bachelor's Degree in Healthcare or Data Science", "Strong analytical skills", "Experience with data analysis tools"],
        preferences: ["Work-life balance", "Team collaboration"]
    ),
    
    JobCompatibility(
        jobTitle: "Developer",
        salary: 75000,
        qualifications: ["Bachelor's Degree in Education", "Experience in curriculum design", "Strong writing skills"],
        preferences: ["Collaborative team", "Focus on innovative teaching methods"]
    ),
    
    JobCompatibility(
        jobTitle: "Consultant",
        salary: 80000,
        qualifications: ["Bachelor's Degree in Environmental Science", "Experience in consulting", "Knowledge of sustainability practices"],
        preferences: ["Passion for the environment", "Diverse projects"]
    ),
    
    JobCompatibility(
        jobTitle: "Writer",
        salary: 60000,
        qualifications: ["Bachelor's Degree in English or Communication", "Strong writing samples", "SEO knowledge"],
        preferences: ["Creative freedom", "Remote work options"]
    ),
    
    JobCompatibility(
        jobTitle: "Manager",
        salary: 65000,
        qualifications: ["High School Diploma or equivalent", "Experience in retail management", "Strong leadership skills"],
        preferences: ["Fast-paced environment", "Opportunities for advancement"]
    )
]


