//
//  TestViewController.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 10/12/2024.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var Text2: UITextView!
    @IBOutlet weak var View2: UIView!
    @IBOutlet weak var View1: UIView!
    @IBOutlet weak var Text1: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        View1.layer.cornerRadius = 25
        View2.layer.cornerRadius = 25
        Text1.layer.cornerRadius = 25
        Text2.layer.cornerRadius = 25
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
