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
    var model: APIModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) 
        
        return cell
    }

}
