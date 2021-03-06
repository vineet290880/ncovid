//
//  CountryDetailsViewController.swift
//  ncovid19
//
//  Created by Vineet Pathak on 2020-05-04.
//  Copyright © 2020 Vineet Pathak. All rights reserved.
//

import UIKit
import Charts

class CountryDetailsViewController: UIViewController {

    var covData:CovidModel? = nil
    var covDetails:CovidModel?
    let TODAY = 0
    let YESTERDAY = 1
    
    @IBOutlet weak var chtChart: LineChartView!
    @IBOutlet weak var yDeaths: UITextField!
    @IBOutlet weak var yRecovered: UITextField!
    @IBOutlet weak var yConfirmed: UITextField!
    @IBOutlet weak var deaths: UITextField!
    @IBOutlet weak var confirmed: UITextField!
    @IBOutlet weak var recovered: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.covDetails = covData
        
        self.deaths.isUserInteractionEnabled = false
        self.deaths.text = "\(covDetails?.data.timeline[TODAY].newDeaths ?? 0)"
        self.deaths.backgroundColor = UIColor.red
        self.deaths.textColor = UIColor.white
        
        self.confirmed.isUserInteractionEnabled = false
        self.confirmed.text = "\(covDetails?.data.timeline[TODAY].newConfirmed ?? 0)"
        self.confirmed.backgroundColor = UIColor.yellow
        self.confirmed.textColor = UIColor.black
        
        
        self.recovered.isUserInteractionEnabled = false
        self.recovered.text = "\(covDetails?.data.timeline[TODAY].newRecovered ?? 0)"
        self.recovered.backgroundColor = UIColor.green
        self.recovered.textColor = UIColor.black
        
        self.yDeaths.isUserInteractionEnabled = false
        self.yDeaths.text = "\(covDetails?.data.timeline[YESTERDAY].newDeaths ?? 0)"
        self.yDeaths.backgroundColor = UIColor.red
        self.yDeaths.textColor = UIColor.white
        self.yConfirmed.isUserInteractionEnabled = false
        self.yConfirmed.text = "\(covDetails?.data.timeline[YESTERDAY].newConfirmed ?? 0)"
        self.yConfirmed.backgroundColor = UIColor.yellow
        self.yConfirmed.textColor = UIColor.black
        self.yRecovered.isUserInteractionEnabled = false
        self.yRecovered.text = "\(covDetails?.data.timeline[YESTERDAY].newRecovered ?? 0)"
        self.yRecovered.backgroundColor = UIColor.green
        self.yRecovered.textColor = UIColor.black
        
        
        // Do any additional setup after loading the view.
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var lineChartEntry = [ChartDataEntry]()
        if (covDetails?.data.timeline.count != 0) {
            for i in 0..<(covDetails?.data.timeline.count)! {
                let date = dateFormatter.date(from: covDetails?.data.timeline[i].date ?? "null")
                let value = ChartDataEntry(x: Double(i), y: Double((covDetails?.data.timeline[i].newConfirmed)!))
                lineChartEntry.append(value)
            }
            let line1 = LineChartDataSet(entries: lineChartEntry, label: "Confirmed")
            line1.colors = [NSUIColor.blue]
            let data = LineChartData()
            data.addDataSet(line1)
            chtChart.data = data
        }
    
    }
}
