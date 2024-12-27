//
//  NotifcationViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 22/12/2024.
//

import UIKit

class NotifcationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var model : [String] = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NotifcationTableViewCell.nib(), forCellReuseIdentifier: NotifcationTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    //    update the viewWillAppear so that the tabBar is hidden in this page
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.tabBarController?.tabBar.isHidden = true // Hide the tab bar
        }
        
        
    // add the tabbar back before going to another page
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.tabBarController?.tabBar.isHidden = false // Show the tab bar again
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotifcationTableViewCell.identifier, for: indexPath) as! NotifcationTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
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