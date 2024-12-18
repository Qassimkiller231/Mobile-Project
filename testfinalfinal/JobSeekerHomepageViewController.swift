//
//  JobSeekerHomepageViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit

class JobSeekerHomepageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    let tags = ["Senior designer", "Designer", "Full-time", "Part-time", "Remote", "Freelance", "UI/UX", "Contract"]
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var FilterPic: UIImageView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var bookmark: UIImageView!
    
    var selectedFilters: [String: String] = [:] // Store filters received from Filters View Controller

    
    
    
    var bookmarkedOnly: Bool = false
    var filteredJobs: [job] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register the custom cell
        collectionView.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        // Set the delegate and data source
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Set up layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.itemSize = CGSize(width: 120, height: 50) // Adjust size as needed
        collectionView.collectionViewLayout = layout
        
        
        
        //            table view commands
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JobListingCardTableViewCell.nib(), forCellReuseIdentifier: JobListingCardTableViewCell.identifier)
        
        
        //        Search bar delegate
        SearchBar.delegate = self
        filteredJobs = jobs
        
        
        
        
        //            adding tap gestures
        profilePic.isUserInteractionEnabled = true
        FilterPic.isUserInteractionEnabled = true
        bookmark.isUserInteractionEnabled = true
        
        let bookmarkTap = UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped))
        bookmark.addGestureRecognizer(bookmarkTap)
        
    }
    
    @objc func bookmarkTapped() {
        
        bookmarkedOnly = !bookmarkedOnly
        bookmark.image = UIImage(systemName: bookmarkedOnly ? "bookmark.fill" : "bookmark")
        
        
        if bookmarkedOnly && bookmarkedJobs.isEmpty {
            print("No bookmarked jobs to display.")
        }
        
        tableView.reloadData()
        
        
    }
    
    //    MARK: - Table view Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bookmarkedOnly  {
            return bookmarkedJobs.count
        } else {
            return filteredJobs.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobListingCardTableViewCell.identifier, for: indexPath) as! JobListingCardTableViewCell
        
        let currentJob = bookmarkedOnly ? bookmarkedJobs[indexPath.row] : filteredJobs[indexPath.row]
        cell.configure(with: currentJob)
        cell.bookmarkImage.isUserInteractionEnabled = !bookmarkedOnly
        
        cell.onBookmarkToggled = { [weak self] in
            guard self == self else { return }
            
            // Toggle the isBookmarked property
            self?.filteredJobs[indexPath.row].isBookmarked.toggle()
            let currentJob = self?.filteredJobs[indexPath.row]
            if let index = bookmarkedJobs.firstIndex(where: { $0.id == currentJob?.id }) {
                // Remove from bookmarkedJobs
                bookmarkedJobs.remove(at: index)
                print("Removed: \(String(describing: currentJob?.jobName))")
            } else {
                // Add to bookmarkedJobs
                bookmarkedJobs.append(currentJob!)
                print("Added: \(String(describing: currentJob?.jobName))")
                print(bookmarkedJobs.count)
            }
            
            // Reload the specific row to update UI
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        
        // Set up the closure to handle bookmark toggling
        
        
        return cell
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredJobs = jobs
        } else {
            filteredJobs = jobs.filter({ $0.jobName.lowercased().starts(with: searchText.lowercased()) })
        }
        tableView.reloadData()
    }
    
    @IBAction func unwindToHomepage(_ segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? advancedFiltersViewController {
            // Access data from FiltersViewController
            let selectedFilters = sourceVC.selectedFilters
            print("Received Filters: \(selectedFilters)")

            // Apply filters or any additional logic
            applyFilters(selectedFilters)
        }
    }
    
    func applyFilters(_ filters: [String: String]) {
        // Example filtering logic
        filteredJobs = jobs.filter { job in
            var matches = true
            if let jobTypeFilter = filters["Job Type"] {
                matches = matches && job.type == jobTypeFilter
            }
            if let positionFilter = filters["Position"] {
                matches = matches && job.jobName.lowercased() == positionFilter.lowercased()
            }
            // Add more filters as needed
            return matches
        }

        tableView.reloadData()
    }
    
    
    
    
    
    
}











    // MARK: - UICollectionViewDataSource & Delegate
extension JobSeekerHomepageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tags.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as! TagCollectionViewCell
            cell.configure(with: tags[indexPath.row])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("Selected: \(tags[indexPath.row])")
        }
    
    
}


