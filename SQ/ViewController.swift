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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

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
    
    
}

