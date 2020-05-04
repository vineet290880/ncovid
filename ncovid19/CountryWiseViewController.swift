//
//  CountryWiseViewController.swift
//  ncovid19
//
//  Created by Vineet Pathak on 2020-04-14.
//  Copyright © 2020 Vineet Pathak. All rights reserved.
//

import UIKit

class CountryWiseViewController: UIViewController {
    
    @IBOutlet weak var lastUpdatedDate: UITextField!
    @IBOutlet weak var numberOfDeaths: UITextField!
    @IBOutlet weak var criticalCases: UITextField!
    @IBOutlet weak var recoveredCases: UITextField!
    @IBOutlet weak var confirmedCases: UITextField!
    @IBOutlet weak var populationCountry: UITextField!
    var selectedCountryName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedCountryName
        let ISO3166CountryCodes:[String?:String?] =
            ["India":"in",
             "Canada":"ca",
             "Italy":"it",
             "USA":"us",
             "France":"fr",
             "UK":"gb",
             "China":"cn",
             "Pakistan":"pk",
             "Mexico":"mx"]
        
        let countryCode = (ISO3166CountryCodes[selectedCountryName] ?? "ca") ??
            "ca"
        RestServices.shared.fetchCovidData(country: countryCode) { (result) in
            switch result {
                
            case .success(let covData):
                DispatchQueue.main.async {
                    self.populationCountry.text = "\(covData.data.population.roundedWithAbbrevations)"
                    
                    self.confirmedCases.backgroundColor = .yellow
                    self.confirmedCases.text = "\(covData.data.latestData.confirmed.roundedWithAbbrevations)"
                    self.confirmedCases.textColor = .black
                    
                    self.recoveredCases.backgroundColor = .green
                    self.recoveredCases.text = "\(covData.data.latestData.recovered.roundedWithAbbrevations)"
                     self.recoveredCases.textColor = .black
                    
                    self.criticalCases.backgroundColor = .orange
                     self.criticalCases.textColor = .white
                    self.criticalCases.text = "\(covData.data.latestData.critical.roundedWithAbbrevations)"
                    
                    self.numberOfDeaths.backgroundColor = .red
                    self.numberOfDeaths.textColor = .white
                    self.numberOfDeaths.text = "\(covData.data.latestData.deaths.roundedWithAbbrevations)"
                    
                    //print("\(covData.data.updatedAt.HumanReadbleDate.description)")
                    self.lastUpdatedDate.text = convertDateFormater(date: covData.data.updatedAt)
                }
                
            case .failure(let error):
                print(error)
            }
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Int {
    var roundedWithAbbrevations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        if billion >= 1.0 {
             return "\(round(billion*10)/10) B"
        } else if million >= 1.0 {
            return "\(round(million*10)/10) M"
        } else if thousand >= 1.0 {
            return "\(round(thousand*10)/10) K"
        } else {
            return "\(self)"
        }
    }
}

extension String {
    var HumanReadbleDate: Date {
        var date:Date?
        func DateConverter(dateString:String) -> Date {
            let isoDate = dateString

            let dateFormatter = ISO8601DateFormatter()
                date = dateFormatter.date(from:isoDate)!
                return date ?? Date()
        }
        return date ?? Date()
    }
}

func convertDateFormater(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        return ""
    }

    dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let timeStamp = dateFormatter.string(from: date)

    return timeStamp
}
