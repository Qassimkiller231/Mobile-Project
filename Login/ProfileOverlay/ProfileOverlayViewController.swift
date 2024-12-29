//
//  ProfileOverlayViewController.swift
//  Project
//
//  Created by Hamed on 27/12/2024.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class ProfileOverlayViewController: UIViewController {
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var cvBuilderButton: UIButton!
    @IBOutlet weak var profileEditorButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkUserTypeAndChange()
    }
    var dismissCompletion: (() -> Void)?
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissCompletion?()
    }
//        override func viewDidDisappear(_ animated: Bool) {
//            super.viewDidDisappear(animated)
//            // Call the completion handler when the overlay is dismissed
//            
//        }
//        
    @IBAction func tappedOutOfView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkUserTypeAndChange() {
        let db = Firestore.firestore()
        let userID = Auth.auth().currentUser?.uid
        
        if let userID {
            let userRef = db.collection("Users").document(userID)
            // Fetch user document to determine the userType
            
            userRef.getDocument { (userDocument, error) in
                if let error = error {
                    print("Error fetching user document: \(error.localizedDescription)")
                    return
                }
                
                guard let userDocument = userDocument, userDocument.exists else {
                    print("Document does not exist.")
                    return
                }
                
                guard let userData = userDocument.data(), let userType = userData["userType"] as? String else {
                    print("User document missing or missing userType field.")
                    return
                }
                switch userType {
                case "admin":
                    print("admin user")
                    self.cvBuilderButton.isHidden = true
                    self.profileEditorButton.isHidden = true
                case "employer":
                    print("employer user")
                    self.cvBuilderButton.isHidden = true
                    self.profileEditorButton.isHidden = true
                case "jobSeeker":
                    print("jobseeker user")
                    self.cvBuilderButton.isHidden = false
                    self.profileEditorButton.isHidden = false
                default:
                    print("user not logged in")
                    self.cvBuilderButton.isHidden = true
                    self.profileEditorButton.isHidden = true
                }
                
            }
        }
    }
    
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        
        
        print("Edit Profile button tapped")
            
            let storyboard = UIStoryboard(name: "ProfileBuilder", bundle: nil)
            if let editProfileVC = storyboard.instantiateViewController(withIdentifier: "PBPersonalViewController") as? PBPersonalViewController {
                print("PBPersonalViewController instantiated successfully")
                
                self.dismiss(animated: true) {
                    print("Overlay dismissed successfully")
                    
                    if let visibleVC = self.getVisibleViewController(self.getRootViewController()) {
                        visibleVC.present(editProfileVC, animated: true) {
                            print("PBPersonalViewController presented successfully")
                        }
                    } else {
                        print("Error: Could not find visible view controller.")
                    }
                }
            } else {
                print("Error: Could not instantiate PBPersonalViewController.")
            }
    }
    @IBAction func CVBuilderButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CVBuilder", bundle: nil) // Replace "Main" with your storyboard name
        let cvBuilderVC = storyboard.instantiateViewController(withIdentifier: "CVFinalViewController")
            self.presentingViewController?.present(cvBuilderVC, animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil) // Close the overlay
    }
    @IBAction func logOutButtonTapped(_ sender: Any) {
        do {
                try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
                // Optionally, transition the user to a login screen or perform other actions.
                print("User signed out successfully")
            } catch let signOutError as NSError {
                print("Error signing out: \(signOutError.localizedDescription)")
            }
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController")
        self.presentingViewController?.present(loginVC, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController {
            return getVisibleViewController(navigationController.visibleViewController)
        }
        if let tabBarController = rootViewController as? UITabBarController {
            return getVisibleViewController(tabBarController.selectedViewController)
        }
        if let presentedViewController = rootViewController?.presentedViewController {
            return getVisibleViewController(presentedViewController)
        }
        return rootViewController
    }
    
    func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        return window.rootViewController
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
