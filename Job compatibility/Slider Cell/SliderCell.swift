//
//  SliderCell.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 15/12/2024.
//

import UIKit

class SliderCell: UITableViewCell {
    static var identifier = "SliderCell"
    static func nib() -> UINib {
        return UINib(nibName: "SliderCell", bundle: nil)
    }
    @IBOutlet weak var silderValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(with value: String) {
        self.titleLabel.text = value
        self.slider.value = 0
    }
    
   
    func updateLabelWithSliderValue() {
            let sliderValue = Int(slider.value)  // Convert slider value to integer
        silderValueLabel.text = "\(sliderValue)"  // Set label to slider's integer value
        }
    
    @IBAction func silderValueChanged(_ sender: Any) {
        slider.value = round(slider.value / 5) * 5
        updateLabelWithSliderValue()
    }
    
    
}
