//
//  NotifcationTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 22/12/2024.
//

import UIKit

class NotifcationTableViewCell: UITableViewCell {
    static var identifier = "NotifcationTableViewCell"
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
    
    
}
