//
//  CityDetailsViewController.swift
//  Clear Air
//
//  Created by Piotr Kupczyk on 23.02.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    let noData = "Brak danych"
    
    struct CityDetails:Decodable {
        let so2IndexLevel:Details?
        let no2IndexLevel:Details?
        let pm10IndexLevel:Details?
        let o3IndexLevel:Details?
    }
    
    struct Details:Decodable {
        let id:Int
        let indexLevelName:String
    }
    
    @IBOutlet weak var ozonLable: UILabel!
    @IBOutlet weak var siarkaLable: UILabel!
    @IBOutlet weak var azotLable: UILabel!
    @IBOutlet weak var pm10Lable: UILabel!
    
    var id = 0
    var cityDetails:CityDetails = CityDetails(so2IndexLevel: nil, no2IndexLevel: nil, pm10IndexLevel: nil, o3IndexLevel: nil)
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/" + "\(id)")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                    self.cityDetails = try JSONDecoder().decode(CityDetails.self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
    func setLabels() {
        if let ozon = self.cityDetails.o3IndexLevel?.indexLevelName {
            self.ozonLable.text = ozon
        } else {
            self.ozonLable.text = noData
        }
        
        if let siarka = self.cityDetails.o3IndexLevel?.indexLevelName {
            self.siarkaLable.text = siarka
        } else {
            self.siarkaLable.text = noData
        }
        
        if let azot = self.cityDetails.no2IndexLevel?.indexLevelName {
            self.azotLable.text = azot
        } else {
            self.azotLable.text = noData
        }
        
        if let pm10 = self.cityDetails.pm10IndexLevel?.indexLevelName {
            self.pm10Lable.text = pm10
        } else {
            self.pm10Lable.text = noData
        }
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.setLabels()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
