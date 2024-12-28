//
//  ViewController.swift
//  testfinalfinal
//
//  Created by Guest User on 08/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import FirebaseFirestore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        uploadAppUserToFirestore(appUser: SQuser)
//        print(SQProfile.userID)
//        uploadProfileToFirestore(profile: SQProfile)
//        uploadCompanyToFirestore(company: polyCompany)
//        uploadJobSeekerToFirestore(jobSeeker: SayedHamed)
//        uploadJobToFirestore(job: testJob)
        
        // Do any additional setup after loading the view.

    }
    func uploadJobToFirestore(job: job) {
        let db = Firestore.firestore()
        
        do {
            let encodedData = try Firestore.Encoder().encode(job)
            db.collection("jobs").document(job.jobId).setData(encodedData) { error in
                if let error = error {
                    print("Error uploading job: \(error)")
                } else {
                    print("Job successfully uploaded!")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }
    func uploadJobSeekerToFirestore(jobSeeker: JobSeeker) {
        let db = Firestore.firestore()
        
        do {
            // Encode the JobSeeker object into a dictionary
            let encodedData = try Firestore.Encoder().encode(jobSeeker)

            // Use the userID as the document ID
            db.collection("jobSeekers").document(jobSeeker.userID).setData(encodedData) { error in
                if let error = error {
                    print("Error uploading job seeker: \(error)")
                } else {
                    print("Job seeker successfully uploaded!")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }
    func uploadCompanyToFirestore(company: Company) {
        let db = Firestore.firestore()
        
        do {
            // Encode the Company object into a dictionary
            let encodedData = try Firestore.Encoder().encode(company)

            // Use the userID as the document ID
            db.collection("companies").document(company.userID).setData(encodedData) { error in
                if let error = error {
                    print("Error uploading company: \(error)")
                } else {
                    print("Company successfully uploaded!")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }
    
    func uploadProfileToFirestore(profile: Profile) {
        let db = Firestore.firestore()

        // Ensure userID is not empty
        guard !profile.userID.isEmpty else {
            print("Error: userID is empty.")
            return
        }

        do {
            // Encode the Profile object into a dictionary
            let encodedData = try Firestore.Encoder().encode(profile)

            // Use the userID as the document ID
            db.collection("Profiles").document(profile.userID).setData(encodedData) { error in
                if let error = error {
                    print("Error uploading profile: \(error)")
                } else {
                    print("Profile successfully uploaded!")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkUserTypeAndNavigate()
    }
    
    func checkUserTypeAndNavigate() {
            // Ensure the user is logged in
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                print("User not logged in. Navigating to Login.")
                goToLogin()
                return
            }

            // Reference to Firestore
            let db = Firestore.firestore()

            // Fetch the user document from Firestore
            let userRef = db.collection("Users").document(currentUserID)
            userRef.getDocument { document, error in
                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    self.goToLogin()
                    return
                }

                guard let document = document, document.exists else {
                    print("User document does not exist.")
                    self.goToLogin()
                    return
                }

                // Get the userType field
                if let userType = document.data()?["userType"] as? String {
                    print("User type: \(userType)")
                    self.navigateBasedOnUserType(userType)
                } else {
                    print("User type not found in document.")
                    self.goToLogin()
                }
            }
        }

        func navigateBasedOnUserType(_ userType: String) {
            // Decide navigation based on userType
            switch userType {
            case "admin":
                goToAdminDashboard()
            case "jobSeeker":
                goToJobSeekerDashboard()
            case "employer":
                goToEmployerDashboard()
            default:
                print("Unknown userType. Navigating to Login.")
                goToLogin()
            }
        }
    
    func goToAdminDashboard() {
        performSegue(withIdentifier: "goToAdminHomepage", sender: self)
    }
    
    func goToJobSeekerDashboard() {
        performSegue(withIdentifier: "goToJobSeekerHomepage", sender: self)
    }
    func goToLogin() {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    func goToEmployerDashboard() {
        performSegue(withIdentifier: "toEmployer", sender: self)
    }

    @IBAction func LogOutButtonPressed(_ sender: Any) {
        do {
                try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
                // Optionally, transition the user to a login screen or perform other actions.
                print("User signed out successfully")
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError.localizedDescription)")
            }
        goToLogin()
    }

    @IBAction func showOverlayButton(_ sender: Any) {
        // Instantiate ProfileOverlayViewController
        let overlayVC = ProfileOverlayViewController(nibName: "ProfileOverlayViewController", bundle: nil)
        
        // Set the presentation style for an overlay effect
        overlayVC.modalPresentationStyle = .overCurrentContext
        overlayVC.modalTransitionStyle = .crossDissolve // Smooth fade-in effect
        
        // Present the overlay
        self.present(overlayVC, animated: true, completion: nil)
    }
    
    func uploadAppUserToFirestore(appUser: AppUser) {
        let db = Firestore.firestore()
        
        do {
            // Encode the AppUser object into a dictionary
            let encodedData = try Firestore.Encoder().encode(appUser)
            
            // Add the data to Firestore
            db.collection("users").document("\(appUser.userID)").setData(encodedData) { error in
                if let error = error {
                    print("Error uploading user: \(error)")
                } else {
                    print("User \(appUser.userID) successfully uploaded!")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }
    
    
    
    
}

