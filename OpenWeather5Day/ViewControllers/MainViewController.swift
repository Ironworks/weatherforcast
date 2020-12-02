//
//  ViewController.swift
//  OpenWeather5Day
//
//  Created by Trevor Doodes on 29/11/2020.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModelInterface?
    var objectFactory: ObjectFactoryInterface = ObjectFactory()
    var model: APIModel? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "London - 5 Day Forecast"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 162
        
        viewModel = objectFactory.mainViewModel(viewController: self)
        viewModel?.retrieveWeather()
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: {_ in
            self.viewModel?.retrieveWeather()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count =  model?.list.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let weather = model?.list[indexPath.row]
        cell.dateLabel.text = weather?.dateText.formatDate()
        cell.temperatureLabel.text = weather?.main.temp.kelvinToCelciusString()
        cell.descriptionLabel.text = weather?.weather.first?.description
        return cell
    }

}

