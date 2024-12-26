//
//  experienceTableViewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 22/12/2024.
//

import UIKit

protocol ExperienceTableViewCellDelegate: AnyObject {
    func editExperienceTapped(with experience: Experience)
}

class experienceTableViewCell: UITableViewCell {

    @IBOutlet weak var JobTitleLabel: UILabel!
    @IBOutlet weak var CompanyLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    weak var delegate: ExperienceTableViewCellDelegate?
    
    var selectedExperience: Experience?
    
    static var identifier = "experienceTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "experienceTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with experience: Experience){
        JobTitleLabel.text = experience.jobTitle
        CompanyLabel.text = experience.companyname
        DateLabel.text = "\(experience.startDate) - \(experience.endDate)"
        cityLabel.text = experience.city
        selectedExperience = experience
    }
    
    @IBAction func editExpButtonTapped(_ sender: Any) {
        delegate?.editExperienceTapped(with: selectedExperience!)
    }
}
