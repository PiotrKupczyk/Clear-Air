//
//  AllCitiesTableViewController.swift
//  Clear Air
//
//  Created by Piotr Kupczyk on 23.02.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class AllCitiesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var cities = [City]()
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CityTableViewCell
        
        guard let cityName = cities[indexPath.row].city?.name else {
            return cell
        }
        guard let street = cities[indexPath.row].addressStreet else {
            return cell
        }
        cell.cityLabel.text = cityName
        cell.streetLabel.text = street

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "allCItiesToDetailsSeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondViewController = segue.destination as! CityDetailsViewController
        secondViewController.id = cities[index].id
    }
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.gios.gov.pl/pjp-api/rest/station/findAll")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.cities = try JSONDecoder().decode([City].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
}
