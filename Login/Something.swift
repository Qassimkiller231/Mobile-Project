//
//  Something.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 25/12/2024.
//
import UIKit

class UserDetailsPromptViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var completion: ((String, String, String) -> Void)?
    
    let userTypes = ["Job Seeker", "Employer"]
    var selectedUserType: String?
    
    private let firstNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let lastNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Last Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let userTypePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let userTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Select User Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        userTypePicker.delegate = self
        userTypePicker.dataSource = self
        selectedUserType = userTypes.first // Default selection
        
        setupLayout()
        
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        view.addSubview(userTypeLabel)
        view.addSubview(userTypePicker)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            firstNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            firstNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: 10),
            lastNameField.leadingAnchor.constraint(equalTo: firstNameField.leadingAnchor),
            lastNameField.trailingAnchor.constraint(equalTo: firstNameField.trailingAnchor),
            
            userTypeLabel.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 20),
            userTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userTypePicker.topAnchor.constraint(equalTo: userTypeLabel.bottomAnchor, constant: 10),
            userTypePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userTypePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: userTypePicker.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.topAnchor),
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50)
        ])
    }
    
    @objc private func saveTapped() {
        let firstName = firstNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let lastName = lastNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let userType = selectedUserType ?? userTypes[0]
        
        dismiss(animated: true) {
            self.completion?(firstName, lastName, userType)
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIPickerViewDelegate & UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUserType = userTypes[row]
    }
}
