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
    
    var viewDashboardMap: [UIView: SkillAssessmentDashboard] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnalyticsView.layer.cornerRadius = 10
        ProgrammingView.layer.cornerRadius = 10
        NetworkingView.layer.cornerRadius = 10
        CyberView.layer.cornerRadius = 10
        AIView.layer.cornerRadius = 10
        
        mapViewToDashboard(AnalyticsView, dashboardName: "Analytics")
                mapViewToDashboard(ProgrammingView, dashboardName: "Programming")
                mapViewToDashboard(NetworkingView, dashboardName: "Networking")
        mapViewToDashboard(CyberView, dashboardName: "Cyber Security")
         
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true // Hide the tab bar
    }
    
    
// add the tabbar back before going to another page
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false // Show the tab bar again
    }
    
    private func mapViewToDashboard(_ view: UIView, dashboardName: String) {
          guard let dashboard = skillAssessmentDashboards.first(where: { $0.name == dashboardName }) else { return }
          viewDashboardMap[view] = dashboard
          addTapGesture(to: view)
      }
    private func addTapGesture(to view: UIView) {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(_:)))
           view.isUserInteractionEnabled = true
           view.addGestureRecognizer(tapGesture)
       }
    @objc private func handleCardTap(_ sender: UITapGestureRecognizer) {
            guard let tappedView = sender.view else { return }
            
            // Get the corresponding SkillAssessmentDashboard object
            guard let selectedDashboard = viewDashboardMap[tappedView] else { return }
            
            // Navigate to the next view controller
            let storyboard = UIStoryboard(name: "SkillAssessment", bundle: nil)
            let dashboardVC = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            
            // Pass the selected dashboard to the next view controller
            dashboardVC.dashboard = selectedDashboard
            
            navigationController?.pushViewController(dashboardVC, animated: true)
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
