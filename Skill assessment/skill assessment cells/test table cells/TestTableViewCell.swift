//
//  TestTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 15/12/2024.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TitleLabel: UILabel!
    static var identifier = "TestTableViewCell"
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
    func configure(with string: String) {
        self.TitleLabel.text = string
    }
    
}
