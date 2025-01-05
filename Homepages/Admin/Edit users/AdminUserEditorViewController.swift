//
//  AdminUserEditorViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 22/12/2024.
//

import UIKit
import Firebase
import FirebaseFirestore

class AdminUserEditorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UserEditorTableViewCellDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var users: [AppUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserEditorTableViewCell", bundle: nil), forCellReuseIdentifier: "UserEditorTableViewCell")
        users = Utilities.DataManager.shared.allUsers
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserEditorTableViewCell", for: indexPath) as! UserEditorTableViewCell
        cell.configure(with: users[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func deleteUser(cell: UserEditorTableViewCell) {
        print("Trying to delete user")
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let user = users[indexPath.row]
        
        if user.type.rawValue == "admin" {
            let alert = UIAlertController(
                title: "Edit Admin User",
                message: "Admin users cannot be edited.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            parent?.present(alert, animated: true, completion: nil)
        }
            
        // Show alert to confirm deletion
        let alert = UIAlertController(
            title: "Delete User",
            message: "Are you sure you want to delete \(user.firstName) \(user.lastName)? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            // Remove the user from the local array
            self.users.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        
            // Remove the user from Firebase
            Firestore.firestore().collection("users").document(user.userID).delete { error in
                if let error = error {
                    print("Error deleting user: \(error.localizedDescription)")
                } else {
                    print("User successfully deleted.")
                }
            }
        }))
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
        }
    
    
    
        func editUser(cell: UserEditorTableViewCell) {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let user = users[indexPath.row]
            switch user.type {
            case .admin:
                // Show an alert that admin users cannot be edited
                let alert = UIAlertController(
                    title: "Edit Admin User",
                    message: "Admin users cannot be edited.",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                parent?.present(alert, animated: true, completion: nil)
                
//            case .employer:
                // Navigate to the company profile screen
//                let companyProfileVC = CompanyProfileViewController()
                //                    companyProfileVC.user = user // Pass the user object to the company profile view
                //                    companyProfileVC.hidesBottomBarWhenPushed = true
                //                parent?.navigationController?.pushViewController(companyProfileVC, animated: true)
                
            case .jobSeeker:
                let storyboard = UIStoryboard(name: "ProfileBuilder", bundle: nil)
                   if let PBPersonalVC = storyboard.instantiateViewController(withIdentifier: "PBPersonalViewController") as? PBPersonalViewController {
                       
                       // Pass userToEdit directly to PBPersonalViewController
                       PBPersonalVC.userToEdit = user

                       PBPersonalVC.modalPresentationStyle = .fullScreen
                       self.present(PBPersonalVC, animated: true, completion: nil)
                   } else {
                       print("Error: Could not instantiate PBPersonalViewController from storyboard.")
                   }
            default:
                return
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
