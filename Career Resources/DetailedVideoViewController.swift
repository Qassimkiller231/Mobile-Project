//
//  DetailedVideoViewController.swift
//  testfinalfinal
//
//  
//

import UIKit
import WebKit
class DetailedVideoViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    var video : Video?
    var webinar : Webinar?
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let video = video {
            titleLabel.text = video.videoTitle
            descriptionTextView.text = video.videoDescription
            loadYouTubeVideo(videoId: video.videoURL)
        } else if let webinar = webinar {
            titleLabel.text = webinar.WebnarTitle
            descriptionTextView.text = webinar.webnarDescription
            loadYouTubeVideo(videoId: webinar.videoURL)
        }
        
        // Do any additional setup after loading the view.
        func loadYouTubeVideo(videoId: String) {
            let embedHTML = """
                    <html>
                    <body style="margin:0;padding:0;">
                    <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoId)?playsinline=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                    </body>
                    </html>
                    """
            webView.loadHTMLString(embedHTML, baseURL: nil)
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
}
