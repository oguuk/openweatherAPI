//
//  Webservice.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/16.
//

import UIKit

class Webservice {
    static let shared = Webservice()
    
    private let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    public func getData(city:String,completion: @escaping (WeatherResponse?) -> Void){
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=42ea6e295a79d511f4783bb1b96899c1")!
        
        URLSession.shared.dataTask(with: weatherURL) { [weak self] data, _, _ in
            if let data = data {
                guard let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                    completion(nil)
                    return
                }
                completion(weather)
            }
        }.resume()
    }
    
    public func getImage(imageName: String,completion: @escaping (UIImage?) -> Void) {
        let urlString = "http://openweathermap.org/img/wn/\(imageName)@2x.png"
        
        if let image = cache.object(forKey: imageName as NSString) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let _ = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                self?.cache.setObject(image, forKey: imageName as NSString)
                completion(image)
            }
        }.resume()
    }
}
