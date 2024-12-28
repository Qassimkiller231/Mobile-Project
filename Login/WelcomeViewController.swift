//
//  WelcomeViewController.swift
//  Project
//
//  Created by Hamed on 27/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth

class WelcomeViewController: UIViewController {
    
    let currentUser = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded WelcomeViewController")
        print("currentUser:\(currentUser?.email ?? "")")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUserTypeAndNavigate()
    }
    
    func checkUserTypeAndNavigate() {
            // Ensure the user is logged in
            guard let currentUserID = Auth.auth().currentUser?.uid else {
                print("User not logged in. Navigating to Login.")
                return
            }

            // Reference to Firestore
            let db = Firestore.firestore()

            // Fetch the user document from Firestore
            let userRef = db.collection("Users").document(currentUserID)
            userRef.getDocument { document, error in
                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    return
                }

                guard let document = document, document.exists else {
                    print("User document does not exist.")
                    return
                }

                // Get the userType field
                if let userType = document.data()?["userType"] as? String {
                    print("User type: \(userType)")
                    self.navigateBasedOnUserType(userType)
                } else {
                    print("User type not found in document.")
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
                print("Unknown userType. staying in login")
            }
        }
    
    func goToAdminDashboard() {
        performSegue(withIdentifier: "goToAdminHomepage", sender: self)
    }
    
    func goToJobSeekerDashboard() {
        performSegue(withIdentifier: "goToJobSeekerHomepage", sender: self)
    }
    func goToEmployerDashboard() {
        performSegue(withIdentifier: "toEmployer", sender: self)
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
