//
//  page4ViewController.swift
//  M12
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 09/12/2024.
//

import UIKit

class page4ViewController: UIViewController {

    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var View3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        View1.layer.cornerRadius = 25
        View2.layer.cornerRadius = 25
        View3.layer.cornerRadius = 25
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
