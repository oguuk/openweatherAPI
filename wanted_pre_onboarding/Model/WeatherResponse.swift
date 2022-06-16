//
//  WeatherResponse.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/13.
//
import Foundation
import UIKit

struct WeatherResponse: Decodable {
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind

    private enum CodingKeys:String, CodingKey{
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case name = "name"
    }
    
    struct Weather: Decodable{
        let description:String
        let icon:String
    }
    
    struct Main: Decodable{
        let temp:Double
        let feels_like:Double
        let temp_min:Double
        let temp_max:Double
        let pressure:Double
        let humidity:Double
    }
    
    struct Wind: Decodable {
        let speed:Double
    }
}
