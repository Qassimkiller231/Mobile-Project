//
//  educationTableViewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 20/12/2024.
//

import UIKit

protocol EducationTableViewCellDelegate: AnyObject {
    func editEducationTapped(with education: Education)
}

class educationTableViewCell: UITableViewCell {

    @IBOutlet weak var educationLevelLabel: UILabel!
    @IBOutlet weak var educationFacilityCityLabel: UILabel!
    @IBOutlet weak var educationDatesLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    weak var delegate: EducationTableViewCellDelegate?
    
    var selectedEducation: Education?

    static var identifier = "educationTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "educationTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with education: Education){
        educationLevelLabel.text = education.educationLevel
        educationFacilityCityLabel.text = education.educationFacility + ", " + education.city
        educationDatesLabel.text = "\(education.startDate) - \(education.endDate)"
        selectedEducation = education
    }

    @IBAction func editButtonTapped(_ sender: Any) {
        delegate?.editEducationTapped(with: selectedEducation!)
    }

}
