//
//  ChangeCityViewController.swift
//  weatherApp
//
//  Created by Emmanuel Lopez Guerrero on 15/11/25.
//

import UIKit

class ChangeCityViewController: UIViewController {
 
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var getWeatherPressed: UILabel!
    
    
    @IBAction func changeCityTextField(_ sender: Any) {
    }
    
}
