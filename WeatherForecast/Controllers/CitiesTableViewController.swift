//
//  CitiesTableViewController.swift
//  WeatherForecast
//
//  Created by Giorgi Shukakidze on 8/5/20.
//  Copyright © 2020 Giorgi Shukakidze. All rights reserved.
//

import UIKit



class CitiesTableViewController: UITableViewController {
    
    private var cities: [City] = {
        return [
            City(name: "Tbilisi", lat: "41.7151", lon: "44.8271"),
            City(name: "Batumi", lat: "41.6168", lon: "41.6367"),
            City(name: "Kutaisi", lat: "42.2662", lon: "42.7180"),
            City(name: "London", lat: "51.5074", lon: "0.1278"),
            City(name: "Liverpool", lat: "53.4084", lon: "2.9916"),
            City(name: "New York", lat: "40.7128", lon: "74.0060")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityCellIdentifier, for: indexPath)

        cell.textLabel?.text = cities[indexPath.row].name

        return cell
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let city = cities[indexPath.row]
        performSegue(withIdentifier: Constants.weatherDetailsSegueIdentifier, sender: city)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsTableViewController,
            let city = sender as? City {
            detailsVC.selectedCity = city
            detailsVC.title = city.name
        }
    }

}
