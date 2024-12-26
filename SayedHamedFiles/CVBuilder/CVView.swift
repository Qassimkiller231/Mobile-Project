//
//  CVView.swift
//  testfinalfinal
//
//  Created by Hamed on 18/12/2024.
//

import UIKit

class CVView: UIView {
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set background color
        context.setFillColor(UIColor.white.cgColor)
        context.fill(rect)
        
        // Draw the circle for profile picture
        let profileCircle = CGRect(x: 20, y: 50, width: 100, height: 100)
        context.setFillColor(UIColor.lightGray.cgColor)
        context.addEllipse(in: profileCircle)
        context.fillPath()
        
        // Draw profile name
        let name = "Your Name"
        let nameAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]
        let nameSize = name.size(withAttributes: nameAttributes)
        name.draw(at: CGPoint(x: 150, y: 70), withAttributes: nameAttributes)
        
        // Draw the title
        let title = "Your Title"
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .foregroundColor: UIColor.darkGray
        ]
        title.draw(at: CGPoint(x: 150, y: 100), withAttributes: titleAttributes)
        
        // Draw contact information
        let contactInfo = "Email: your.email@example.com"
        let contactAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]
        contactInfo.draw(at: CGPoint(x: 20, y: 170), withAttributes: contactAttributes)

        // Draw a line
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(2)
        context.move(to: CGPoint(x: 20, y: 210))
        context.addLine(to: CGPoint(x: rect.width - 20, y: 210))
        context.strokePath()

        // Draw sections (e.g., Education, Experience)
        let sectionTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.black
        ]
        let educationTitle = "Education"
        educationTitle.draw(at: CGPoint(x: 20, y: 230), withAttributes: sectionTitleAttributes)

        let experienceTitle = "Experience"
        experienceTitle.draw(at: CGPoint(x: 20, y: 320), withAttributes: sectionTitleAttributes)

        // Add more content as needed...
        
    }
}
