//
//  DashboardViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 15/12/2024.
//

import UIKit

class DashboardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var difficultyButton: UIButton!
    
    @IBOutlet weak var languageButton: UIButton!
    
    @IBOutlet weak var languageTableView: UITableView!
    
    @IBOutlet weak var difficultyTableView: UITableView!
    
    @IBOutlet weak var testTableView: UITableView!
    
    var languages:[String] = ["English","Arabic","French","German","Spanish"]
    var difficulties:[String] = ["Easy","Medium","Hard"]
    var tests:[String] = ["Test1","Test2","Test3","Test4","Test5"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testTableView.register(TestTableViewCell.nib(), forCellReuseIdentifier: TestTableViewCell.identifier)
        languageTableView.delegate = self
        languageTableView.dataSource = self
        difficultyTableView.dataSource = self
        difficultyTableView.delegate = self
        testTableView.dataSource = self
        testTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == languageTableView{
            return languages.count
        } else if tableView == difficultyTableView{
            return difficulties.count
        } else {
            return tests.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == testTableView {
            var cell = tableView.dequeueReusableCell(withIdentifier: TestTableViewCell.identifier, for: indexPath) as! TestTableViewCell
            cell.configure(with: tests[indexPath.row])
            return cell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if tableView == languageTableView{
                cell.textLabel?.text = languages[indexPath.row]
            } else if tableView == difficultyTableView{
                cell.textLabel?.text = difficulties[indexPath.row]
            }
            return cell
        }
         
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
