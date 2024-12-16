//
//  SalaryInputCell.swift
//  testfinalfinal
//
//  Created by Sayed Qassim on 13/12/2024.
//

import UIKit
import Foundation
protocol SalaryInputCellDelegate: AnyObject {
    func didUpdateSalary(minSalary: Int?, maxSalary: Int?)
}

class SalaryInputCell: UITableViewCell {
    @IBOutlet weak var minSalaryTextField: UITextField!
    @IBOutlet weak var maxSalaryTextField: UITextField!

    weak var delegate: SalaryInputCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextFields()
    }

    private func setupTextFields() {
        minSalaryTextField.keyboardType = .numberPad
        maxSalaryTextField.keyboardType = .numberPad

        // Add target actions for text field value changes
        minSalaryTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        maxSalaryTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    @objc private func textFieldDidChange() {
            let minSalary = Int(minSalaryTextField.text ?? "")
            let maxSalary = Int(maxSalaryTextField.text ?? "")
            delegate?.didUpdateSalary(minSalary: minSalary, maxSalary: maxSalary)
        }

        func configure(minSalary: Int?, maxSalary: Int?) {
            minSalaryTextField.text = minSalary != nil ? "\(minSalary!)" : ""
            maxSalaryTextField.text = maxSalary != nil ? "\(maxSalary!)" : ""
        }
}
