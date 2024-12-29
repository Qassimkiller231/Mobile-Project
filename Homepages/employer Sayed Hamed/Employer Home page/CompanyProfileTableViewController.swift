//
//  CompanyProfileTableViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 26/12/2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class CompanyProfileTableViewController: UITableViewController {
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var industryTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var aboutUsTextField: UITextView!
    
    var companyProfile: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser?.uid
        fetchCompany(userID: userID ?? "")
        
        // Populate the UI elements
       
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func fetchCompany(userID: String) {
        fetchData(userID: userID, collectionName: "companies") { (result: Result<Company, Error>) in
            switch result {
            case .success(let company):
                print("Fetched Company successfully!")
                print("Company Name: \(company.companyName)")
                print("Industry: \(company.industry)")
                print("Website: \(company.website)")
                print("About Us: \(company.aboutUs)")
                print("Email: \(company.email)")
                print("Phone Number: \(company.phoneNumber)")
                print("Location: \(company.location)")
                self.companyNameTextField.text = company.companyName
                self.industryTextField.text = company.industry
                self.websiteTextField.text = company.website
                self.locationTextField.text = company.location
                self.aboutUsTextField.text = company.aboutUs
                // Do something with the fetched Company object
            case .failure(let error):
                print("Error fetching Company: \(error.localizedDescription)")
            }
        }
    }
    func fetchData<T: Codable>(userID: String, collectionName: String, completion: @escaping (Result<T, Error>) -> Void) {
        let db = Firestore.firestore()
        
        // Fetch the document with the specified userID from the collection
        db.collection(collectionName).document(userID).getDocument { documentSnapshot, error in
            if let error = error {
                // Return an error if the fetch fails
                completion(.failure(error))
                return
            }
            
            // Check if the document exists
            guard let document = documentSnapshot, document.exists else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found."])))
                return
            }
            
            
            
        }
    }
}

