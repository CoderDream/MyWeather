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
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var loading: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
        //
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 启动加载动画
        self.loadingIndicator.startAnimating()
        
        // 设置背景图片
        let background = UIImage(named: "background.png")
        self.view.backgroundColor = UIColor(patternImage: background!)
        
//        var sunsetDouble:Double = 0.0
//        if(sunset != nil) {
//            sunsetDouble = sunset!
//        }
        
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
                        let info = responseObject as? NSDictionary
                        // print(info);
                        //  print("OK")
                        
                        // self.updateUISuccess(responseObject as? NSDictionary!)
                        self.updateUISuccess(jsonResult: info)
        },
                    failure: { (operation: AFHTTPRequestOperation!,
                        error: Error!) in
                        print("Error: " + error.localizedDescription)
                        
                        // self.loading.text = "Internet appears down!"
        })
        
    }
    
    func updateUISuccess(jsonResult:NSDictionary!) {
        // 停止加载动画
        self.loadingIndicator.isHidden = true
        self.loadingIndicator.stopAnimating()
        // 清空加载文字
        self.loading.text = nil
        
        if let tempResult = (jsonResult["main"] as! NSDictionary)["temp"] as? Double {
            var temperature: Double = 0.0
            if((jsonResult["sys"] as! NSDictionary)["country"] as? String == "US") {
                temperature = round(((tempResult - 273.15) * 1.8) + 32)
            }
            else {
                temperature = round(tempResult - 273.15)
            }
            
            print(temperature)
            self.temperature.text = "\(temperature)°"
            self.temperature.font = UIFont.boldSystemFont(ofSize: 60)
            //self
            
            let name = jsonResult["name"] as! String
            self.location.font = UIFont.boldSystemFont(ofSize: 25)
            print("name: ")
            print(name)
            self.location.text = "\(name)"
            
            var condition:Int = 1
            condition = ((jsonResult["weather"] as! NSArray)[0] as! NSDictionary)["id"] as! Int
            let sunrise = (jsonResult["sys"] as! NSDictionary)["sunrise"] as? Double
            let sunset = (jsonResult["sys"] as! NSDictionary)["sunset"] as? Double
            
            var nightTime = false
            let now = NSDate().timeIntervalSince1970
            //精确到秒
            let nowSecond = Double(round(now))
            var sunriseDouble:Double = 0.0
            if(sunrise != nil) {
                sunriseDouble = sunrise!
            }
            
            var sunsetDouble:Double = 0.0
            if(sunset != nil) {
                sunsetDouble = sunset!
            }
            
            if(nowSecond < sunriseDouble || nowSecond > sunsetDouble) {
                nightTime = true
            }
            
            print(condition)
            print(nightTime)
            self.updateWeatherIcon(condition: condition, nightTime: nightTime)
        } else {
            self.loading.text = "天气信息不可用"
        }
    }
    
    func updateWeatherIcon(condition: Int, nightTime: Bool) {
        if(condition < 300) {
            if(nightTime) {
                self.icon.image = UIImage(named: "tstorm1_night")
            } else {
                self.icon.image = UIImage(named: "tstorm1")
            }
        }
            // Drizzle
        else if (condition < 500) {
            self.icon.image = UIImage(named: "light_rain")
            
        }
            // Rain / Freezing rain / Shower rain
        else if (condition < 600) {
            
            self.icon.image = UIImage(named: "shower3")
        }
            // Snow
        else if (condition < 700) {
            self.icon.image = UIImage(named: "snow4")
        }
            // Fog / Mist / Haze / etc.
        else if (condition < 771) {
            if nightTime {
                self.icon.image = UIImage(named: "fog_night")
            } else {
                self.icon.image = UIImage(named: "fog")
            }
        }
            // Tornado / Squalls
        else if (condition < 800) {
            self.icon.image = UIImage(named: "tstorm3")
        }
            // Sky is clear
        else if (condition == 800) {
            if (nightTime){
                self.icon.image = UIImage(named: "sunny_night")
            }
            else {
                self.icon.image = UIImage(named: "sunny")
            }
        }
            // few / scattered / broken clouds
        else if (condition < 804) {
            if (nightTime){
                self.icon.image = UIImage(named: "cloudy2_night")
            }
            else{
                self.icon.image = UIImage(named: "cloudy2")
            }
        }
            // overcast clouds
        else if (condition == 804) {
            self.icon.image = UIImage(named: "overcast")
        }
            // Extreme
        else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
            
            self.icon.image = UIImage(named: "tstorm3")
        }
            // Cold
        else if (condition == 903) {
            self.icon.image = UIImage(named: "snow5")
        }
            // Hot
        else if (condition == 904) {
            self.icon.image = UIImage(named: "sunny")
        }
            // Weather condition is not available
        else {
            self.icon.image = UIImage(named: "dunno")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError")
        print(error)
        self.loading.text = "地理信息不可用"
    }
    
}

