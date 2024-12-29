//
//  JobListingCardTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

protocol EmployerJobListinCellDelegate: AnyObject{
    func didTapViewApplications(cell: EmployerJobListingCardTableViewCell)
    func didTapEditJobListingCard(cell: EmployerJobListingCardTableViewCell)
}

class EmployerJobListingCardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var numberOfApplicantsLabel: UILabel!
    @IBOutlet weak var jobCategoryLabel: UILabel!
    @IBOutlet weak var jobTypeLabel: UILabel!
    @IBOutlet weak var jobPositionLabel: UILabel!
    @IBOutlet weak var jobTimeFromPostLabel: UILabel!
    @IBOutlet weak var jobApplicationDeadlineLabel: UILabel!
    
    weak var delegate: EmployerJobListinCellDelegate?
    
    static var identifier = "EmployerJobListingCardTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "EmployerJobListingCardTableViewCell", bundle: nil)
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
        self.jobTitleLabel.text = job.jobTitle
        self.numberOfApplicantsLabel.text = "Number of Applicants : \(job.applications?.count ?? 0)"
        self.jobCategoryLabel.text = job.jobCategory.rawValue
        self.jobTypeLabel.text = job.jobType.rawValue
        self.jobPositionLabel.text = job.jobPosition.rawValue
        self.jobTimeFromPostLabel.text = job.timeFromPost
        self.jobApplicationDeadlineLabel.text = job.deadline
    }
    
    @IBAction func editJobPressed(_ sender: Any) {
        delegate?.didTapEditJobListingCard(cell: self)
    }
    @IBAction func viewApplicationsPressed(_ sender: Any) {
        delegate?.didTapViewApplications(cell: self)
    }
}
