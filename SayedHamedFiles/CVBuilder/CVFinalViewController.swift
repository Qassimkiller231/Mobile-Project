//
//  CVFinalViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 18/12/2024.
//

import UIKit

class CVFinalViewController: UIViewController {

    @IBOutlet weak var cvView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSelectedTemplate()
            }
            
    private func loadSelectedTemplate() {
        // Fetch the selected template from TemplateManager
        let selectedTemplateName = TemplateManager.shared.selectedTemplateName
        print("Loading template: \(selectedTemplateName)")
        
        // Load the selected template from the XIB
        let nib = UINib(nibName: selectedTemplateName, bundle: nil)
        let instantiatedViews = nib.instantiate(withOwner: self, options: nil)
        print("Instantiated views count: \(instantiatedViews.count)")
        
        // Instantiate the view from the XIB
        if let templateView = instantiatedViews.first as? temp1 {
            print("Template view loaded successfully.")
            
            // Set the frame to match the cvView
            templateView.translatesAutoresizingMaskIntoConstraints = false
            cvView.addSubview(templateView)
            
            NSLayoutConstraint.activate([
                templateView.leadingAnchor.constraint(equalTo: cvView.safeAreaLayoutGuide.leadingAnchor),
                templateView.trailingAnchor.constraint(equalTo: cvView.safeAreaLayoutGuide.trailingAnchor),
                templateView.topAnchor.constraint(equalTo: cvView.safeAreaLayoutGuide.topAnchor),
                templateView.bottomAnchor.constraint(equalTo: cvView.safeAreaLayoutGuide.bottomAnchor)
            ])

            // Create a JobSeeker instance
            let sampleJobSeeker = JobSeeker(
                personalSummary: "Experienced software developer with expertise in Swift and iOS development.",
                educations: [
                    Education(educationFacility: "Harvard University", educationLevel: "Bachelor's", degree: "B.Sc. in Computer Science", startDate: "2015", endDate: "2019", city: "Cambridge"),
                    Education(educationFacility: "MIT", educationLevel: "Master's", degree: "M.Sc. in AI", startDate: "2020", endDate: "2022", city: "Cambridge")
                ],
                experiences: [
                    Experience(jobTitle: "iOS Developer", companyName: "Apple", startDate: "2019", endDate: "2021", city: "Cupertino"),
                    Experience(jobTitle: "Senior iOS Developer", companyName: "Google", startDate: "2021", endDate: "2024", city: "Mountain View")
                ],
                skills: [
                    Skill(skillName: "Swift", skillLevel: "Expert"),
                    Skill(skillName: "UI Design", skillLevel: "Advanced"),
                    Skill(skillName: "Project Management", skillLevel: "Intermediate")
                ],
                preferences: [],
                cv: "sampleCV.pdf",
                suggestedCareerPaths: [],
                firstName: "John",
                lastName: "Doe",
                email: "john.doe@example.com",
                password: "password123",
                type: .jobSeeker,
                profileImage: "profilePic",
                phoneNumber: "123-456-7890",
                location: "New York"
            )
            
            // Populate the template with JobSeeker data
            templateView.populate(with: sampleJobSeeker)
        } else {
            print("Failed to load template view.")
        }
    }

    private func exportCVToPDF() {
        // Get the bounds of the cvView
        let pdfPageBounds = cvView.bounds

        // Create a mutable data object to hold the PDF data
        let pdfData = NSMutableData()

        // Create a PDF graphics context
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
        UIGraphicsBeginPDFPage()

        // Render the cvView's layer into the PDF context
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        cvView.layer.render(in: pdfContext)

        // End the PDF graphics context
        UIGraphicsEndPDFContext()

        // Temporary file path to save the PDF before exporting
        let tempDirectory = FileManager.default.temporaryDirectory
        let tempFileURL = tempDirectory.appendingPathComponent("CV.pdf")

        // Write the PDF data to the temporary file
        do {
            try pdfData.write(to: tempFileURL)
            print("PDF created at: \(tempFileURL)")

            // Present the save dialog to export the PDF
            let documentPicker = UIDocumentPickerViewController(forExporting: [tempFileURL])
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)

        } catch {
            print("Failed to create PDF: \(error.localizedDescription)")
            // Optionally show an error alert
            let alert = UIAlertController(title: "Error", message: "Failed to create CV as a PDF.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    @IBAction func saveToPdf(_ sender: Any) {
        exportCVToPDF()
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

extension CVFinalViewController: UIDocumentPickerDelegate {
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker was cancelled")
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("PDF saved to: \(urls.first?.path ?? "Unknown location")")
        let alert = UIAlertController(title: "Success", message: "Your CV has been saved to the Files app.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
