//
//  LoggedInViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 25/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoggedInViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userIDlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        emailLabel.text = Auth.auth().currentUser?.email
        userIDlabel.text = Auth.auth().currentUser?.uid
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
