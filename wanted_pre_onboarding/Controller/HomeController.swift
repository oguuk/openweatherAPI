//
//  HomeController.swift
//  wanted_pre_onboarding
//
//  Created by 오국원 on 2022/06/13.
//

import UIKit

let titles = ["가","다","마","바","사","아","자","차"]
let numberOfCities = [4,2,1,1,5,2,2,3]
let cities = [["Gongju", "Gwangju", "Gumi", "Gunsan"], ["Daegu", "Daejeon"], ["Mokpo"], ["Busan"], ["Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon"], ["Ulsan", "Iksan"], ["Jeonju", "Jeju"], ["Cheonan","Cheongju", "Chuncheon"]]

private let WeatherCellIdentifier = "WeatherCell"

class HomeController: UITableViewController {
    //MARK: -Data
    private var data = [String:WeatherResponse]()
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Webservice.shared.getData() { result in
            switch result{
            case .success(let weatherInfos) :
                self.data = weatherInfos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(_): break
            }
        }
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
        guard let svc = storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {return}
        svc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        
        svc.data = data[cities[indexPath.section][indexPath.row]]
        
        self.present(svc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCellIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        
        let cityName = cities[indexPath.section][indexPath.row]
        let dataOfCity = data[cityName]
        
        if let data = dataOfCity{
            cell.weatherIcon.image = data.image
            cell.cityNameLabel.text = String(format: NSLocalizedString(data.name, comment: "cityName"))
            cell.temperatureNameLabel.text = "🌡 \(Int((dataOfCity?.main.temp)! - 273))°C"
            cell.humidityLabel.text = "💧 \(data.main.humidity)%"
        }
        
        return cell
    }
}
