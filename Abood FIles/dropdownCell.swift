//
//  dropdownCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 13/12/2024.
//

import UIKit

class dropdownCell: UITableViewCell {
    static let identifier = "dropdownCell"
    static func nib() -> UINib {
       return UINib(nibName: "dropdownCell", bundle: nil)
    }
    public func configure(with title: String) {
        titleLabel.text = title
    }
    
    public func configureSelectedOption(with title: String) {
        selectOptionLabel.text = title
    }
    
    @IBOutlet weak var selectOptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
