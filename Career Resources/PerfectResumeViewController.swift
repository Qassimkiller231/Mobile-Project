//
//  PerfectResumeViewController.swift
//  testfinalfinal
//
//  
//

import UIKit

class PerfectResumeViewController: UIViewController {
    var article: Article?
    var guide : Guide?
    @IBOutlet weak var ArticleTitle: UILabel!
    @IBOutlet weak var articleTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = article {
            ArticleTitle.text = article.articleTitle
            articleTextView.text = article.articleDescription
        } else {
            ArticleTitle.text = guide!.guideTitle
            articleTextView.text = guide!.guideDescription
        }
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    

}
