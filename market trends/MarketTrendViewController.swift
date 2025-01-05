//
//  MarketTrendViewController.swift
//  Project
//
//  Created by Guest User on 04/01/2025.
//
import UIKit

class MarketTrendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JobsTableViewCell.nib(), forCellReuseIdentifier: JobsTableViewCell.identifer)
        Task {
            do {
                let marketTrends = try await Utilities.DataManager.shared.fetchAllMarketTrends()
                allMarketTrends = marketTrends
                sortMarketTrends()
                tableView.reloadData()
            } catch {
                print("Error fetching market trends: \(error.localizedDescription)")
            }
        }
        // Sort the market trends
        
    }
    
    func sortMarketTrends() {
        allMarketTrends.sort { $0.growthRate > $1.growthRate }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allMarketTrends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.identifer, for: indexPath) as! JobsTableViewCell
        cell.configure(with: allMarketTrends[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
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

