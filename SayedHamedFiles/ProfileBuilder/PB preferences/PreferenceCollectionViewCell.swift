//
//  PreferenceCollectionViewCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 23/12/2024.
//

import UIKit

class PreferenceCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "PreferenceCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    @IBOutlet weak var button: UIButton!
    // Variable to track the selected state
    private var isSelectedPreference: Bool = false
    
    // Callback to notify the ViewController
    var onButtonToggle: ((String, Bool) -> Void)?
    
    // Set default state for the cell
    override func awakeFromNib() {
        super.awakeFromNib()
        adjustButtonWidth()
        resetButton()
    }
    
//    func configure(with title: String) {
//        button.setTitle(title, for: .normal)
//        resetButton()
//    }
    
    private func resetButton() {
        isSelectedPreference = false
        button.alpha = 0.5 // Low opacity for unselected state
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        isSelectedPreference.toggle()
        button.alpha = isSelectedPreference ? 1.0 : 0.5 // Update opacity
        
        // Notify the ViewController of the change
        if let title = button.titleLabel?.text {
            onButtonToggle?(title, isSelectedPreference)
        }
    }
    
    private func adjustButtonWidth() {
        // Example width based on the title
        let title = button.titleLabel?.text ?? ""
        let padding: CGFloat = 20  // Optional padding to give some space around the title
        let calculatedWidth = calculateLabelWidth(for: title) + padding
        
        // Set the button's frame with the new width
        button.frame.size.width = calculatedWidth
    }

    // Helper function to calculate width based on the title
    private func calculateLabelWidth(for title: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 11)  // Ensure the correct font size
        return title.size(withAttributes: [.font: font]).width
    }
    
}
