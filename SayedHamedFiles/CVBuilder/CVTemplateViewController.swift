//
//  CVBuilderViewController.swift
//  testfinalfinal
//
//  Created by Hamed on 18/12/2024.
//

import UIKit

class CVTemplateViewController: UIViewController {

    
    @IBOutlet weak var cvTemp1Img: UIImageView!
    @IBOutlet weak var cvTemp2Img: UIImageView!
    
    @IBOutlet weak var cvTemp3Img: UIImageView!
    @IBOutlet weak var cvTemp4Img: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        cvTemp1Img.isUserInteractionEnabled = true
        cvTemp2Img.isUserInteractionEnabled = true
        cvTemp3Img.isUserInteractionEnabled = true
        cvTemp4Img.isUserInteractionEnabled = true

        let tapTemplate1 = UITapGestureRecognizer(target: self, action: #selector(selectTemplate1))
        cvTemp1Img.addGestureRecognizer(tapTemplate1)

        let tapTemplate2 = UITapGestureRecognizer(target: self, action: #selector(selectTemplate2))
        cvTemp2Img.addGestureRecognizer(tapTemplate2)

        let tapTemplate3 = UITapGestureRecognizer(target: self, action: #selector(selectTemplate3))
        cvTemp3Img.addGestureRecognizer(tapTemplate3)

        let tapTemplate4 = UITapGestureRecognizer(target: self, action: #selector(selectTemplate4))
        cvTemp4Img.addGestureRecognizer(tapTemplate4)

        loadSelectedTemplate()
    }

    @objc func selectTemplate1() {
        saveSelectedTemplate(templateNumber: 1)
    }

    @objc func selectTemplate2() {
        saveSelectedTemplate(templateNumber: 2)
    }

    @objc func selectTemplate3() {
        saveSelectedTemplate(templateNumber: 3)
    }

    @objc func selectTemplate4() {
        saveSelectedTemplate(templateNumber: 4)
    }

    func saveSelectedTemplate(templateNumber: Int) {
            TemplateManager.shared.selectedTemplate = templateNumber
        TemplateManager.shared.selectedTemplateName = "temp\(templateNumber)"
            updateTemplateSelection(selectedTemplate: templateNumber)
        }

        func loadSelectedTemplate() {
            let selectedTemplate = TemplateManager.shared.selectedTemplate
            updateTemplateSelection(selectedTemplate: selectedTemplate)
        }

        func updateTemplateSelection(selectedTemplate: Int = 0) {
            cvTemp1Img.alpha = 0.5
            cvTemp2Img.alpha = 0.5
            cvTemp3Img.alpha = 0.5
            cvTemp4Img.alpha = 0.5

            switch selectedTemplate {
            case 1:
                cvTemp1Img.alpha = 1.0
            case 2:
                cvTemp2Img.alpha = 1.0
            case 3:
                cvTemp3Img.alpha = 1.0
            case 4:
                cvTemp4Img.alpha = 1.0
            default:
                break
            }
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
