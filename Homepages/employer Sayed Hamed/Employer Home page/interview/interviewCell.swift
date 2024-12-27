//
//  interviewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 26/12/2024.
//

import UIKit

class interviewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var interviewLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with interview: Interview) {
        interviewLabel.text = interview.nameOfIntervieweed + " • " + interview.interviewTime + " " + interview.interviewDate
    }
    
}
