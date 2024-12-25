//
//  adminJobDetailsOverlayViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 25/12/2024.
//

import UIKit

class adminJobDetailsOverlayViewController: UIViewController {
    var editTitle : String?
    var editDescription : String?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var TitleButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleButton.setTitle(editTitle, for: .normal)
        textView.text = editDescription
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
