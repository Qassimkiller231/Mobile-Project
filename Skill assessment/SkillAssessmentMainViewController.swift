//
//  SkillAssessmentMainViewController.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 10/12/2024.
//

import UIKit

class SkillAssessmentMainViewController: UIViewController {

    @IBOutlet weak var AnalyticsView: UIView!
    
    @IBOutlet weak var ProgrammingView: UIView!
    
    @IBOutlet weak var NetworkingView: UIView!
    
    @IBOutlet weak var CyberView: UIView!
    
    @IBOutlet weak var AIView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnalyticsView.layer.cornerRadius = 10
        ProgrammingView.layer.cornerRadius = 10
        NetworkingView.layer.cornerRadius = 10
        CyberView.layer.cornerRadius = 10
        AIView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
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
