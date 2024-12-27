//
//  LoginViewController.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 11/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var googleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        email.layer.cornerRadius = 25
        password.layer.cornerRadius = 25
        errorLabel.alpha = 0
        
        
    }
    
    func login(){
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    func loginWithGoogle() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard let signInResult = signInResult else {
                if let error = error {
                    self.showError("Google Sign-In Error: \(error.localizedDescription)")
                }
                return
            }

            let user = signInResult.user
            guard let idToken = user.idToken?.tokenString else { return }
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            

            // Attempt Firebase authentication with Google credentials
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.showError("Firebase Sign-In Error: \(error.localizedDescription)")
                    return
                }

                guard let currentUser = authResult?.user else { return }
                let email = currentUser.email ?? ""
                let uid = currentUser.uid

                // Check if the user document exists in Firestore
                let db = Firestore.firestore()
                let userDocRef = db.collection("Users").document(uid)

                userDocRef.getDocument { document, error in
                    if let error = error {
                        self.showError("Error checking user in Firestore: \(error.localizedDescription)")
                        return
                    }

                    if let document = document, document.exists {
                        // Document exists; user already in Firestore
                        print("User already exists in Firestore")
                        self.performSegue(withIdentifier: "goToMain", sender: self)
                    } else {
                        // User doesn't exist; prompt for user details
                        self.promptForUserDetails { firstName, lastName, userType in
                            self.addFirestoreDocumentForUser(email: email, user: currentUser, firstName: firstName, lastName: lastName, userType: userType)
                        }
                    }
                }
            }
        }
    }
    func promptForUserDetails(completion: @escaping (String, String, String) -> Void) {
        let userDetailsVC = UserDetailsPromptViewController()
        userDetailsVC.completion = completion
        userDetailsVC.modalPresentationStyle = .formSheet
        present(userDetailsVC, animated: true, completion: nil)
    }

    func addFirestoreDocumentForUser(email: String, user: User, firstName: String, lastName: String, userType: String) {
        let db = Firestore.firestore()
        db.collection("Users").document(user.uid).setData([
            "firstName": firstName,
            "lastName": lastName,
            "userType": userType,
            "uid": user.uid
        ]) { error in
            if let error = error {
                self.showError("Error adding Firestore document: \(error.localizedDescription)")
            } else {
                print("Firestore document added successfully.")
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        login()
    }
    @IBAction func googleLoginButtonPressed(_ sender: Any) {
        loginWithGoogle()
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
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

extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ["Job Seeker", "Employer"].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ["Job Seeker", "Employer"][row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let textField = pickerView.superview?.viewWithTag(100) as? UITextField {
            textField.text = ["Job Seeker", "Employer"][row]
        }
    }
}
