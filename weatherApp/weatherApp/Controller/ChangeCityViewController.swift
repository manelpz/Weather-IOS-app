//
//  ChangeCityViewController.swift
//  weatherApp
//
//  Created by Emmanuel Lopez Guerrero on 15/11/25.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city : String)
}

class ChangeCityViewController: UIViewController {
 
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        
        let cityName = changeCityTextField.text!
        delegate?.userEnteredANewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

