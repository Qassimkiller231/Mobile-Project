//
//  SignUpViewController.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 11/12/2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift


class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var jobSeekerButton: UIButton!
    @IBOutlet weak var employerButton: UIButton!
    private var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        firstNameTextField.layer.cornerRadius = 25
        lastNameTextField.layer.cornerRadius = 25
        emailTextField.layer.cornerRadius = 25
        passwordTextField.layer.cornerRadius = 25
        
        firstNameTextField.clipsToBounds = true
        lastNameTextField.clipsToBounds = true
        emailTextField.clipsToBounds = true
        passwordTextField.clipsToBounds = true
        
        errorLabel.alpha = 0
        setSelectedButton(jobSeekerButton)
    }
    
    func validateFields() -> String? {
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please ensure password is at least 8 characters, contains a special character and a number"
        }
        
        
        return nil
    }
    
    
    @IBAction func employerButtonTapped(_ sender: Any) {
        setSelectedButton(employerButton)
    }
    
    @IBAction func jobSeekerButtonTapped(_ sender: Any) {
        setSelectedButton(jobSeekerButton)
    }
    
    private func setSelectedButton(_ button: UIButton) {
        if selectedButton == button {
            return
        }
        
        if let currentSelected = selectedButton {
            deselectButton(currentSelected)
        }
        
        selectButton(button)
        selectedButton = button
    }
    
    
    private func deselectButton(_ button: UIButton) {
        button.configuration?.background.strokeWidth = 0
    }
    
    private func selectButton(_ button: UIButton) {
        button.configuration?.background.strokeWidth = 5
    }
    
    private func getSelection() -> String? {
        if selectedButton == employerButton {
            return "employer"
        } else if selectedButton == jobSeekerButton {
            return "jobSeeker"
        } else {
            return nil
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard selectedButton != nil else {
            let error = "Please select a role"
            showError(error)
            return
        }
        
        //validate fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            
            //create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if let err = err as NSError? {
                    if err.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                        self.showError("You already have an account")
                    } else {
                        self.showError("Error creating user")
                    }
                } else {
                    
                    // user created successfully, now store name
                    let db = Firestore.firestore()
                    
                    let userType = self.getSelection()
                    
                    if let uid = result?.user.uid {
                        db.collection("Users").document(uid).setData([
                            "firstName": firstName,
                            "lastName": lastName,
                            "userType": userType ?? "",
                            "uid": uid
                        ]) { error in
                            if let error = error {
                                self.showError("Error saving user data: \(error.localizedDescription)")
                            } else {
                                print("User data successfully saved!")
                            }
                        }
                    } else {
                        self.showError("User UID is missing")
                    }

                    
                    self.navigateBasedOnUserType(userType ?? "")
                }
            }
            
            
        }
        
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        self.performSegue(withIdentifier: "SignedUp", sender: nil)
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
