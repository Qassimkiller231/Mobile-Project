//
//  JobsTableViewCell.swift
//  Project
//
//  Created by Guest User on 04/01/2025.
//

import UIKit

class JobsTableViewCell: UITableViewCell {

    static var identifer = "JobsTableViewCell"
    static func nib() -> UINib {
        UINib(nibName: identifer, bundle: nil)
    }
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var growthRateProgressView: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        growthRateProgressView.progress = 0 // Initialize progress to 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with marketTrend: MarketTrend) {
        titlelabel.text = marketTrend.jobTitle
        descriptionLabel.text = "\(marketTrend.jobDescription), growth rate is: \(marketTrend.growthRate)"
        
        // Normalize the growth rate (assuming growth rates are between 0 and 100)
        let normalizedGrowthRate = Float(marketTrend.growthRate / 100)
        growthRateProgressView.progress = normalizedGrowthRate
    }
}
