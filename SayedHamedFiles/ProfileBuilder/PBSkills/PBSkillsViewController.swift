//
//  PBSkillsViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit



class PBSkillsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,SkillCellDelegate,SkillButtonCellDelegate{
   
    
    
    @IBOutlet weak var ManageSkillOverlay: UIView!
    @IBOutlet weak var manageSkillLabel: UILabel!
    @IBOutlet weak var skillNameTextField: UITextField!
    @IBOutlet weak var skillLevelTextField: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var finishManageButton: UIButton!
    
    
    var jobSeeker:JobSeeker?
    var currentEditingSkill: Skill?
    var intLevel: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [button1, button2, button3, button4, button5]
            buttons.forEach { button in
                guard let button = button else { return }
                button.layer.cornerRadius = button.frame.height / 2 // Capsule shape
                button.clipsToBounds = true // Ensure the corner radius is applied
            }
        
        skillLevelTextField.addTarget(self, action: #selector(skillLevelTextFieldChanged), for: .editingChanged)

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "skillTableViewCell", bundle: nil), forCellReuseIdentifier: "skillTableViewCell")
        
        tableView.register(UINib(nibName: "skillButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: "skillButtonsTableViewCell")
        
        // sample data
        if jobSeeker?.skills.isEmpty ?? true {
            jobSeeker?.skills.append(Skill(skillName: "HTML", skillLevel: "1"))
            jobSeeker?.skills.append(Skill(skillName: "CSS", skillLevel: "Expert"))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobSeeker?.skills.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentSkill = jobSeeker?.skills[indexPath.row]
        
        if let intLevel: Int = Int(currentSkill!.skillLevel){
            print("int level \(intLevel)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillButtonsTableViewCell", for: indexPath) as! skillButtonsTableViewCell
            cell.SkillNameLabel.text = currentSkill?.skillName
            cell.levelNumber = intLevel
            cell.SkillLevelLabel.text = "Level: "
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "skillTableViewCell", for: indexPath) as! skillTableViewCell
            cell.SkillNameLabel.text = currentSkill?.skillName
            cell.SkillLevelLabel.text = "Level: \(currentSkill?.skillLevel ?? "")"
            cell.delegate = self
            return cell
        }
        
    }
  
    
    @IBAction func finishManageButtonPressed(_ sender: Any) {
        guard let skillName = skillNameTextField.text, !skillName.isEmpty else {
                // Optionally show an alert or message if skill name is empty
                print("Skill name is empty")
                return
            }
            
            // Check if skillLevel is empty, and use intLevel if it is
            var skillLevel: String
            if let enteredSkillLevel = skillLevelTextField.text, !enteredSkillLevel.isEmpty {
                skillLevel = enteredSkillLevel
            } else if let intLevel = intLevel {
                skillLevel = String(intLevel) // Use intLevel if skillLevel text field is empty
            } else {
                // If both are empty, handle the case
                print("Skill level is empty and no default intLevel found")
                return
            }
            
            if var currentSkill = currentEditingSkill {
                // If editing, update the existing skill
                currentSkill.skillName = skillName
                currentSkill.skillLevel = skillLevel
            } else {
                // If adding a new skill, create a new skill and append it
                let newSkill = Skill(skillName: skillName, skillLevel: skillLevel)
                jobSeeker?.skills.append(newSkill)
            }
            
            // Reload the table view to reflect the changes
            tableView.reloadData()
            
            // Hide the overlay after the operation
            ManageSkillOverlay.isHidden = true
    }
    @IBAction func cancelManageButtonPressed(_ sender: Any) {
        // Hide the overlay
           ManageSkillOverlay.isHidden = true
           
           // Clear the currentEditingSkill so that it doesn't hold any reference to the skill being edited
           currentEditingSkill = nil
           
           // Optionally reset the text fields (this step is optional if you want to leave them unchanged after cancel)
           skillNameTextField.text = ""
           skillLevelTextField.text = ""
           
           // Optionally reset the buttons to their default state
           updateButtonState(levelNumber: 0)
           
           // If you want to completely reset the overlay (in case of Add or Edit mode), you can:
           // Set the finish button back to "Add" if you were in the Add mode, or "Save" if you were editing.
           finishManageButton.setTitle("Add", for: .normal)
    }
    
    
    func didTapEditSkillButton(for skill: Skill) {
        // Show the overlay
            ManageSkillOverlay.isHidden = false
            
            // Change the overlay's title and button text for "Edit"
            manageSkillLabel.text = "Edit Skill"
            finishManageButton.setTitle("Save", for: .normal)
            
            // Set the skill data in the text fields
            skillNameTextField.text = skill.skillName
            // Set the currentEditingSkill to the selected skill
            currentEditingSkill = skill
            
            // Check if the skill level is a valid integer
        if let level = Int(skill.skillLevel) {
               // If it's an integer, update the button background states
               skillLevelTextField.isEnabled = true
               updateButtonState(levelNumber: level)
               
               // Clear the skillLevelTextField if the skill level is valid
               skillLevelTextField.text = ""
           } else {
               // If it's not an integer, enable the text field and reset the buttons
               skillLevelTextField.isEnabled = true
               updateButtonState(levelNumber: 0)  // Reset the button states
               
               // Optionally, set a default message in the skillLevelTextField or leave it empty
               skillLevelTextField.text = skill.skillLevel
               skillLevelTextField.alpha = 1.0
               setButtonsOpacity(alpha: 0.5)
           }
    }
    
    @IBAction func addSkillButtonPressed(_ sender: Any) {
        // Show the overlay
            ManageSkillOverlay.isHidden = false
            
            // Change the overlay's title and button text for "Add"
            manageSkillLabel.text = "Add Skill"
            finishManageButton.setTitle("Add", for: .normal)
            
            // Reset text fields for adding a new skill
            skillNameTextField.text = ""
            skillLevelTextField.text = ""
            
            // Reset the currentEditingSkill to nil as we are adding a new skill
            currentEditingSkill = nil
            
            // Enable the skillLevelTextField and reset the buttons
            skillLevelTextField.isEnabled = true
            updateButtonState(levelNumber: 0)  // Reset buttons to initial state
    }
    
    
    @IBAction func button1Tapped(_ sender: UIButton) {
        updateSkillLevel(level: 1)
    }

    @IBAction func button2Tapped(_ sender: UIButton) {
        updateSkillLevel(level: 2)
    }

    @IBAction func button3Tapped(_ sender: UIButton) {
        updateSkillLevel(level: 3)
    }

    @IBAction func button4Tapped(_ sender: UIButton) {
        updateSkillLevel(level: 4)
    }

    @IBAction func button5Tapped(_ sender: UIButton) {
        updateSkillLevel(level: 5)
    }
    
    func updateSkillLevel(level: Int) {
        // Update the skill level in the text field
        intLevel = level
        skillLevelTextField.text = ""
        
        // If we are editing an existing skill, update it directly
        if var currentSkill = currentEditingSkill {
            currentSkill.skillLevel = "\(intLevel!)"
        }
        
        // Update the button states
        updateButtonState(levelNumber: level)
        
        // Make text field semi-transparent
        skillLevelTextField.alpha = 0.5
        
        // Restore buttons to full opacity
        setButtonsOpacity(alpha: 1.0)
    }


    func updateButtonState(levelNumber: Int) {
        // Reset all buttons first (make them clear)
        button1.backgroundColor = .clear
        button2.backgroundColor = .clear
        button3.backgroundColor = .clear
        button4.backgroundColor = .clear
        button5.backgroundColor = .clear

        // Based on level, set the appropriate number of buttons to black
        switch levelNumber {
        case 1:
            button1.backgroundColor = .black
        case 2:
            button1.backgroundColor = .black
            button2.backgroundColor = .black
        case 3:
            button1.backgroundColor = .black
            button2.backgroundColor = .black
            button3.backgroundColor = .black
        case 4:
            button1.backgroundColor = .black
            button2.backgroundColor = .black
            button3.backgroundColor = .black
            button4.backgroundColor = .black
        case 5:
            button1.backgroundColor = .black
            button2.backgroundColor = .black
            button3.backgroundColor = .black
            button4.backgroundColor = .black
            button5.backgroundColor = .black
        default:
            break // If the levelNumber is 0 or any invalid value, leave the buttons clear
        }
    }
    
    @objc func skillLevelTextFieldChanged(_ textField: UITextField) {
        // Check if the text field is not empty
        if let text = textField.text, !text.isEmpty {
            // Make buttons transparent
            setButtonsOpacity(alpha: 0.5)
            
            // Restore text field to full opacity
            skillLevelTextField.alpha = 1.0
        } else {
            // Restore buttons to full opacity if the text field is empty
            setButtonsOpacity(alpha: 1.0)
        }
    }

    func setButtonsOpacity(alpha: CGFloat) {
        let buttons = [button1, button2, button3, button4, button5]
        buttons.forEach { button in
            button?.alpha = alpha
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToEducation" {
            if let educationVC = segue.destination as? PBEducationViewController {
                educationVC.jobSeeker = jobSeeker
            }
        } else if segue.identifier == "ShowExperience" {
            if let experienceVC = segue.destination as? PBExperienceViewController{
                experienceVC.jobSeeker = jobSeeker
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


