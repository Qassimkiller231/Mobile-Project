//
//  compatabilityResult.swift
//  testfinalfinal
//
//  Created by Guest User on 19/12/2024.
//

import UIKit

class compatabilityResult: UIViewController {
    
    weak var delegate: CheckCompatibilityDelegate?
    
    @IBOutlet weak var label: UILabel! // Assuming you have a UILabel to display the result
    var selectedOption: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the selected option is already passed, update the label
        if let selectedOption = selectedOption {
            label.text = "You selected: \(selectedOption)"
        }
    }
    
    // MARK: - Delegate Method (if you want to use it here)
    func didSelectOption(_ option: String) {
        label.text = "You selected: \(option)"
    }
}
