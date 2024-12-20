//
//  GuideDetailsViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
//

import UIKit

class GuideDetailsViewController: UIViewController {
    
    @IBOutlet weak var GuideTitleLabel: UILabel!
    var guide : Guide?
    override func viewDidLoad() {
        super.viewDidLoad()
        GuideTitleLabel.text = guide?.guideTitle
        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Guide" {
            let vc = segue.destination as! PerfectResumeViewController
            vc.guide = guide
        }
    }

}
