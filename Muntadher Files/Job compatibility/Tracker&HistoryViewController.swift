//
//  Tracker&HistoryViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 23/12/2024.
//

import UIKit

class Tracker_HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var interviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        interviewTableView.dataSource = self
        interviewTableView.delegate = self
        tableView.register(applicationHistoryTableViewCell.nib(), forCellReuseIdentifier: applicationHistoryTableViewCell.identifier)
        interviewTableView.register(applicationHistoryTableViewCell.nib(), forCellReuseIdentifier: applicationHistoryTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: applicationHistoryTableViewCell.identifier, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func jobCompatibilityButtonPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
    }
}
