//
//  VideoCollectionViewCell.swift
//  testfinalfinal
//
//  
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var videoButton: UIButton!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(with Title: String) {
        videoButton.setTitle(Title, for: .normal)
    }
}
