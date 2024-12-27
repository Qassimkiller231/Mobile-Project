////
////  JobSeekerHomepageViewController.swift
////  testfinalfinal
////
////  Created by Sayed Qassim on 16/12/2024.
////
//
//import UIKit
//
//class test: UIViewController,UITableViewDelegate,UITableViewDataSource {
//
//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var collectionView: UICollectionView!
//    let tags = ["Senior designer", "Designer", "Full-time", "Part-time", "Remote", "Freelance", "UI/UX", "Contract"]
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Register the custom cell
//            collectionView.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
//            
//            // Set the delegate and data source
//            collectionView.dataSource = self
//            collectionView.delegate = self
//            
//            // Set up layout
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .horizontal
//            layout.minimumInteritemSpacing = 8
//            layout.minimumLineSpacing = 12
//            layout.itemSize = CGSize(width: 120, height: 50) // Adjust size as needed
//            collectionView.collectionViewLayout = layout
//            
//            
//            
////            table view commands
//            tableView.delegate = self
//            tableView.dataSource = self
//            tableView.register(JobListingCardTableViewCell.nib(), forCellReuseIdentifier: JobListingCardTableViewCell.identifier)
//        }
//    }
//
//    // MARK: - UICollectionViewDataSource & Delegate
//extension JobSeekerHomepageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return tags.count
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
//            cell.configure(with: tags[indexPath.row])
//            return cell
//        }
//        
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            print("Selected: \(tags[indexPath.row])")
//        }
//    
//    
//    
//    
//    
////    Table view functions
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return jobs.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: JobListingCardTableViewCell.identifier, for: indexPath) as! JobListingCardTableViewCell
//        cell.configure(with: jobs[indexPath.row])
//        return cell
//    }
//    
//}
