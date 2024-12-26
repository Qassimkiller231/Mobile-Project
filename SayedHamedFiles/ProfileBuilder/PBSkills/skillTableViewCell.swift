//
//  skillTableViewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 21/12/2024.
//

import UIKit

protocol SkillCellDelegate: AnyObject {
    func didTapEditSkillButton(for skill: Skill)
}

class skillTableViewCell: UITableViewCell {
    


    @IBOutlet weak var SkillNameLabel: UILabel!
    @IBOutlet weak var SkillLevelLabel: UILabel!
    
    weak var delegate: SkillCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editSkillTapped(_ sender: Any) {
        // Trim "Level: " from the skill level text
           let trimmedSkillLevel = SkillLevelLabel.text?.replacingOccurrences(of: "Level: ", with: "") ?? ""

           // Create the skill object with the trimmed skill level
           let skill = Skill(skillName: SkillNameLabel.text ?? "", skillLevel: trimmedSkillLevel)

           // Pass the skill to the delegate
           delegate?.didTapEditSkillButton(for: skill)    }
}
