//
//  ChangeCityViewController.swift
//  weatherApp
//
//  Created by Emmanuel Lopez Guerrero on 15/11/25.
//

import UIKit

class ChangeCityViewController: UIViewController {
 
    
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func getWeatherPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

