//
//  WebinarViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
//

import UIKit

class WebinarViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebinarTableViewCellDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WebinarTableViewCell.nib(), forCellReuseIdentifier: WebinarTableViewCell.identifier)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webinars.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WebinarTableViewCell.identifier, for: indexPath) as! WebinarTableViewCell
        cell.delegate = self
        cell.configure(with: webinars[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "webinarToDetail", sender: nil)
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webinarToDetail" {
            let detailVC = segue.destination as! DetailedVideoViewController
            detailVC.webinar = webinars[tableView.indexPathForSelectedRow!.row]
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    func webinarStatusDidChange(_ cell: WebinarTableViewCell, isRegistered: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
                webinars[indexPath.row].isRegistered = isRegistered
    }

}
