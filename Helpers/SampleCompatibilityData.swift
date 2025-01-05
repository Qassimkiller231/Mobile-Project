//
//  SampleCompatibilityData.swift
//  Project
//
//  Created by Guest User on 02/01/2025.
//

import Foundation
import FirebaseFirestore

struct JobCompatibility: Codable {
    var applicaton : application?
    var jobTitle :String
    var salary: Double
    var qualifications: [String]
    var preferences: [String]
    var location: String
}

struct CategoryDistance : Codable {
    var from: String
    var to: String
    var distance: Double // Distance in kilometers
}

let categoryDistances: [CategoryDistance] = [
    CategoryDistance(from: "Category 1", to: "Category 2", distance: 25.0),
    CategoryDistance(from: "Category 1", to: "Category 3", distance: 18.0),
    CategoryDistance(from: "Category 1", to: "Category 4", distance: 36.0),
    //D2
    CategoryDistance(from: "Category 2", to: "Category 1", distance: 25.0),
    CategoryDistance(from: "Category 2", to: "Category 3", distance: 13.0),
    CategoryDistance(from: "Category 2", to: "Category 4", distance: 21.0),
    //D3
    CategoryDistance(from: "Category 3", to: "Category 1", distance: 18.0),
    CategoryDistance(from: "Category 3", to: "Category 2", distance: 25.0),
    CategoryDistance(from: "Category 3", to: "Category 4", distance: 32.0),
    //D4
    CategoryDistance(from: "Category 4", to: "Category 1", distance: 36.0),
    CategoryDistance(from: "Category 4", to: "Category 2", distance: 15.0),
    CategoryDistance(from: "Category 4", to: "Category 3", distance: 22.0),
]

struct LocationCategory : Codable {
    var name: String
    var locations: [String]
}

let locationCategories: [LocationCategory] = [
    LocationCategory(name: "Category 1", locations: ["Malkiya", "Saddad"]),
    LocationCategory(name: "Category 2", locations: ["Manama", "Adliyah"]),
    LocationCategory(name: "Category 3", locations: ["Aali", "Isa town"]),
    LocationCategory(name: "Category 4", locations: ["Muharaq", "Dair", "Qalali"])
]

let jobCompatibilities: [JobCompatibility] = [
    JobCompatibility(
        jobTitle: "AI Developer",
        salary: 105000, // Average salary for the role
        qualifications: ["Bachelor's Degree in Computer Science", "AI/ML", "Programming"],
        preferences: ["Remote work", "Flexible hours"],
        location: "Malkiya"
        
    ),
    
    JobCompatibility(
        jobTitle: "Designer",
        salary: 70000,
        qualifications: ["Bachelor's Degree in Design", "Portfolio of work", "Proficiency in design software"],
        preferences: ["Creative environment", "Opportunities for professional development"],
        location: "Manama"
    ),
    
    JobCompatibility(
        jobTitle: "Analyst",
        salary: 85000,
        qualifications: ["Bachelor's Degree in Healthcare or Data Science", "Strong analytical skills", "Experience with data analysis tools"],
        preferences: ["Work-life balance", "Team collaboration"],
        location: "Aali"
    ),
    
    JobCompatibility(
        jobTitle: "Developer",
        salary: 75000,
        qualifications: ["Bachelor's Degree in Education", "Experience in curriculum design", "Strong writing skills"],
        preferences: ["Collaborative team", "Focus on innovative teaching methods"],
        location: "Muharaq"
    ),
    
    JobCompatibility(
        jobTitle: "Consultant",
        salary: 80000,
        qualifications: ["Bachelor's Degree in Environmental Science", "Experience in consulting", "Knowledge of sustainability practices"],
        preferences: ["Passion for the environment", "Diverse projects"],
        location: "Saddad"
    ),
    
    JobCompatibility(
        jobTitle: "Writer",
        salary: 60000,
        qualifications: ["Bachelor's Degree in English or Communication", "Strong writing samples", "SEO knowledge"],
        preferences: ["Creative freedom", "Remote work options"],
        location: "Dair"
    ),
    
    JobCompatibility(
        jobTitle: "Manager",
        salary: 65000,
        qualifications: ["High School Diploma or equivalent", "Experience in retail management", "Strong leadership skills"],
        preferences: ["Fast-paced environment", "Opportunities for advancement"],
        location: "Adliyah"
    )
]


