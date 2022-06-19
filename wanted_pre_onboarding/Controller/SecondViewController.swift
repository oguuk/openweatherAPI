//
//  SecondViewController.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/14.
//

import UIKit

class SecondViewController: UIViewController {
    
    //MARK: - Data
    var data:WeatherResponse?
    var arrayOfTemperature = [String]()
    let arrayOfWhatLabel = ["현재기온","체감기온","현재습도","최저기온","최고기온","기압","풍속"]
    
    var index = 0
    
    //MARK: -Properties
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var what: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data {
            cityName.text = String(format: NSLocalizedString(data.name, comment: "cityName"))
            icon.image = data.image
            descrip.text = String(format: NSLocalizedString(data.weather.first!.description,comment: "descrip"))
            
            arrayOfTemperature.append("\(Int((data.main.temp) - 273))°C")
            arrayOfTemperature.append("\(Int((data.main.feels_like) - 273))°C")
            arrayOfTemperature.append("\((data.main.humidity))%")
            arrayOfTemperature.append("\(Int((data.main.temp_min) - 273))°C")
            arrayOfTemperature.append("\(Int((data.main.temp_max) - 273))°C")
            arrayOfTemperature.append("\((data.main.pressure))hPa")
            arrayOfTemperature.append("\((data.wind.speed))m/s")
            
            what.text = arrayOfWhatLabel[index]
            temperature.text = arrayOfTemperature[index]
        }
    }
    
    //MARK: -IBAction
    @IBAction func rightButtonClick(_ sender: Any) {
        index = (index+1) % 7
        
        what.text = arrayOfWhatLabel[index]
        temperature.text = arrayOfTemperature[index]
    }
    
    @IBAction func leftButtonClick(_ sender: Any) {
        index = index-1 >= 0 ? index-1 : 6
        
        what.text = arrayOfWhatLabel[index]
        temperature.text = arrayOfTemperature[index]
    }
    
}
