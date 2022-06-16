//
//  SecondViewController.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/14.
//

import UIKit

class SecondViewController: UIViewController {
    
    var data:WeatherResponse?
    var arrayOfTemperature = [String]()
    let arrayOfWhatLabel = ["현재기온","체감기온","현재습도","최저기온","최고기온","기압","풍속"]
    
    var index = 0
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var descrip: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var what: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = data {
            cityName.text = data.name
            Webservice.shared.getImage(imageName: data.weather.first?.icon ?? "") { image in
                self.icon.image = image
            }
            descrip.text = data.weather.first?.description
            
            arrayOfTemperature.append("\(round((data.main.temp) - 273))°C")
            arrayOfTemperature.append("\(round((data.main.feels_like) - 273))°C")
            arrayOfTemperature.append("\((data.main.humidity))%")
            arrayOfTemperature.append("\(round((data.main.temp_min) - 273))°C")
            arrayOfTemperature.append("\(round((data.main.temp_max) - 273))°C")
            arrayOfTemperature.append("\((data.main.pressure))hPa")
            arrayOfTemperature.append("\((data.wind.speed))m/s")
            
            what.text = arrayOfWhatLabel[index]
            temperature.text = arrayOfTemperature[index]
        }
    }
    
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
