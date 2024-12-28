    //
//  CalendarViewController.swift
//  testfinalfinal
//
//  Created by Guest User on 18/12/2024.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var interviewsTable: UITableView!
    var currentApplications: [application] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interviewsTable.delegate = self
        interviewsTable.dataSource = self
        interviewsTable.register(UINib(nibName: "interviewCell", bundle: nil), forCellReuseIdentifier: "interviewCell")
        datePicker.minimumDate = Date()
        
//        df.dateFormat = "dd/MM/yyyy"
        // Add target-action for date picker value change
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        // Initial filter and load
//        filterApplications()


        // Do any additional setup after loading the view.
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Update the applications based on the new date
//        filterApplications()
    }
    
//    func filterApplications() {
//        currentApplications = applications.filter {
//            guard let interview = $0.interview else {
//                return false
//            }
//            
//            let pickerDate = df.string(from: datePicker.date)
//            let matches = interview.interviewDate == pickerDate
//            return matches
//        }
//        interviewsTable.reloadData()
//    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentApplications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "interviewCell", for: indexPath) as! interviewCell
        if let interview = currentApplications[indexPath.row].interview {
            cell.configure(with: interview)
        }

        return cell
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
