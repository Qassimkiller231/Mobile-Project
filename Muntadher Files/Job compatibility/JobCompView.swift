//
//  JobCompView.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 15/12/2024.
//

import UIKit
class JobCompView: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var ApplyButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
     var model: [String] = ["Salary and Benifits", " Qualifications", "Distance and Commute", "Working Hours"]
    
   var sliderValues: [Float] = [0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0,]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SliderCell.nib(), forCellReuseIdentifier: SliderCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func ApplyButtonTap(_ sender: UIButton) {
        showAlert()
    }
    
    
    func showAlert() {
        // Create the alert
        let alert = UIAlertController(title: "Successful",message: "Weight has been updated",
                                      preferredStyle: .alert)
        
        // Add an "OK" action to the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        // Present the alert
        present(alert, animated: true, completion: nil)
    }
    
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SliderCell.identifier, for: indexPath) as! SliderCell
        cell.configure(with: model[indexPath.row])

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
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
