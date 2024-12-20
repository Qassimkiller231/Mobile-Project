//
//  WebinarTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
//

import UIKit

class WebinarTableViewCell: UITableViewCell {
    static var identifier = "WebinarTableViewCell"
    
    @IBOutlet weak var WebinarTitleLabel: UILabel!
    
    @IBOutlet weak var filter3Button: UIButton!
    @IBOutlet weak var filter2Button: UIButton!
    @IBOutlet weak var filter1Button: UIButton!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
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
    func configure(with webinar: Webinar) {
        WebinarTitleLabel.text = webinar.WebnarTitle
        filter1Button.setTitle(webinar.filters[0], for: .normal)
        filter2Button.setTitle(webinar.filters[1], for: .normal)
        filter3Button.setTitle(webinar.filters[2], for: .normal)
        startDateLabel.text = webinar.Date
        
    }
    
}
