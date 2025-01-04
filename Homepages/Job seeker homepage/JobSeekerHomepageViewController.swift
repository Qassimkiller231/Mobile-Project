//
//  JobSeekerHomepageViewController.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 16/12/2024.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
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
    var profileID: String?
    var userID = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()
//        Utilities.DataManager.fetchAllCompanies(completion: {
//            fetchedCompanies in  DispatchQueue.main.async {
//                sampleCompanies = fetchedCompanies
//            }
//        })
        if Utilities.DataManager.shared.companies.isEmpty {
                    print("No companies available. DataManager is still fetching data.")
                } else {
                    print("Companies are ready: \(Utilities.DataManager.shared.companies)")
                    tableView.dataSource = self
                    tableView.reloadData()
                }
        
       
//        fetchData(userID: userID ?? "", collectionName: "jobSeekers") { (result: Result<JobSeeker, Error>) in
//            switch result {
//            case .success(let jobSeeker):
//                self.currentProfile = jobSeeker
//                if let currentJobSeeker = self.currentProfile as? JobSeeker {
//                    print("Fetched JobSeeker: \(currentJobSeeker.email), Phone Num: \(currentJobSeeker.phoneNumber)")
//                }
////                print("test \(self.currentProfile?.companyName)")
//
//            case .failure(let error):
//                print("Error fetching company: \(error.localizedDescription)")
//            }
//        fetchJobSeeker(userID: userID ?? "")
//        uploadCompanyToFirestore(company: polyCompany)
        
        
            self.fetchAllJobs { result in
                switch result {
                case .success(let allJobs):
                    print("Fetched \(allJobs.count) jobs!")
                    jobs = allJobs
                    self.displayedJobs = self.filterAppliedJobs(with: jobs)
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Error fetching jobs: \(error.localizedDescription)")
                }
                
            }
        
            
//            self.uploadJobs(jobs: jobs) { result in
//                switch result {
//                case .success:
//                    print("Jobs uploaded successfully!")
//                case .failure(let error):
//                    print("Error uploading jobs: \(error.localizedDescription)")
//                }
//            }
            
            // Call fetchAllJobs to retrieve all jobs
//
//            self.fetchJob(jobID: "1") { result in
//                switch result {
//                case .success(let job):
//                    print("Fetched Job:")
//                    print("Job Title: \(job.jobTitle)")
//                    print("Job Description: \(job.jobDescription)")
//                    print("Company Name: \(job.company.companyName)")
//                    print("Salary: \(job.jobSalary)")
//                    print("Deadline: \(job.deadline)")
//                    print("--------------------")
//                    
//                case .failure(let error):
//                    print("Error fetching job: \(error.localizedDescription)")
//                }
//            }
//            self.fetchJobBasic(jobID: "1") { result in
//                switch result {
//                case .success(let data):
//                    print("Job fetched successfully: \(data)")
//                case .failure(let error):
//                    print("Error fetching job: \(error.localizedDescription)")
//                }
//            }
            
//            self.fetchAndDecodeJob(jobID: "1") { result in
//                switch result {
//                case .success(let job):
//                    print("Job fetched and decoded successfully:")
//                    print("Title: \(job.jobTitle)")
//                    print("Description: \(job.jobDescription)")
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
            
            
            
            
            
            
           
            
//        }
//        currentProfile = JobSeekerSample
        
        
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
        
        
        //Search bar delegate
        SearchBar.delegate = self
        
        
        
        
        
        //            adding tap gestures
        profilePic.isUserInteractionEnabled = true
        FilterPic.isUserInteractionEnabled = true
        bookmark.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showOverlayButton(_:)))
        profilePic.addGestureRecognizer(tapGesture)
        let bookmarkTap = UITapGestureRecognizer(target: self, action: #selector(bookmarkTapped))
        bookmark.addGestureRecognizer(bookmarkTap)
        
    }
    func uploadCompanyToFirestore(company: Company) {
        let db = Firestore.firestore()
        
        do {
            // Encode the Company object into a dictionary
            let encodedData = try Firestore.Encoder().encode(company)

            // Use the userID as the document ID
            db.collection("companies").document(company.userID).setData(encodedData) { error in
                if let error = error {
                    print("Error uploading company: \(error)")
                } else {
                    print("Company successfully uploaded!")
                }
            }
        } catch {
            print("Encoding error: \(error)")
        }
    }
    
    
    func fetchAllJobs(completion: @escaping (Result<[job], Error>) -> Void) {
        let db = Firestore.firestore()
        var jobs: [job] = []
        let dispatchGroup = DispatchGroup()

        db.collection("jobs").getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }

            for document in documents {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    let job = try JSONDecoder().decode(job.self, from: jsonData)

                    dispatchGroup.enter()
                    db.collection("companies").document(job.companyID).getDocument { companySnapshot, error in
                        if let error = error {
                            print("Error fetching company for job \(job.jobTitle): \(error.localizedDescription)")
                            dispatchGroup.leave()
                            return
                        }

                        guard let companyData = companySnapshot?.data() else {
                            print("Company not found for job \(job.jobTitle)")
                            dispatchGroup.leave()
                            return
                        }

                        do {
                            let companyJson = try JSONSerialization.data(withJSONObject: companyData, options: [])
                            let company = try JSONDecoder().decode(Company.self, from: companyJson)
                            job.company = company
                            jobs.append(job)
                        } catch {
                            print("Error decoding company for job \(job.jobTitle): \(error)")
                        }

                        dispatchGroup.leave()
                    }
                } catch {
                    print("Error decoding job document: \(error)")
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(.success(jobs))
            }
        }
    }
    
    
    func uploadJobs(jobs: [job], completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let batch = db.batch()

        do {
            for job in jobs {
                let jobData = try Firestore.Encoder().encode(job)
                let documentRef = db.collection("jobs").document(job.jobId)
                batch.setData(jobData, forDocument: documentRef)
            }

            batch.commit { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchJob(jobID: String, completion: @escaping (Result<job, Error>) -> Void) {
        let db = Firestore.firestore()

        db.collection("jobs").document(jobID).getDocument { documentSnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let document = documentSnapshot, document.exists, let data = document.data() else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Job not found."])))
                return
            }

            do {
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let job = try JSONDecoder().decode(job.self, from: jsonData)

                // Fetch the associated Company
                db.collection("companies").document(job.companyID).getDocument { companySnapshot, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let companyData = companySnapshot?.data() else {
                        completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Company not found."])))
                        return
                    }

                    do {
                        let companyJson = try JSONSerialization.data(withJSONObject: companyData, options: [])
                        let company = try JSONDecoder().decode(Company.self, from: companyJson)
                        job.company = company
                        completion(.success(job))
                    } catch {
                        completion(.failure(error))
                    }
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    func fetchJobSeeker(userID: String) {
        fetchData(userID: userID, collectionName: "jobSeekers") { (result: Result<JobSeeker, Error>) in
            switch result {
            case .success(let jobSeeker):
                print("Fetched JobSeeker successfully!")
                print("First Name: \(jobSeeker.firstName)")
                print("Last Name: \(jobSeeker.lastName)")
                print("Email: \(jobSeeker.email)")
                print("Phone Number: \(jobSeeker.phoneNumber)")
                print("Location: \(jobSeeker.location)")
                print("Personal Summary: \(jobSeeker.personalSummary)")
                self.currentProfile = jobSeeker
                // Do something with the fetched JobSeeker object
            case .failure(let error):
                print("Error fetching JobSeeker: \(error.localizedDescription)")
            }
        }
    }
    
   

    func fetchData<T: Codable>(userID: String, collectionName: String, completion: @escaping (Result<T, Error>) -> Void) {
        let db = Firestore.firestore()

        // Fetch the document with the specified userID from the collection
        db.collection(collectionName).document(userID).getDocument { documentSnapshot, error in
            if let error = error {
                // Return an error if the fetch fails
                completion(.failure(error))
                return
            }

            // Check if the document exists
            guard let document = documentSnapshot, document.exists else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found."])))
                return
            }

            do {
                // Decode the document data into the specified Codable object type
                if let data = document.data() {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(decodedObject))
                } else {
                    completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to get document data."])))
                }
            } catch {
                // Return a decoding error
                completion(.failure(error))
            }
        }
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
        print(displayedJobs.count)
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
                print(self?.bookmarkedJobs.count ?? 0)
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
            print ("added application to  \(currentJob?.jobTitle ?? "") by user \(currentJob?.applications?[(currentJob!.applications!.count - 1)].jobSeeker.firstName ?? ""), total applications = \(currentJob?.applications?.count ?? 0)")
            displayedJobs = filterAppliedJobs(with: jobs)
            tableView.reloadData()
        }
        
    }
    
    func applyFilters(_ filters: [String: String]) {
        // Example filtering logic
        displayedJobs = filterAppliedJobs(with: jobs).filter { job in
            var matches = true
            if let jobCategoryFilter = filters["Job Category"] {
                matches = matches && job.jobCategory.rawValue == jobCategoryFilter
            }
            if let locationFilter = filters["Location"] {
                matches = matches && job.company.location == locationFilter
            }
            if let minimumSalaryFilter = filters["Minimum Salary"] {
                print("there is min")
                print(Int(job.jobSalary) ?? 0)
                matches = matches && Int(job.jobSalary)! >= Int(minimumSalaryFilter)!
            }
            if let maximumSalaryFilter = filters["Maximum Salary"] {
                matches = matches && Int(job.jobSalary)! <= Int(maximumSalaryFilter)!
            }
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
//        if segue.identifier == ""
    }
    
    
}


