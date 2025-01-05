//
//  JobCompView.swift
//  testfinalfinal
//
//  Created by Guest User on 15/12/2024.
//

import UIKit
class JobCompView: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var ApplyButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
     var model: [String] = ["Salary and Benifits", " Qualifications", "Distance and Commute", "Working Hours"]
    
   //var sliderValues: [Float] = [0.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0, 70.0, 80.0, 90.0, 100.0,]
    
    var sliderValues: [Float] = [25.0, 25.0, 25.0, 25.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SliderCell.nib(), forCellReuseIdentifier: SliderCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
//    @IBAction func CheckResukts(_ sender: Any) {
//        let totalWeight = sliderValues.reduce(0, +)
//        if totalWeight != 100.0 {
//            showValidationError()
//        } else {
//            performSegue(withIdentifier: "adjustToFinal", sender: nil)
//        }
//    }
    
    func showValidationError() {
            let alert = UIAlertController(title: "Invalid Weights",
                                           message: "The total weight must equal 100%. Please adjust your sliders.",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    
    
    
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SliderCell.identifier, for: indexPath) as! SliderCell
        cell.configure(with: model[indexPath.row])

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
//    @IBAction func CheckResultTapped(_ sender: Any) {
//        performSegue(withIdentifier: "adjustToFinal", sender: nil)
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
