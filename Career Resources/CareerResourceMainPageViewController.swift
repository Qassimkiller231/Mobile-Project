//
//  CareerResourceMainPageViewController.swift
//  testfinalfinal
//
// 
//

import UIKit

class CareerResourceMainPageViewController: UIViewController {
    
    @IBOutlet weak var articlesButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func ArticlesButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "CareerResource", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ArticlesViewController") as! ArticlesViewController
        vc.currentType = .article
        navigationController?.pushViewController(vc, animated: true)
        
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
