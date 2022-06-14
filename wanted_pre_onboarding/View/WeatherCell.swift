//
//  WeatherCell.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/13.
//

import UIKit

class WeatherCell:UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherIcon:UIImageView!
    @IBOutlet weak var temperatureNameLabel: UILabel!
    @IBOutlet weak var humidityLabel:UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
