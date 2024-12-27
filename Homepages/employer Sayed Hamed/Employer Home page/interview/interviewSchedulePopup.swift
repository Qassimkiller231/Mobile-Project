//
//  interviewSchedulePopup.swift
//  testfinalfinal
//
//  Created by Hamed on 26/12/2024.
//
import UIKit

class interviewSchedulePopup: UIView {

    var datePicker: UIDatePicker!
    var scheduleButton: UIButton!
    var cancelButton: UIButton!
    var onSchedule: ((Date) -> Void)?
    var onCancel: (() -> Void)?    
    let customColor = UIColor(red: 77/255, green: 1/255, blue: 147/255, alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Background dimming
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        // Overlay container
        let overlayView = UIView()
        overlayView.backgroundColor = .white
        overlayView.layer.cornerRadius = 15
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(overlayView)

        // Date Picker
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(datePicker)

        // Horizontal Stack for Buttons
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.addSubview(buttonStackView)

        // Schedule Button
        scheduleButton = UIButton(type: .system)
        scheduleButton.setTitle("Schedule", for: .normal)
        scheduleButton.backgroundColor = customColor
        scheduleButton.setTitleColor(.white, for: .normal)
        scheduleButton.layer.cornerRadius = 5
        scheduleButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        buttonStackView.addArrangedSubview(scheduleButton)

        // Cancel Button
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = UIColor.systemGray
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 5
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        buttonStackView.addArrangedSubview(cancelButton)

        // Layout Constraints
        NSLayoutConstraint.activate([
            // Overlay constraints
            overlayView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            overlayView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            overlayView.widthAnchor.constraint(equalToConstant: 320),
            overlayView.heightAnchor.constraint(equalToConstant: 260),

            // Date Picker constraints
            datePicker.topAnchor.constraint(equalTo: overlayView.topAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -20),

            // Button Stack constraints
            buttonStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor, constant: -20),

            // Button heights
            scheduleButton.heightAnchor.constraint(equalToConstant: 44),
            cancelButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    @objc private func scheduleButtonTapped() {
        onSchedule?(datePicker.date)
        self.removeFromSuperview()
    }

    @objc private func cancelButtonTapped() {
        onCancel?()
        self.removeFromSuperview()
    }
}
