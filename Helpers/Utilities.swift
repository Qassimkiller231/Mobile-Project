//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
@MainActor

class Utilities {
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    class DataManager  {
        static var shared = DataManager()
         var Jobs: [job] = []
         var profile: Profile?
         var allUsers: [AppUser] = []
         var allCompanies : [Company] = []
         var allJobs : [job] = []
        private let db = Firestore.firestore()
            private(set) var companies: [Company] = []
        
         func uploadCompany(_ company: Company) {
                let db = Firestore.firestore()
                let collectionRef = db.collection("MuntadherCompanies") // Collection for storing companies
                
                do {
                    let documentRef = try collectionRef.addDocument(from: company)
                    documentRef.setData(try Firestore.Encoder().encode(company)) { error in
                        if let error = error {
                            print("Failed to upload company: \(error.localizedDescription)")
                        } else {
                            print("Company successfully uploaded!")
                        }
                    }
                } catch {
                    print("Failed to encode company: \(error.localizedDescription)")
                }
            }
        
        
        
        
         func uploadCompanies(_ companies: [Company]) {
                let db = Firestore.firestore()
                let collectionRef = db.collection("MuntadherCompanies")
                
                for company in companies {
                    do {
                        let documentRef = try collectionRef.addDocument(from: company)
                        documentRef.setData(try Firestore.Encoder().encode(company)) { error in
                            if let error = error {
                                print("Failed to upload company: \(error.localizedDescription)")
                            } else {
                                print("Company successfully uploaded!")
                            }
                        }
                    } catch {
                        print("Failed to encode company: \(error.localizedDescription)")
                    }
                }
            }
        
        func fetchCompanies() async throws {
                let collectionRef = db.collection("MuntadherCompanies")
                let snapshot = try await collectionRef.getDocuments()
                let fetchedCompanies = try snapshot.documents.map { document in
                    try document.data(as: Company.self)
                }
                self.companies = fetchedCompanies
                print("Successfully fetched \(fetchedCompanies.count) companies.")
            }
        
        
        
         func uploadApplication(_ application: application) {
            let db = Firestore.firestore()
            let collectionRef = db.collection("Applications") // Collection for storing applications
            
            do {
                let documentRef = try collectionRef.addDocument(from: application)
                documentRef.setData(try Firestore.Encoder().encode(application)) { error in
                    if let error = error {
                        print("Failed to upload application: \(error.localizedDescription)")
                    } else {
                        print("Application successfully uploaded!")
                    }
                }
            } catch {
                print("Failed to encode application: \(error.localizedDescription)")
            }
        }
        
        
        
         func uploadApplications(_ applications: [application]) {
            let db = Firestore.firestore()
            let collectionRef = db.collection("Applications") // Collection for storing applications
            
            for application in applications {
                do {
                    let documentRef = try collectionRef.addDocument(from: application)
                    documentRef.setData(try Firestore.Encoder().encode(application)) { error in
                        if let error = error {
                            print("Failed to upload application: \(error.localizedDescription)")
                        } else {
                            print("Application successfully uploaded!")
                        }
                    }
                } catch {
                    print("Failed to encode application: \(error.localizedDescription)")
                }
            }
        }
        
        
         func fetchAllApplications() async throws -> [application] {
            let db = Firestore.firestore()
            let collectionRef = db.collection("Applications")
            
            do {
                let snapshot = try await collectionRef.getDocuments()
                let fetchedApplications = try snapshot.documents.map { document in
                    try document.data(as: application.self)
                }
                print("Successfully fetched \(fetchedApplications.count) applications.")
                return fetchedApplications
            } catch {
                print("Failed to fetch applications: \(error.localizedDescription)")
                throw error
            }
        }
        
         func fetchApplicationsForJobSeeker(jobSeekerID: String) async throws -> [application] {
            let db = Firestore.firestore()
            let collectionRef = db.collection("Applications")
            
            do {
                let snapshot = try await collectionRef.whereField("jobSeeker.userID", isEqualTo: jobSeekerID).getDocuments()
                let fetchedApplications = try snapshot.documents.map { document in
                    try document.data(as: application.self)
                }
                print("Successfully fetched \(fetchedApplications.count) applications for job seeker \(jobSeekerID).")
                return fetchedApplications
            } catch {
                print("Failed to fetch applications for job seeker \(jobSeekerID): \(error.localizedDescription)")
                throw error
            }
        }
        
         func fetchApplicationsForJob(jobTitle: String) async throws -> [application] {
            let db = Firestore.firestore()
            let collectionRef = db.collection("Applications")
            
            do {
                let snapshot = try await collectionRef.whereField("jobTitle", isEqualTo: jobTitle).getDocuments()
                let fetchedApplications = try snapshot.documents.map { document in
                    try document.data(as: application.self)
                }
                print("Successfully fetched \(fetchedApplications.count) applications for job \(jobTitle).")
                return fetchedApplications
            } catch {
                print("Failed to fetch applications for job \(jobTitle): \(error.localizedDescription)")
                throw error
            }
        }
        
         func fetchApplicationByNumber(applicationNo: Int) async throws -> application? {
            let db = Firestore.firestore()
            let collectionRef = db.collection("Applications")
            
            do {
                let snapshot = try await collectionRef.whereField("applicationNo", isEqualTo: applicationNo).getDocuments()
                guard let document = snapshot.documents.first else {
                    print("No application found with applicationNo \(applicationNo).")
                    return nil
                }
                let fetchedApplication = try document.data(as: application.self)
                print("Successfully fetched application with applicationNo \(applicationNo).")
                return fetchedApplication
            } catch {
                print("Failed to fetch application with applicationNo \(applicationNo): \(error.localizedDescription)")
                throw error
            }
        }
        
        func uploadAllJobs(_ jobs: [job]) async throws {
            let db = Firestore.firestore()
            let collectionRef = db.collection("MuntadherJobs")

            for job in jobs {
                do {
                    let documentRef = try collectionRef.addDocument(from: job)
                    try await documentRef.setData(Firestore.Encoder().encode(job))
                    print("Job uploaded successfully: \(job.jobTitle)")
                } catch {
                    print("Failed to upload job \(job.jobTitle): \(error.localizedDescription)")
                    throw error
                }
            }
        }
        
        func fetchAllJobs() async throws -> [job] {
            let db = Firestore.firestore()
            let collectionRef = db.collection("MuntadherJobs")

            do {
                let snapshot = try await collectionRef.getDocuments()
                let jobs = try snapshot.documents.map { document in
                    try document.data(as: job.self)
                }
                print("Successfully fetched \(jobs.count) jobs.")
                return jobs
            } catch {
                print("Failed to fetch jobs: \(error.localizedDescription)")
                throw error
            }
        }
        
        func uploadAllJobCompatibilities(_ jobCompatibilities: [JobCompatibility]) async throws {
            let db = Firestore.firestore()
            let collectionRef = db.collection("job_compatibilities")

            for jobCompatibility in jobCompatibilities {
                do {
                    try collectionRef.addDocument(from: jobCompatibility) 
                    print("Uploaded Job Compatibility for job: \(jobCompatibility.jobTitle)")
                } catch {
                    print("Failed to upload Job Compatibility for job: \(jobCompatibility.jobTitle), Error: \(error.localizedDescription)")
                    throw error
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        static func getProfile(userID: String, completion: @escaping (Profile?, Error?) -> Void) {
            let db = Firestore.firestore()
            let userRef = db.collection("Users").document(userID)
            let profileRef = db.collection("Profiles").document(userID)
            let jobSeekerRef = db.collection("JobSeekers").document(userID)
            let companyRef = db.collection("Companies").document(userID)
            // Fetch user document to determine the userType
            
            userRef.getDocument { (userDocument, error) in
                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let userDocument = userDocument, userDocument.exists else {
                    print("Document does not exist.")
                    completion(nil, nil)
                    return
                }
                
                guard let userData = userDocument.data(), let userType = userData["userType"] as? String else {
                    print("User document missing or missing userType field.")
                    completion(nil, nil)
                    return
                }
                
                profileRef.getDocument { (profileDocument, error) in
                    if let error = error {
                        print("Error fetching profile document: \(error.localizedDescription)")
                        completion(nil, error)
                        return
                    }
                    
                    guard let profileData = profileDocument?.data() else {
                        print("Profile document EEEE not found.")
                        completion(nil, nil)
                        return
                    }
                    
                    // Fetch JobSeeker or Company document based on userType
                    if userType == "jobSeeker" {
                        jobSeekerRef.getDocument { (jobSeekerDocument, error) in
                            if let error = error {
                                print("Error fetching job seeker document: \(error.localizedDescription)")
                                completion(nil, error)
                                return
                            }
                            
                            guard let jobSeekerData = jobSeekerDocument?.data() else {
                                print("JobSeeker document not found.")
                                completion(nil, nil)
                                return
                            }
                            
                            // Combine profile and job seeker data into a `JobSeeker` object
                            let jobSeekerProfile = JobSeeker(
                                userID:"",
                                personalSummary: jobSeekerData["personalSummary"] as? String ?? "",
                                educations: nil, // Map `educations` if available
                                experiences: nil, // Map `experiences` if available
                                skills: nil, // Map `skills` if available
                                preferences: nil, // Map `preferences` if available
                                cv: "",
                                suggestedCareerPaths: nil,
                                applications: nil,
                                firstName: userData["firstName"] as? String ?? "",
                                lastName: userData["lastName"] as? String ?? "",
                                email: userData["email"] as? String ?? "",
                                password: "hidden", // Password should not be exposed
                                type: .jobSeeker,
                                profileImage: profileData["profileImage"] as? String ?? "",
                                phoneNumber: profileData["phoneNumber"] as? String ?? "",
                                location: profileData["location"] as? String ?? ""
                            )
                            
                            completion(jobSeekerProfile, nil)
                        }
                    } else if userType == "employer" {
                        companyRef.getDocument { (companyDocument, error) in
                            if let error = error {
                                print("Error fetching company document: \(error.localizedDescription)")
                                completion(nil, error)
                                return
                            }
                            
                            guard let companyData = companyDocument?.data() else {
                                print("Company document not found.")
                                completion(nil, nil)
                                return
                            }
                            
                            // Combine profile and company data into a `Company` object
                            let companyProfile = Company(
                                userID: "", companyName: companyData["companyName"] as? String ?? "",
                                industry: companyData["industry"] as? String ?? "",
                                website: companyData["website"] as? String ?? "",
                                aboutUs: companyData["aboutUs"] as? String ?? "",
                                firstName: profileData["firstName"] as? String ?? "",
                                lastName: profileData["lastName"] as? String ?? "",
                                email: profileData["email"] as? String ?? "",
                                password: "hidden", // Password should not be exposed
                                type: .employer,
                                profileImage: profileData["profileImage"] as? String ?? "",
                                phoneNumber: profileData["phoneNumber"] as? String ?? "",
                                location: profileData["location"] as? String ?? ""
                            )
                            
                            completion(companyProfile, nil)
                        }
                    } else {
                        print("User type is admin or undefined.")
                        completion(nil, nil)
                    }
                }
            }
        }
        
//        static func fetchAllUsers(completion: @escaping ([AppUser], Error?) -> Void) {
//            let db = Firestore.firestore()
//            let usersRef = db.collection("Users")
//            
//            usersRef.getDocuments { (querySnapshot, err) in
//                if let err = err {
//                    print("Error fetching users: \(err)")
//                    completion([], err)
//                    return
//                }
//                
//                guard let documents = querySnapshot?.documents else {
//                    completion([], nil)
//                    return
//                }
//                
//                // Map Firestore documents to User objects
//                // Map Firestore documents to User objects
//                let users: [AppUser] = documents.compactMap { document in
//                    let data = document.data()
//                    
//                    // Ensure required fields exist
//                    guard let uid = data["uid"] as? String,
//                          let firstName = data["firstName"] as? String,
//                          let lastName = data["lastName"] as? String,
//                          let userTypeRaw = data["userType"] as? String,
//                          let userType = UserType(rawValue: userTypeRaw) else {
//                        print("Invalid or missing user data in document: \(document.documentID)")
//                        return
//                    }
//                    
//                    // Create and return a User object
//                    return AppUser(
//                        uid: uid,
//                        firstName: firstName,
//                        lastName: lastName,
//                        email: "",
//                        password: "", // Password not stored here
//                        type: userType
//                    )
//                }
//                
//                
//                
//                // Pass the users array to the completion handler
//                completion(users, nil)
//            }
//            
//            
//        }
        static func fetchUserData(completion: @escaping (Profile?, Error?) -> Void) {
            
            guard let currentUser = Auth.auth().currentUser else {
                print("No authenticated user.")
                completion(nil,nil)
                return
            }
            print("current user: \(String(describing: currentUser.email)) uid:\(currentUser.uid)")
            
            let db = Firestore.firestore()
            let userRef = db.collection("Users").document(currentUser.uid)
            let profileRef = db.collection("Profiles").document(currentUser.uid)
            let jobSeekerRef = db.collection("JobSeekers").document(currentUser.uid)
            let companyRef = db.collection("Companies").document(currentUser.uid)
            // Fetch user document to determine the userType
            
            userRef.getDocument { (userDocument, error) in
                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    completion(nil, error)
                    return
                }
                
                guard let userDocument = userDocument, userDocument.exists else {
                    print("Document does not exist.")
                    completion(nil, nil)
                    return
                }
                
                guard let userData = userDocument.data(), let userType = userData["userType"] as? String else {
                    print("User document missing or missing userType field.")
                    completion(nil, nil)
                    return
                }
                
                profileRef.getDocument { (profileDocument, error) in
                    if let error = error {
                        print("Error fetching profile document: \(error.localizedDescription)")
                        completion(nil, error)
                        return
                    }
                    
                    guard let profileData = profileDocument?.data() else {
                        print("Profile document not found.")
                        completion(nil, nil)
                        return
                    }
                    
                    // Fetch JobSeeker or Company document based on userType
                    if userType == "jobSeeker" {
                        jobSeekerRef.getDocument { (jobSeekerDocument, error) in
                            if let error = error {
                                print("Error fetching job seeker document: \(error.localizedDescription)")
                                completion(nil, error)
                                return
                            }
                            
                            guard let jobSeekerData = jobSeekerDocument?.data() else {
                                print("JobSeeker document not found.")
                                completion(nil, nil)
                                return
                            }
                            
                            // Combine profile and job seeker data into a `JobSeeker` object
                            let jobSeekerProfile = JobSeeker(
                                userID: "",
                                personalSummary: jobSeekerData["personalSummary"] as? String ?? "",
                                educations: nil, // Map `educations` if available
                                experiences: nil, // Map `experiences` if available
                                skills: nil, // Map `skills` if available
                                preferences: nil, // Map `preferences` if available
                                cv: jobSeekerData["cv"] as? String ?? "",
                                suggestedCareerPaths: nil,
                                applications: nil,
                                firstName: profileData["firstName"] as? String ?? "",
                                lastName: profileData["lastName"] as? String ?? "",
                                email: profileData["email"] as? String ?? "",
                                password: "hidden", // Password should not be exposed
                                type: .jobSeeker,
                                profileImage: profileData["profileImage"] as? String ?? "",
                                phoneNumber: profileData["phoneNumber"] as? String ?? "",
                                location: profileData["location"] as? String ?? ""
                            )
                            
                            completion(jobSeekerProfile, nil)
                        }
                    } else if userType == "employer" {
                        companyRef.getDocument { (companyDocument, error) in
                            if let error = error {
                                print("Error fetching company document: \(error.localizedDescription)")
                                completion(nil, error)
                                return
                            }
                            
                            guard let companyData = companyDocument?.data() else {
                                print("Company document not found.")
                                completion(nil, nil)
                                return
                            }
                            
                            // Combine profile and company data into a `Company` object
                            let companyProfile = Company(
                                userID: "String", companyName: companyData["companyName"] as? String ?? "",
                                industry: companyData["industry"] as? String ?? "",
                                website: companyData["website"] as? String ?? "",
                                aboutUs: companyData["aboutUs"] as? String ?? "",
                                firstName: profileData["firstName"] as? String ?? "",
                                lastName: profileData["lastName"] as? String ?? "",
                                email: profileData["email"] as? String ?? "",
                                password: "hidden", // Password should not be exposed
                                type: .employer,
                                profileImage: profileData["profileImage"] as? String ?? "",
                                phoneNumber: profileData["phoneNumber"] as? String ?? "",
                                location: profileData["location"] as? String ?? ""
                            )
                            
                            completion(companyProfile, nil)
                        }
                    } else {
                        print("User type is admin or undefined.")
                        completion(nil, nil)
                    }
                }
            }
            
        }
        static func loadDataFromFireBase(completion: @escaping (Error?) -> Void) {
            guard Auth.auth().currentUser != nil else {
                print("No authenticated user.")
                completion(nil)
                return
            }
            
            
            
            let db = Firestore.firestore()
            let jobsRef = db.collection("Jobs")
            
            //
            
            jobsRef.getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error.localizedDescription)")
                    completion(error)
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    completion(nil)
                    return
                }
                
                Utilities.DataManager.shared.Jobs = documents.compactMap { document -> job? in
                    let data = document.data()
                    
                    // Map Firestore document fields to job properties
                    guard
                        let jobTitle = data["jobTitle"] as? String,
                        let jobDescription = data["jobDescription"] as? String,
                        let jobSalary = data["jobSalary"] as? String,
                        let jobTypeRaw = data["jobType"] as? String,
                        let jobType = jobTypes(rawValue: jobTypeRaw),
                        let jobId = data["jobId"] as? String,
                        let jobCategoryRaw = data["jobCategory"] as? String,
                        let jobCategory = jobCategories(rawValue: jobCategoryRaw),
                        let jobPositionRaw = data["jobPosition"] as? String,
                        let jobPosition = jobPositions(rawValue: jobPositionRaw),
                        let jobImage = data["jobImage"] as? String,
                        let jobSkills = data["jobSkills"] as? [String],
                        let jobPostedDate = data["jobPostedDate"] as? String,
                        let salaryTypeRaw = data["SalaryType"] as? String,
                        let salaryType = SalaryType(rawValue: salaryTypeRaw),
                        let timeFromPost = data["timeFromPost"] as? String,
                        let deadline = data["deadline"] as? String,
                        let offer = data["offer"] as? String
                    else {
                        print("Missing or invalid data for job with ID: \(document.documentID)")
                        return nil
                    }
                    
                    // Return a new `job` instance
                    return job(
                        jobTitle: jobTitle, company: polyCompany,
                        companyID: "", // Replace with actual company data if available
                        jobDescription: jobDescription,
                        jobSalary: jobSalary,
                        jobType: jobType,
                        jobId: jobId,
                        jobCategory: jobCategory,
                        jobPosition: jobPosition,
                        jobImage: jobImage,
                        jobSkills: jobSkills,
                        jobPostedDate: jobPostedDate,
                        salaryType: salaryType,
                        timeFromPost: timeFromPost,
                        deadline: deadline,
                        applications: nil, // Add logic for applications if needed
                        offer: offer
                    )
                }
                
                print("Loaded \(Utilities.DataManager.shared.Jobs.count) jobs.")
                completion(nil)
            }
        }
    }
    
}

// logout code

//do {
//        try Auth.auth().signOut()
//    GIDSignIn.sharedInstance.signOut()
//        // Optionally, transition the user to a login screen or perform other actions.
//        print("User signed out successfully")
//    } catch let signOutError as NSError {
//        print("Error signing out: \(signOutError.localizedDescription)")
//    }

