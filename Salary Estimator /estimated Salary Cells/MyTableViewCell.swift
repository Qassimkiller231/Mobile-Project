//
//  MyTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 14/12/2024.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var SalaryLabel: UILabel!
    static func nib() -> UINib {
        UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    static var identifier = "MyTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with model: EstimatedSalary) {
        self.jobLabel.text = model.jobName
        self.SalaryLabel.text = String("\(model.minRange) - \(model.maxRange)")
    }
    
}
