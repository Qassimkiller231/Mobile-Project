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
    
    
    var displayedJobs: [job] = []
    var bookmarkedJobs: [job] = []
    var bookmarkedOnly: Bool = false
    var filteredJobs: [job] = []
    var currentJob: job?
    var currentProfile: Profile?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentProfile = JobSeekerSample
        
        
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
        
        displayedJobs = filterAppliedJobs(with: jobs)
        
        
        
        
        //            adding tap gestures
        profilePic.isUserInteractionEnabled = true
        FilterPic.isUserInteractionEnabled = true
        bookmark.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOverlayButton(_:)))
        profilePic.addGestureRecognizer(tapGesture)
        let bookmarkTap = UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped))
        bookmark.addGestureRecognizer(bookmarkTap)
        
    }
    
    @objc func bookmarkTapped() {
        
        bookmarkedOnly = !bookmarkedOnly
        bookmark.image = UIImage(systemName: bookmarkedOnly ? "bookmark.fill" : "bookmark")
        
        
        if bookmarkedOnly && bookmarkedJobs.isEmpty {
            print("No bookmarked jobs to display.")
        }
        displayedJobs = bookmarkedOnly ? bookmarkedJobs : filterAppliedJobs(with: jobs)
        tableView.reloadData()
        
        
    }
    func filterAppliedJobs(with jobs:[job]) ->  [job]{
        return jobs.filter { job in
                // Check if the job has applications
                guard let applications = job.applications else {
                    return true // Keep the job if there are no applications
                }
                
                // Check if the user has applied to the job
            return !applications.contains(where: { $0.jobSeeker.userID == currentProfile?.userID })
            }
    }
    
    //    MARK: - Table view Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedJobs.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobListingCardTableViewCell.identifier, for: indexPath) as! JobListingCardTableViewCell
        
        let currentJob = displayedJobs[indexPath.row]
        cell.configure(with: currentJob)
        cell.bookmarkImage.isUserInteractionEnabled = !bookmarkedOnly
        
        cell.onBookmarkToggled = { [weak self] in
            guard self == self else { return }
            
            // Toggle the isBookmarked property
            self?.displayedJobs[indexPath.row].isBookmarked.toggle()
            let currentJob = self?.displayedJobs[indexPath.row]
            if let index = self?.bookmarkedJobs.firstIndex(where: { $0.jobId == currentJob?.jobId }) {
                // Remove from bookmarkedJobs
                self?.bookmarkedJobs.remove(at: index)
                print("Removed: \(String(describing: currentJob?.jobTitle))")
            } else {
                // Add to bookmarkedJobs
                self?.bookmarkedJobs.append(currentJob!)
                print("Added: \(String(describing: currentJob?.jobTitle))")
                print(self?.bookmarkedJobs.count)
            }
            
            // Reload the specific row to update UI
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    
        
        // Set up the closure to handle bookmark toggling
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentJob = displayedJobs[indexPath.row]
        performSegue(withIdentifier: "homepageToJobDetails", sender: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
                // Reset `displayedJobs` based on `bookmarkedOnly`
                displayedJobs = bookmarkedOnly ? bookmarkedJobs : filterAppliedJobs(with: jobs)
            } else {
                // Apply search filter on the appropriate jobs list
                let baseJobs = bookmarkedOnly ? bookmarkedJobs : filterAppliedJobs(with: jobs)
                displayedJobs = baseJobs.filter({ $0.jobTitle.lowercased().starts(with: searchText.lowercased()) })
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
        if  segue.identifier == "detailsToHomepage" {
            print ("Came from details")
            print ("added application to  \(currentJob?.jobTitle) by user \(currentJob?.applications?[(currentJob!.applications!.count - 1)].jobSeeker.firstName), total applications = \(currentJob?.applications?.count ?? 0)")
            displayedJobs = filterAppliedJobs(with: jobs)
            tableView.reloadData()
        }
        
    }
    
    func applyFilters(_ filters: [String: String]) {
        // Example filtering logic
        displayedJobs = filterAppliedJobs(with: jobs).filter { job in
            var matches = true
            
            if let jobTypeFilter = filters["Job Type"] {
                matches = matches && job.jobType.rawValue == jobTypeFilter
            }
            
            if let positionFilter = filters["Position"] {
                matches = matches && job.jobTitle.lowercased() == positionFilter.lowercased()
            }
            // Add more filters as needed
            return matches
        }

        tableView.reloadData()
    }
    
    @IBAction func showOverlayButton(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
            
            // Instantiate ProfileOverlayViewController
            let overlayVC = ProfileOverlayViewController(nibName: "ProfileOverlayViewController", bundle: nil)
            
            // Set the presentation style for an overlay effect
            overlayVC.modalPresentationStyle = .overCurrentContext
            overlayVC.modalTransitionStyle = .crossDissolve // Smooth fade-in effect
            
            // Present the overlay and show the tab bar again after dismissing
            overlayVC.dismissCompletion = { [weak self] in
                self?.tabBarController?.tabBar.isHidden = false
            }
            
            self.present(overlayVC, animated: true, completion: nil)
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
    
//    MARK: prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homepageToJobDetails" {
            let vc = segue.destination as! JobDetailsViewController
            vc.job = currentJob
            
        }
    }
    
    
}


