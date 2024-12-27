//
//  DropDownTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 15/12/2024.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    static var identifier = "DropDownTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}
