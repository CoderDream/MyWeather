//
//  ViewController.swift
//  MyWeather
//
//  Created by CoderDream on 2018/11/5.
//  Copyright © 2018 CoderDream. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        //
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        print(UIDevice.current.systemVersion)
        //if(ios8()) {
            locationManager.requestAlwaysAuthorization()
        //}
        
        locationManager.startUpdatingLocation()
    }

    func ios8() -> Bool {
        return UIDevice.current.systemVersion > "8.0"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager didUpdateLocations")
        let location:CLLocation = locations[locations.count - 1] as CLLocation
        if(location.horizontalAccuracy > 0) {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            
            updateWeatherInfo(latitude:location.coordinate.latitude, longitude:location.coordinate.longitude);
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    func updateWeatherInfo(latitude:CLLocationDegrees, longitude:CLLocationDegrees) {
        let manager = AFHTTPRequestOperationManager()
        let url = "http://api.openweathermap.org/data/2.5/weather";
        //let url = "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=15f8d9e4177673f65179362e732d65bf"
        
        let params = ["lat": latitude, "lon":longitude, "cnt":0, "APPID":"15f8d9e4177673f65179362e732d65bf"] as Any
        manager.get(url,
                    parameters: params,
                    success: { (operation: AFHTTPRequestOperation,
                        responseObject: Any) in
                        var info = responseObject as? NSDictionary
                        print(info);
                        print("OK")
                        
                       // self.updateUISuccess(responseObject as NSDictionary!)
        },
                    failure: { (operation: AFHTTPRequestOperation!,
                        error: Error!) in
                        print("Error: " + error.localizedDescription)
                        
                       // self.loading.text = "Internet appears down!"
        })
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError")
        print(error)
    }

}

