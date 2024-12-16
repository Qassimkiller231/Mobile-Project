//
//  model.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 13/12/2024.
//

import Foundation

struct Section {
    let title: String
    var isExpanded: Bool
    var options: [String] // Dropdown options for sections that use dropdowns
    var selectedOption: String? // Selected dropdown option (if applicable)
    var minSalary: Int? // Minimum Salary (as an integer value)
    var maxSalary: Int? // Maximum Salary (as an integer value)
}

var sections: [Section] = [
    Section(title: "Job Category", isExpanded: false, options: ["Option 1", "Option 2"], selectedOption: nil, minSalary: nil, maxSalary: nil),
    Section(title: "Industry", isExpanded: false, options: ["Option 1", "Option 2"], selectedOption: nil, minSalary: nil, maxSalary: nil),
    Section(title: "Location", isExpanded: false, options: ["Option 1", "Option 2","3","4"], selectedOption: nil, minSalary: nil, maxSalary: nil),
    Section(title: "Salary", isExpanded: false, options: [], selectedOption: nil, minSalary: 0, maxSalary: 5), // Default salary values
    Section(title: "Work Preference", isExpanded: false, options: ["Option 1", "Option 2"], selectedOption: nil, minSalary: nil, maxSalary: nil)
]
