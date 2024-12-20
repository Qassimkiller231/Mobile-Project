//
//  ArticlesViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 20/12/2024.
//

import UIKit

class ArticlesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
   
    enum Pagetype{
        case article
        case guide
    }
    
    var currentType : Pagetype = .article
    var articles : [Article] = []
    var guides : [Guide] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        // Do any additional setup after loading the view.
        tableView.backgroundColor = .clear
    }
    
    
    
//    MARK: Table View delegates and datasources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentType == .article {
            return articles.count
        } else {
            return guides.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        if currentType == .article {
            cell.configure(with: articles[indexPath.row].articleTitle)
        } else if currentType == .guide {
            cell.configure(with: guides[indexPath.row].guideTitle)
        }
        
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentType == .article {
            let selectedArticle = articles[indexPath.row]
            let storyboard = UIStoryboard(name: "CareerResource", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! PerfectResumeViewController
            vc.article = selectedArticle
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let selectedGuide = guides[indexPath.row]
            let storyboard = UIStoryboard(name: "CareerResource", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "GuideDetailsViewController") as! GuideDetailsViewController
            vc.guide = selectedGuide
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
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
