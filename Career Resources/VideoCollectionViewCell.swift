//
//  VideoCollectionViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
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
