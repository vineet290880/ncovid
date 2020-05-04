//
//  ViewController.swift
//  ncovid19
//
//  Created by Vineet Pathak on 2020-04-12.
//  Copyright © 2020 Vineet Pathak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var selectedCountry: String?
    
    @IBAction func doneButton(_ sender: UIButton) {
        performSegue(withIdentifier: "selectedCountry", sender: self)
        //print("Selected country is \(selectedCountry)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CountryWiseViewController
        vc.selectedCountryName = selectedCountry
    }
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let countries = ["India", "Canada", "USA","Italy", "France", "China", "UK", "Pakistan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countries[row]
        //label.text = countries[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
}

