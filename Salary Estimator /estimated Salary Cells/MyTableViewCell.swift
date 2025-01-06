//
//  MyTableViewCell.swift
//  testfinalfinal
//
// 
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var SalaryLabel: UILabel!
    static var identifier = "MyTableViewCell"
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
    func configure(with model: estimatedJob) {
        self.jobLabel.text = model.jobTitle
        self.SalaryLabel.text = String("\(model.minimumSalary) - \(model.maximumSalary)")
    }
    
}
