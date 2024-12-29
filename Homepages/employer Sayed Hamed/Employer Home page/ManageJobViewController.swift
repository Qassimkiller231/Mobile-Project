//
//  ManageJobViewController.swift
//  Project
//
//  Created by Hamed on 29/12/2024.
//

import UIKit

class ManageJobViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!

    
    var isEditingJob = false
    // Input fields
    var deadlineDatePicker: UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTableView()
    }

//    func setupTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "InputCell")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropDownCell")
//    }
//    
//    @objc func deadlineChanged(_ sender: UIDatePicker) {
//        newJob.deadline = df.string(from: sender.date)
//        print("Selected Deadline: \(.deadline)")
//    }
//
//
//    // MARK: - TableView DataSource
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 9 // Number of fields (title, description, salary, etc.)
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // One row per section for text fields, expandable rows for drop-downs
//        switch section {
//        case 5, 6, 7, 8: // Drop-down sections
//            return 1 + (jobTypes.count) // Adjust this to handle expanded rows
//        default:
//            return 1 // For non-drop-down sections
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let section = indexPath.section
//
//        if section == 3 && indexPath.row == 0 { // Deadline (using UIDatePicker)
//            let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
//
//            // Create and configure the UIDatePicker if it doesn't already exist
//            if deadlineDatePicker == nil {
//                deadlineDatePicker = UIDatePicker()
//                deadlineDatePicker?.datePickerMode = .dateAndTime
//                deadlineDatePicker?.addTarget(self, action: #selector(deadlineChanged(_:)), for: .valueChanged)
//            }
//
//            // Ensure the picker is not added multiple times
//            deadlineDatePicker?.frame = CGRect(x: 15, y: 0, width: cell.contentView.frame.width - 30, height: 44)
//            if let picker = deadlineDatePicker, !cell.contentView.subviews.contains(picker) {
//                cell.contentView.addSubview(picker)
//            }
//            return cell
//        }
//
//        // Default cell for other sections
//        let cell = tableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath)
//
//        switch section {
//        case 0: // Job Title
//            cell.textLabel?.text = "Job Title"
//            cell.detailTextLabel?.text = newJob.jobTitle.isEmpty ? "Enter job title" : newJob.jobTitle
//        case 1: // Job Description
//            cell.textLabel?.text = "Job Description"
//            cell.detailTextLabel?.text = newJob.jobDescription.isEmpty ? "Enter job description" : newJob.jobDescription
//        case 2: // Salary
//            cell.textLabel?.text = "Salary"
//            cell.detailTextLabel?.text = newJob.jobSalary.isEmpty ? "Enter salary" : newJob.jobSalary
//        case 4: // Offer
//            cell.textLabel?.text = "Offer"
//            cell.detailTextLabel?.text = newJob.offer.isEmpty ? "Enter offer details" : newJob.offer
//        case 5: // Job Type Drop-down
//            if indexPath.row == 0 {
//                cell.textLabel?.text = "Job Type"
//                cell.detailTextLabel?.text = newJob.jobType.rawValue
//                cell.accessoryType = .disclosureIndicator
//            } else {
//                cell.textLabel?.text = "    \(jobTypes[indexPath.row - 1])"
//                cell.textLabel?.textColor = .gray
//                cell.accessoryType = .none
//            }
//        case 6: // Job Category Drop-down
//            if indexPath.row == 0 {
//                cell.textLabel?.text = "Job Category"
//                cell.detailTextLabel?.text = newJob.jobCategory.rawValue
//                cell.accessoryType = .disclosureIndicator
//            } else {
//                cell.textLabel?.text = "    \(jobCategories[indexPath.row - 1])"
//                cell.textLabel?.textColor = .gray
//                cell.accessoryType = .none
//            }
//        case 7: // Job Position Drop-down
//            if indexPath.row == 0 {
//                cell.textLabel?.text = "Job Position"
//                cell.detailTextLabel?.text = newJob.jobPosition.rawValue
//                cell.accessoryType = .disclosureIndicator
//            } else {
//                cell.textLabel?.text = "    \(jobPositions[indexPath.row - 1])"
//                cell.textLabel?.textColor = .gray
//                cell.accessoryType = .none
//            }
//        case 8: // Salary Type Drop-down
//            if indexPath.row == 0 {
//                cell.textLabel?.text = "Salary Type"
//                cell.detailTextLabel?.text = newJob.salaryType.rawValue
//                cell.accessoryType = .disclosureIndicator
//            } else {
//                cell.textLabel?.text = "    \(salaryTypes[indexPath.row - 1])"
//                cell.textLabel?.textColor = .gray
//                cell.accessoryType = .none
//            }
//        default:
//            break
//        }
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = indexPath.section
//        if section == 5 || section == 6 || section == 7 || section == 8 {
//            // Handle drop-down selection
//            if indexPath.row == 0 {
//                // Toggle expansion for the drop-down
//                let expanded = tableView.numberOfRows(inSection: section) > 1
//                tableView.reloadSections(IndexSet(integer: section), with: .automatic)
//            } else {
//                // Save the selected value
//                let selectedOption: String
//                switch section {
//                case 5: selectedOption = jobTypes[indexPath.row - 1]
//                case 6: selectedOption = jobCategories[indexPath.row - 1]
//                case 7: selectedOption = jobPositions[indexPath.row - 1]
//                case 8: selectedOption = salaryTypes[indexPath.row - 1]
//                default: return
//                }
//                print("Selected \(selectedOption)")
//
//                // Save the value in the model
//                switch section {
//                case 5: newJob.jobType = .init(rawValue: selectedOption) ?? .fullTime
//                case 6: newJob.jobCategory = .init(rawValue: selectedOption) ?? .finance
//                case 7: newJob.jobPosition = .init(rawValue: selectedOption) ?? .softwareDev
//                case 8: newJob.salaryType = .init(rawValue: selectedOption) ?? .monthly
//                default: break
//                }
//
//                tableView.reloadSections(IndexSet(integer: section), with: .automatic)
//            }
//        }
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
