//
//  DetailsTableViewController.swift
//  WeatherForecast
//
//  Created by Giorgi Shukakidze on 8/5/20.
//  Copyright © 2020 Giorgi Shukakidze. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var selectedCity: City?
    private var weatherData: [Weather]?
    private var spinnerView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpSpinner()
        spinnerView.startAnimating()
        getWeather()
    }
    
    private func setUpSpinner() {
        spinnerView.style = .large
        spinnerView.hidesWhenStopped = true
        spinnerView.color = #colorLiteral(red: 0.4039215686, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
        tableView.backgroundView = spinnerView
    }
    
    private func getWeather() {
        if let city = selectedCity {
            
            WeatherManager.shared.fetchWeahter(for: city) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let weatherResult):
                    self.weatherData = weatherResult
                    DispatchQueue.main.async {
                        self.spinnerView.stopAnimating()
                        self.tableView.reloadData()
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.spinnerView.stopAnimating()
                        self.showAlert(title: "Error loading data", message: "Error loading data, try again.")
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.weatherDetailsCellIdentifier, for: indexPath)
        
        if let weatherInfo = weatherData?[indexPath.row] {
            cell.textLabel?.text = weatherInfo.temperature
            cell.detailTextLabel?.text = weatherInfo.date
        }
        
        return cell
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Utilities
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] (action) in
            self?.getWeather()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
