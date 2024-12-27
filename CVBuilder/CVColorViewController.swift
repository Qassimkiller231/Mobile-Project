//
//  CVColorViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 18/12/2024.
//

import UIKit

class CVColorViewController: UIViewController {

    @IBOutlet weak var templateImg: UIImageView!
    @IBOutlet weak var colorWell: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadTemplateImage()
        
        colorWell.selectedColor = TemplateManager.shared.selectedColor
        templateImg.backgroundColor = TemplateManager.shared.selectedColor
        
                // Set up the color well action
                colorWell.addTarget(self, action: #selector(colorWellChanged), for: .valueChanged)
            }

            func loadTemplateImage() {
                let selectedTemplate = TemplateManager.shared.selectedTemplate
                switch selectedTemplate {
                case 1:
                    templateImg.image = UIImage(named: "cvTemp1")
                case 2:
                    templateImg.image = UIImage(named: "cvTemp2")
                case 3:
                    templateImg.image = UIImage(named: "cvTemp3") // Add if needed
                case 4:
                    templateImg.image = UIImage(named: "cvTemp4") // Add if needed
                default:
                    templateImg.image = nil
                }
            }

            @objc func colorWellChanged() {
                // Change the background color of the image and save the selected color
                       let newColor = colorWell.selectedColor
                templateImg.backgroundColor = newColor
                TemplateManager.shared.selectedColor = newColor ?? .white // Save the selected color
            }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
