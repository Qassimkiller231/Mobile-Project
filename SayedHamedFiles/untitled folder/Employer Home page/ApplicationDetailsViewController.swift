//
//  ApplicationDetailsViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 25/12/2024.
//

import UIKit

protocol ApplicationDetailsDelegate: AnyObject {
    func didUpdateApplication(_ application: application)
    func removeApplication(_ application: application)
}

class ApplicationDetailsViewController: UIViewController {

    @IBOutlet weak var applicantNameLabel: UILabel!
    @IBOutlet weak var currentTitleLabel: UILabel!
    @IBOutlet weak var yearsOfExperienceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateOfApplicationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var shortlistButton: UIButton!
    @IBOutlet weak var scheduleInterviewButton: UIButton!
    var currentApplication: application?
    weak var delegate: ApplicationDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currentApplication == nil {
            print("Error: No application selected")
        } else {
            print("Loaded application details for: \(currentApplication!.jobSeeker.firstName)")
        }
        populateApplicationDetails()
        // Do any additional setup after loading the view.
    }
    
    private func populateApplicationDetails() {
        guard let application = currentApplication else { return }
        
        applicantNameLabel.text = "\(application.jobSeeker.firstName) \(application.jobSeeker.lastName)"
        emailLabel.text = application.jobSeeker.email
        phoneNumberLabel.text = application.jobSeeker.phoneNumber
        dateOfApplicationLabel.text = "Date of Application: \(df.string(from: application.dateOfApplication))"
        
        // Determine the current or last job title
        if let ongoingExperience = application.jobSeeker.experiences.first(where: { $0.endDate.lowercased() == "ongoing" }) {
            currentTitleLabel.text = ongoingExperience.jobTitle
        } else if let lastJob = application.jobSeeker.experiences.sorted(by: {
            guard let date1 = df.date(from: $0.endDate),
                  let date2 = df.date(from: $1.endDate) else { return false }
            return date1 > date2
        }).first {
            currentTitleLabel.text = lastJob.jobTitle
        } else {
            currentTitleLabel.text = "No work experience"
        }
        
        // Calculate total years of experience
        var totalExperience: Double = 0
        for experience in application.jobSeeker.experiences {
            if let startDate = df.date(from: experience.startDate),
               let endDate = experience.endDate.lowercased() == "ongoing"
                ? Date()
                : df.date(from: experience.endDate) {
                let experienceDuration = Calendar.current.dateComponents([.month], from: startDate, to: endDate).month ?? 0
                totalExperience += Double(experienceDuration) / 12.0
            }
        }
        totalExperience = floor(totalExperience)
        yearsOfExperienceLabel.text = "Years of Experience: \(Int(totalExperience))"
        
        // Set shortlist button
        shortlistButton.setTitle(application.isShortlisted ? "Unshortlist" : "Shortlist", for: .normal)
        
        // Set location if available
        locationLabel.text = application.jobSeeker.location
        notesTextView.text = application.notes ?? ""
        
        if application.interview != nil {
            scheduleInterviewButton.isHidden = true
        } else {
            scheduleInterviewButton.isHidden = false
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
    @IBAction func copyEmailButtonPressed(_ sender: Any) {
        UIPasteboard.general.string = emailLabel.text
        showAlert(title: "Copied!", message: "Email has been copied to clipboard.")
    }
    @IBAction func copyPhoneNumberButtonPressed(_ sender: Any) {
        UIPasteboard.general.string = phoneNumberLabel.text
        showAlert(title: "Copied!", message: "Phone number has been copied to clipboard.")
    }
    @IBAction func viewCVButtonPressed(_ sender: Any) {
    }
    @IBAction func acceptCandidateButtonPressed(_ sender: Any) {
        // Code to accept the candidate
        showAlert(title: "Accepted", message: "You have accepted the candidate.")
    }
    @IBAction func rejectButtonPressed(_ sender: Any) {
        // Remove application from applications
        if let application = currentApplication {
               // Notify the delegate to remove the application from the list
               delegate?.removeApplication(application) // Update the delegate function to handle removals
           }
        //Send notification to candidate
        showRejectionAlert(title: "Rejected", message: "You have rejected the candidate.") {
            // Dismiss this view controller
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func shortlistButtonPressed(_ sender: Any) {
        if var application = currentApplication {
                print("Toggling shortlisted status")
                
                // Toggle the shortlisted status
                application.isShortlisted.toggle()

                // Update the button title based on shortlisted status
                shortlistButton.setTitle(application.isShortlisted ? "Unshortlist" : "Shortlist", for: .normal)

                // Update the currentApplication object if needed
                currentApplication = application
            }
    }
    @IBAction func scheduleInterview(_ sender: Any) {
        // Create the pop-up view
                let popup = interviewSchedulePopup()
                popup.onSchedule = { selectedDate in
                    // Handle scheduling, e.g., save the selected date for the interview
                    let formattedDate = df.string(from: selectedDate)
                    
                    let timeFormatter = DateFormatter()
                    timeFormatter.dateFormat = "hh:mm a"
                    let formattedTime = timeFormatter.string(from: selectedDate)
                    
                    let intervieweeName = "\(self.currentApplication?.jobSeeker.firstName ?? "") \(self.currentApplication?.jobSeeker.lastName ?? "")"
                    
                    if var application = self.currentApplication {
                        // Save interview details
                        let newInterview = Interview(interviewDate: formattedDate, interviewTime: formattedTime, nameOfIntervieweed: intervieweeName)
                        application.interview = newInterview
                        
                        // Print the interview details to verify
                        print("Interview Scheduled for \(intervieweeName) on \(formattedDate) at \(formattedTime)")
                        
                        self.currentApplication = application
                        print("current application interview: \(self.currentApplication?.interview?.interviewDate ?? "")")
                    }
                    
                    self.showAlert(title: "Scheduled", message: "Interview has been scheduled.")
                }
                
                popup.onCancel = {
                    // Handle cancellation
                    print("Scheduling cancelled")
                }
                
                // Add the pop-up to the current view
                self.view.addSubview(popup)

                // Set up constraints to make sure it fills the screen
                popup.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    popup.topAnchor.constraint(equalTo: self.view.topAnchor),
                    popup.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                    popup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    popup.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                ])
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func showRejectionAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion() // Call the completion handler after the alert is dismissed
        }))
        present(alert, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        
        print("leaving ApplicationDetailsViewController")
                // Save notes to the application before the view disappears
                if var application = currentApplication {
                    print("trying to save notes")
                    application.notes = notesTextView.text
                    delegate?.didUpdateApplication(application)  // Notify the delegate
                }
        }
    
}
