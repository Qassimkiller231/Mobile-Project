//
//  SuggestedPathsTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 14/12/2024.
//

import UIKit

class SuggestedPathsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    static var identifier = "SuggestedPathsTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: "SuggestedPathsTableViewCell", bundle: nil)
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
        self.titleLabel.text = title
    }
    
}
