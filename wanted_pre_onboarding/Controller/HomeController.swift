//
//  HomeController.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/13.
//

import UIKit

private let WeatherCellIdentifier = "WeatherCell"

class HomeController: UITableViewController {
    //MARK: -Properties
    let titles = ["가","다","마","바","사","아","자","차"]
    let numberOfCities = [4,2,1,1,5,2,2,3]
    let cities = [["Gongju", "Gwangju", "Gumi", "Gunsan"], ["Daegu", "Daejeon"], ["Mokpo"], ["Busan"], ["Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon"], ["Ulsan", "Iksan"], ["Jeonju", "Jeju"], ["Cheonan","Cheongju", "Chuncheon"]]
    
    private var data = [String:WeatherResponse]()
    
    //MARK: -Image Cache
    private var caches: [String:UIImage] = [:]
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    //MARK: -Helpers
    func fetchData(){
        for city in cities{
            for name in city{
                DispatchQueue.global().async {
                    self.getData(city: name)
                }
            }
        }
    }
    
    private func getData(city:String){
        let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=42ea6e295a79d511f4783bb1b96899c1")!
        
        URLSession.shared.dataTask(with: weatherURL) { (data, response, error) in
            if let data = data {
                guard let weather = try? JSONDecoder().decode(WeatherResponse.self, from: data) else { return }
                self.data[city] = weather
                
                let imageName = self.data[city]?.weather.first?.icon
                
                if let _ = self.caches[imageName!] {
                }else{
                    guard let url = URL(string: "http://openweathermap.org/img/wn/\(imageName!)@2x.png") else { return }
                    
                    let getDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
                        guard let data = data else { return }
                        self.caches[imageName!] = UIImage(data: data)
                    }.resume()
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.resume()
    }
}


extension HomeController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfCities.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCities[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let svc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else {return}
        svc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(svc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCellIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        
        let cityName = cities[indexPath.section][indexPath.row]
        let dataOfCity = data[cityName]
        
        cell.cityNameLabel.text = cityName
        cell.weatherIcon.image = caches[dataOfCity?.weather.first?.icon ?? ""]
        cell.temperatureNameLabel.text = "\(Int(((dataOfCity?.main.temp) ?? 0) - 273))°C"
        cell.humidityLabel.text = "\((dataOfCity?.main.humidity) ?? 0)"
        
        return cell
    }
}
