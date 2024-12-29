//
//  UserEditorTableViewCell.swift
//  testfinalfinal
//
//  Created by Hamed on 22/12/2024.
//

import UIKit

protocol UserEditorTableViewCellDelegate: AnyObject {
    func deleteUser(cell: UserEditorTableViewCell)
    func editUser(cell: UserEditorTableViewCell)
}

class UserEditorTableViewCell: UITableViewCell {

    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userType: UILabel!
    @IBOutlet weak var userPic: UIImageView!
    
    weak var delegate: UserEditorTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with user: AppUser) {
        userTitle.text = user.firstName
        userType.text = user.type.rawValue
        userPic.image = user.type == .admin ? UIImage(systemName: "person.crown") : UIImage(systemName: "person")
    }
    
    @IBAction func deleteUserButtonPressed(_ sender: Any) {
        delegate?.deleteUser(cell: self)
    }
    @IBAction func editUserButtonPressed(_ sender: Any) {
        delegate?.editUser(cell: self)
    }
    
}
