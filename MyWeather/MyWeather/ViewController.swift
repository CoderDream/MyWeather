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
        // let url = "http://api.openweathermap.org/data/2.5/weather";
        let url = "http://api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=fcd536623ed6b6d4d6abfdbea7478b45"
        
        let params = ["lat": latitude, "lon":longitude, "cnt":0]
        
//        manager.get(url, parameters: params, success: {
//            (operation:AFHTTPRequestOperation!, responseObject: AnyObject!) in
//            print("JSON: " + responseObject.description!)
//        }, failure: {
//            (operation:AFHTTPRequestOperation!, error: NSError!) in
//            print("Error: " + error.localizedDescription)
//        })
        
       
        manager.get(url,
                    parameters: params,
                    success: { (operation: AFHTTPRequestOperation,
                        responseObject: Any) in
                        var stock = responseObject as? NSDictionary
                        print(stock);
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

