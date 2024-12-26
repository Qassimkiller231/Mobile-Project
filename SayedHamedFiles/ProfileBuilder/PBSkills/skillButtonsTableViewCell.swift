//
//  skillButtonsTableViewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 21/12/2024.
//

import UIKit

protocol SkillButtonCellDelegate: AnyObject {
    func didTapEditSkillButton(for skill: Skill)
}

class skillButtonsTableViewCell: UITableViewCell {
    
    
    weak var delegate: SkillButtonCellDelegate?
    



    @IBOutlet weak var SkillNameLabel: UILabel!
    @IBOutlet weak var SkillLevelLabel: UILabel!
    var levelNumber: Int = 0
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let buttons = [button1, button2, button3, button4, button5]
            buttons.forEach { button in
                guard let button = button else { return }
                button.layer.cornerRadius = button.frame.height / 2 // Capsule shape
                button.clipsToBounds = true // Ensure the corner radius is applied
            }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        updateButtonState()
    }
    func updateButtonState() {
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

    
    @IBAction func editSkillTapped(_ sender: Any) {
        let skill = Skill(skillName: SkillNameLabel.text ?? "", skillLevel: String(levelNumber)) // Use your actual model here
            delegate?.didTapEditSkillButton(for: skill)
    }
}
