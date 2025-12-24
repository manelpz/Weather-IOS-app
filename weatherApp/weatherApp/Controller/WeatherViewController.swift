//
//  weatherViewController.swift
//  weatherApp
//
//  Created by Emmanuel Lopez Guerrero on 15/11/25.
//

import UIKit
import CoreLocation
import Alamofire
//import SwiftyJSON


class weatherAppController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "3a276676f812d47559c80fe9ec1dd796"
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    //Pre-linked IBOutlets
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData(url: String, parameters: [String: Any]){
        
        AF.request(url, method: .get, parameters: parameters).validate().responseDecodable(of:WeatherResponse.self){
            response in
            
            switch response.result {

                case .success(let value):
                    print(value)
                    self.updateWeatherData(value)
                //print(WeatherResponse.init(name: String, main:    ))
                    // parsear JSON aquí
                    

                case .failure(let error):
                    print(error.localizedDescription)
                    self.cityLabel.text = "Connection Issues"
                }
        }
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(_ weather: WeatherResponse) {
        print(weather)
        
        if weather.weather.isEmpty {
            print("There is not weather available")
            cityLabel.text = "There is not weather available"
            return
        }
        
        let tempResult = weather.main.temp
        weatherDataModel.temperature = Int(tempResult - 273.15 )
        weatherDataModel.city = weather.name
        weatherDataModel.condition = weather.weather[0].id
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
        updateUIWithWeatherData()
        
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
        
    //Write the updateUIWithWeatherData method here:
    func updateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            //print("longitud \(location.coordinate.longitude) latitud \(location.coordinate.latitude)")
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let params : [String : String] = ["lat": String(latitude), "lon": String(longitude), "appid": APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    func userEnteredANewCityName(city: String) {
        let params : [String : String] = ["q" :  city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
    
    
    
    
}



