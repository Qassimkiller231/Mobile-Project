//
//  JobSeekerHomepageCollectionViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    static let identifier = "TagCollectionViewCell"
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Style the cell
            contentView.layer.cornerRadius = 12
            contentView.layer.masksToBounds = true
            contentView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.1)
            titleLabel.textColor = UIColor.systemPurple
            titleLabel.textAlignment = .center
        }
        
        func configure(with title: String) {
            titleLabel.text = title
        }
        
        static func nib() -> UINib {
            return UINib(nibName: "TagCollectionViewCell", bundle: nil)
        }

}
