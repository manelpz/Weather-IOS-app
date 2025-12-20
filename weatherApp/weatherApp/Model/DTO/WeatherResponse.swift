//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by Emmanuel Lopez Guerrero on 20/12/25.
//
struct Weather: Decodable{
    let id: Int
}

struct Main: Decodable {
    let temp: Double
}

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}
