//
//  JobDropDownTableViewCell.swift
//  Project
//
//  Created by Hamed on 29/12/2024.
//

import UIKit

class JobDropDownTableViewCell: UITableViewCell {
    static let identifier = "JobDropDownTableViewCell"
    static func nib() -> UINib {
       return UINib(nibName: "JobDropDownTableViewCell", bundle: nil)
    }
    public func configure(with title: String) {
        titleLabel.text = title
    }
    
    public func configureSelectedOption(with title: String) {
        selectOptionLabel.text = title
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectOptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
