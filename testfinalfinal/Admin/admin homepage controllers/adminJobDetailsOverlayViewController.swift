//
//  adminJobDetailsOverlayViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 25/12/2024.
//

import UIKit
protocol EditDescriptionDelegate: AnyObject {
    func didUpdateDescription(_ updatedDescription: String, _ title: String)
}
class adminJobDetailsOverlayViewController: UIViewController {
    var editTitle : String?
    var editDescription : String?
    weak var delegate: EditDescriptionDelegate?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var TitleButton: UIButton!
    
    @IBOutlet weak var popupView: UIView!
    
    private var initialDescription: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleButton.setTitle(editTitle, for: .normal)
        textView.text = editDescription
        initialDescription = textView.text
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissOnTapOutside))
                view.addGestureRecognizer(tapGesture)
    }
    @objc private func dismissOnTapOutside(_ sender: UITapGestureRecognizer) {
            let location = sender.location(in: view)

            if !popupView.frame.contains(location) {
                // Prompt the user before dismissing
                // Check if the text view content has changed
                    if textView.text == initialDescription {
                        // No changes, dismiss the view without showing the alert
                        dismiss(animated: true, completion: nil)
                    } else {
                        // Changes detected, show the discard confirmation prompt
                        promptBeforeAction(
                            title: "Discard Changes?",
                            message: "Are you sure you want to discard your changes?",
                            discardHandler: {
                                self.dismiss(animated: true, completion: nil)
                            }
                        )
                    }
                
            }
        }
    private func promptBeforeAction(
        title: String,
        message: String,
        discardHandler: (() -> Void)? = nil,
        saveHandler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        if let discardHandler = discardHandler {
            alert.addAction(UIAlertAction(
                title: "Discard",
                style: .destructive,
                handler: { _ in
                    discardHandler()
                }
            ))
        }

        if let saveHandler = saveHandler {
            alert.addAction(UIAlertAction(
                title: "Save",
                style: .default,
                handler: { _ in
                    saveHandler()
                }
            ))
        }

        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))

        present(alert, animated: true, completion: nil)
    }
    @IBAction func discardButtonTapped(_ sender: UIButton) {
        // Check if the text view content has changed
        if textView.text == initialDescription {
                // No changes, dismiss the view without showing the alert
                dismiss(animated: true, completion: nil)
            } else {
                // Changes detected, show the discard confirmation prompt
                promptBeforeAction(
                    title: "Discard Changes?",
                    message: "Are you sure you want to discard your changes?",
                    discardHandler: {
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            }
            
        }

        @IBAction func addButtonTapped(_ sender: UIButton) {
            // Show a confirmation prompt before saving changes
                promptBeforeAction(
                    title: "Save Changes?",
                    message: "Do you want to save your changes?",
                    saveHandler: {
                        print("Changes saved!") // Replace with your save logic
                        self.delegate?.didUpdateDescription(self.textView.text, self.editTitle!)
                        self.dismiss(animated: true, completion: nil)
                    }
                )
            
        }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
