//
//  UserEditorTableViewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 22/12/2024.
//

import UIKit

class UserEditorTableViewCell: UITableViewCell {

    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func configure(with user: User) {
//        userTitle.text = user.firstName
//        userType.text = user.type
//        userPic.image = user.type == .admin ? UIImage(systemName: "person.crown") : UIImage(systemName: "person")
//    }
    
    @IBAction func deleteUserButtonPressed(_ sender: Any) {
    }
    @IBAction func editUserButtonPressed(_ sender: Any) {
    }
    
}
