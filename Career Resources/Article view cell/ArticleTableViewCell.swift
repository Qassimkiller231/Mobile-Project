//
//  ArticleTableViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleButton: UIButton!
    
    static var identifier = "ArticleTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with article: String) {
        titleButton.setTitle(article, for: .normal)
        
    }

    
    
}
