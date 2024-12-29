//
//  PBPersonalViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit

class PBPersonalViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    var userToEdit :AppUser?
    var personalTableViewController: PBPersonalTableViewController? {
            return children.compactMap { $0 as? PBPersonalTableViewController }.first
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PBPersonalViewController loaded")
        personalTableViewController?.loadJobSeekerData()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ShowEducation" {
                if let destinationVC = segue.destination as? PBEducationViewController {
                    // Validate inputs before proceeding
                    if let personalTableVC = personalTableViewController {
                        destinationVC.jobSeeker = personalTableVC.jobSeeker
                        if personalTableVC.validateInputs() {
                            // Pass the JobSeeker instance if validation is successful
                            destinationVC.jobSeeker = personalTableVC.jobSeeker
                        } else {
                            // Show an alert if validation fails
                            showAlert(message: "Please fill in all fields correctly.")
                            return
                        }
                    }
                }
            }
        }
    
    func showAlert(message: String) {
            let alert = UIAlertController(title: "Input Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
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
