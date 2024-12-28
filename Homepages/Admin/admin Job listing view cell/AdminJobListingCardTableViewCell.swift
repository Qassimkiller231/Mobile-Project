//
//  JobListingCardTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class AdminJobListingCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var CompanyLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var filter1: UILabel!
    
    @IBOutlet weak var filter2: UILabel!
    
    @IBOutlet weak var filter3: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    static var identifier = "AdminJobListingCardTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "AdminJobListingCardTableViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
   
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

    
    
    
    func configure(with job: job) {
        self.titleLabel.text = job.jobTitle
        self.CompanyLabel.text = job.company?.companyName
        self.locationLabel.text = job.company?.location
        self.timeLabel.text = "\(job.timeFromPost)"
        self.priceLabel.text = "\(job.jobSalary)/\(job.salaryType)"
        self.profileImage.image = UIImage(named: job.company?.profileImage ?? "")
        self.filter1.text = "\(job.jobCategory)"
        self.filter2.text = "\(job.jobPosition)"
        self.filter3.text = "\(job.jobType)"
        [filter1, filter2, filter3].forEach { label in
                label?.layer.cornerRadius = 8 // Adjust corner radius
                label?.layer.masksToBounds = true // Clip content to bounds
            }
        
        
       
            

        
    }
    
}
