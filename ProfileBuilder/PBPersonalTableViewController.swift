//
//  PBPersonalTableViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit
import Foundation
import FirebaseAuth
import Firebase


class PBPersonalTableViewController: UITableViewController {

    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var personalSummaryTextView: UITextView!
    
    var jobSeeker: JobSeeker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let userID = Auth.auth().currentUser?.uid else {
                print("No user ID available")
                return
            }
            
            fetchData(userID: userID, collectionName: "jobSeekers") { (result: Result<JobSeeker, Error>) in
                switch result {
                case .success(let jobSeeker):
                    self.jobSeeker = jobSeeker
                    print("Fetched JobSeeker: \(jobSeeker.email), Phone Num: \(jobSeeker.phoneNumber)")
                    
                    // Perform actions with the fetched jobSeeker here
                    if let currentJobSeeker = self.jobSeeker {
                        self.loadData(profile: currentJobSeeker)
                    }
                    
                case .failure(let error):
                    print("Error fetching JobSeeker: \(error.localizedDescription)")
                    
                    // Handle the case where the profile is nil
                    if self.jobSeeker == nil {
                        let userType = UserType.jobSeeker // Replace with your actual user type logic
                        self.jobSeeker = JobSeeker(
                            userID: userID,
                            personalSummary: "",
                            educations: [], // Placeholder
                            experiences: [], // Placeholder
                            skills: [], // Placeholder
                            preferences: [], // Placeholder
                            cv: "", // Placeholder
                            suggestedCareerPaths: [], // Placeholder
                            applications: nil,
                            firstName: "",
                            lastName: "",
                            email: "",
                            password: "", // Secure password handling needed
                            type: userType,
                            profileImage: "", // Handle profile image appropriately
                            phoneNumber: "",
                            location: ""
                        )
                        print("Created a new JobSeeker object: \(self.jobSeeker?.userID ?? "No ID")")
                    }
                }
            }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func loadData(profile: JobSeeker) {
        firstNameTextField.text = profile.firstName
        lastNameTextField.text = profile.lastName
        emailTextField.text = profile.email
        phoneNumberTextField.text = profile.phoneNumber
        locationTextField.text = profile.location
        personalSummaryTextView.text = profile.personalSummary
    }
    func validateInputs() -> Bool {
            guard let firstName = firstNameTextField.text, !firstName.isEmpty,
                  let lastName = lastNameTextField.text, !lastName.isEmpty,
                  let email = emailTextField.text, isValidEmail(email),
                  let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty,
                  let location = locationTextField.text, !location.isEmpty,
                  let personalSummary = personalSummaryTextView.text, !personalSummary.isEmpty else {
                return false
            }
//         Create JobSeeker instance
        if jobSeeker == nil {
                let userType = UserType.jobSeeker // Replace with your actual user type logic
            let userID = Auth.auth().currentUser!.uid
            self.jobSeeker = JobSeeker(
                    userID: userID,
                    personalSummary: "",
                    educations: [], // Placeholder
                    experiences: [], // Placeholder
                    skills: [], // Placeholder
                    preferences: [], // Placeholder
                    cv: "", // Placeholder
                    suggestedCareerPaths: [], // Placeholder
                    applications: nil,
                    firstName: "",
                    lastName: "",
                    email: "",
                    password: "", // Secure password handling needed
                    type: userType,
                    profileImage: "", // Handle profile image appropriately
                    phoneNumber: "",
                    location: ""
                )
          }
//            else {
//                // If jobSeeker is already created, update the properties
//                jobSeeker?.firstName = firstName
//                jobSeeker?.lastName = lastName
//                jobSeeker?.email = email
//                jobSeeker?.phoneNumber = phoneNumber
//                jobSeeker?.location = location
//                jobSeeker?.personalSummary = personalSummary
//            }
            
            return true
            }
    func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    
    func loadJobSeekerData() {
        print("Trying to load data")
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User not signed in.")
            return
        }

        let db = Firestore.firestore()
        
        // Reference to the documents for the current user
        let jobSeekerRef = db.collection("JobSeekers").document(userId)
        let userRef = db.collection("Users").whereField("uid", isEqualTo: userId)
        let profileRef = db.collection("Profiles").document(userId)
        print("userID: \(userId)")
        
        // Fetch the user data
        userRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error loading user data: \(error.localizedDescription)")
                return
            }
            
            guard let userData = querySnapshot?.documents.first else {
                print("No user data found.")
                return
            }

            // Fetch the profile data
            profileRef.getDocument { (profileDocument, error) in
                if let error = error {
                    print("Error loading profile data: \(error.localizedDescription)")
                    return
                }
                
                guard let profileData = profileDocument?.data() else {
                    print("No profile data found.")
                    return
                }

                // Fetch the job seeker data
                jobSeekerRef.getDocument { (jobSeekerDocument, error) in
                    if let error = error {
                        print("Error loading job seeker data: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let jobSeekerData = jobSeekerDocument?.data() else {
                        print("No JobSeeker reference found for user.")
                        // Optionally, inform the user that they need to fill in their profile.
                        return
                    }

                    // Document exists, load the data
                    self.firstNameTextField.text = userData["firstName"] as? String
                    self.lastNameTextField.text = userData["lastName"] as? String
                    self.emailTextField.text = Auth.auth().currentUser?.email
                    self.phoneNumberTextField.text = profileData["phoneNumber"] as? String
                    self.locationTextField.text = profileData["location"] as? String
                    self.personalSummaryTextView.text = jobSeekerData["personalSummary"] as? String
                    // Load other fields as needed
                }
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
     @IBAction func editProfilePicButtonTapped(_ sender: Any) {
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

            do {
                // Decode the document data into the specified Codable object type
                if let data = document.data() {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedObject))
                } else {
                    completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to get document data."])))
                }
            } catch {
                // Return a decoding error
                completion(.failure(error))
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

}
