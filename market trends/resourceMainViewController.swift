//
//  ViewController.swift
//  M12
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 05/12/2024.
//

import UIKit

class resourceMainViewController: UIViewController {
    
   
    @IBOutlet weak var view1234: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1234.layer.cornerRadius = 10
        
        Task {
            do {
                let fetchedJobs = try await Utilities.DataManager.shared.fetchAllJobs()
                sampleJobs2 = fetchedJobs
                print("Fetched Jobs: \(fetchedJobs)")
            } catch {
                print("Error fetching jobs: \(error.localizedDescription)")
            }
        }
        
    }


}

