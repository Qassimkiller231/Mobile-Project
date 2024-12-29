//
//  CompanyProfileViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 25/12/2024.
//

import UIKit
import Firebase

class CompanyProfileViewController: UIViewController{

    @IBOutlet weak var container: UIView!
    var companyProfileTableVC: CompanyProfileTableViewController?
    var companyProfile: Company?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for child in children {
                if let tableVC = child as? CompanyProfileTableViewController {
                    companyProfileTableVC = tableVC
                }
            }
    }
    func validateCompanyProfileData() -> Bool {
        guard let tableVC = companyProfileTableVC else { return false }
        
        // Example validation rules
        guard let companyName = tableVC.companyNameTextField.text, !companyName.isEmpty else {
            showAlert(message: "Company name cannot be empty")
            return false
        }
        
        guard let website = tableVC.websiteTextField.text, !website.isEmpty else {
            showAlert(message: "Website field cannot be empty")
            return false
        }
        
        guard let email = tableVC.industryTextField.text, !email.isEmpty else {
            showAlert(message: "Industry field cannot be empty")
            return false
        }

        // Add additional validations as needed

        return true
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

    func showSaveAlert(message: String) {
        let alert = UIAlertController(title: "Updated", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigateToHomeTab()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToHomeTab() {
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 0 // Replace `0` with the index of the home tab
        }
    }

    
    
    @IBAction func saveButton(_ sender: Any) {
//        guard validateCompanyProfileData() else { return }
        
        // Update the company profile
        if let tableVC = companyProfileTableVC{
            print("loading company")
            self.companyProfile?.companyName = tableVC.companyNameTextField.text ?? ""
            self.companyProfile?.industry = tableVC.industryTextField.text ?? ""
            self.companyProfile?.website = tableVC.websiteTextField.text ?? ""
            self.companyProfile?.location = tableVC.locationTextField.text ?? ""
            self.companyProfile?.aboutUs = tableVC.aboutUsTextField.text ?? ""
            
            // Add logic to save or update the profile, such as calling an API or saving to local storage
            if let companyProfile = companyProfile {
                print("trying to upload company")
                uploadCompanyToFirestore(company: companyProfile)
                showSaveAlert(message: "Saved Successfully") }
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
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension String {
    func isValidURL() -> Bool {
        guard let url = URL(string: self) else { return false }
        return UIApplication.shared.canOpenURL(url)
    }
}
