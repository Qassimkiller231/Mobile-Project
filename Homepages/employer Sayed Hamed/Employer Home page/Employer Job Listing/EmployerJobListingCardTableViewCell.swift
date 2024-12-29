//
//  JobListingCardTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class JobListingCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var CompanyLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var filter1: UILabel!
    
    @IBOutlet weak var filter2: UILabel!
    
    @IBOutlet weak var filter3: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    static var identifier = "JobListingCardTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "JobListingCardTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        bookmarkImage.image = UIImage(systemName: "bookmark")
//        onBookmarkToggled = nil
//    }
    

    
    
    
    func configure(with job: job) {
        self.titleLabel.text = job.jobName
        self.CompanyLabel.text = job.companyName
        self.locationLabel.text = job.companyLocation
        self.timeLabel.text = "\(job.time) minutes ago"
        self.priceLabel.text = "\(job.salary)/\(job.type)"
        self.filter1.text = job.filters[0]
        self.filter2.text = job.filters[1]
        self.filter3.text = job.filters[2]
        [filter1, filter2, filter3].forEach { label in
            label?.layer.cornerRadius = 8 // Adjust corner radius
            label?.layer.masksToBounds = true // Clip content to bounds
        }
    }
    
}
