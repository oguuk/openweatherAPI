//
//  Webservice.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/16.
//

import UIKit

class Webservice {
    
    //MARK: -singleton
    static let shared = Webservice()
    
    //MARK: -Cache
    private let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    //MARK: -APIs
    public func getData(completion: @escaping (Result<[String:WeatherResponse],Error>) -> ()){
        
        var WeatherData = [String:WeatherResponse]()
        
        for city in cities{
            for name in city{
                
                let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=42ea6e295a79d511f4783bb1b96899c1")!
                
                let dataTask = URLSession.shared.dataTask(with: weatherURL) { [weak self] data, _, _ in
                    if let data = data {
                        guard let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data) else { return }
                        let deleteSpaceHyphenName = String((weather.name.split(separator: " ").first!.split(separator: "-").first)!)
                        
                        WeatherData[deleteSpaceHyphenName] = weather
                        self?.getImage(imageName: weather.weather.first!.icon) { result in
                            switch result {
                            case .success(let image):
                                WeatherData[deleteSpaceHyphenName]?.image = image
                                completion(.success(WeatherData))
                            case .failure(_): break
                                
                            }
                        }
                    }
                }
                dataTask.resume()
            }
        }
    }
    
    public func getImage(imageName: String,completion: @escaping (Result<UIImage,Error>) -> ()) {
        let urlString = "http://openweathermap.org/img/wn/\(imageName)@2x.png"
        
        if let image = cache.object(forKey: imageName as NSString) {
            completion(.success(image))
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let _ = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else { return }
                
                self?.cache.setObject(image, forKey: imageName as NSString)
                completion(.success(image))
            }
        }.resume()
    }
}
