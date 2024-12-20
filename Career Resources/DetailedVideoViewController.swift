//
//  DetailedVideoViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
//

import UIKit

class DetailedVideoViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var video : Video?
    var webinar : Webinar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let video = video {
            titleLabel.text = video.videoTitle
            descriptionTextView.text = video.videoDescription
        } else if let webinar = webinar {
            titleLabel.text = webinar.WebnarTitle
            descriptionTextView.text = webinar.webnarDescription
        }
        
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
