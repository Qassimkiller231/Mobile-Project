//
//  HeaderDashboardTableViewCell.swift
//  Project
//
//  Created by Sayed Qassim on 27/12/2024.
//

import UIKit

class HeaderDashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    static var identifier = "HeaderDashboardTableViewCell"
    static func nib() -> UINib {
       return UINib(nibName: identifier, bundle: nil)
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
