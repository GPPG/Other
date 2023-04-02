//
//  LocationViewController.swift
//  CustomFont
//
//  Created by 郭鹏 on 2019/5/29.
//  Copyright © 2019 郭鹏. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {

    let locationManger = CLLocationManager()
    let geocoder = CLGeocoder()
    let locationLabel = UILabel()
    let locationStrLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image = UIImage(named: "phoneBg")
        self.view.addSubview(bgImageView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        
        locationManger.delegate = self
        
        locationLabel.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 100)
        locationLabel.textAlignment = .center
        locationLabel.textColor = UIColor.white
        self.view.addSubview(locationLabel)
        
        locationStrLabel.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 50)
        locationStrLabel.textAlignment = .center
        locationStrLabel.textColor = UIColor.white
        self.view.addSubview(locationStrLabel)
        
        let findMyLocationBtn = UIButton(type: UIButton.ButtonType.custom)
        findMyLocationBtn.frame = CGRect(x: 50, y: self.view.bounds.height - 80, width: self.view.bounds.width - 100, height: 50)
        findMyLocationBtn.setTitle("Find My Position", for: UIControl.State.normal)
        findMyLocationBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        findMyLocationBtn.addTarget(self, action: #selector(findMyLocation), for: UIControl.Event.touchUpInside)
        self.view.addSubview(findMyLocationBtn)
    }
    
}

extension LocationViewController{
    @objc func findMyLocation(){
        locationManger.requestAlwaysAuthorization()
        locationManger.startUpdatingLocation()
    }
    
}


extension LocationViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locations : NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat:\(currentLocation.coordinate.latitude) lng:\(currentLocation.coordinate.longitude)"
        locationLabel.text = locationStr
        reverseGeocode(location:currentLocation)
        locationManger.stopUpdatingLocation()        
    }
    
    
    ///将经纬度转换为城市名
    func reverseGeocode(location:CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if(error == nil) {
                let tempArray = placeMark! as NSArray
                let mark = tempArray.firstObject as! CLPlacemark
                //                now begins the reverse geocode
                let addressDictionary = mark.addressDictionary! as NSDictionary
                let country = addressDictionary.value(forKey: "Country") as! String
                let city = addressDictionary.object(forKey: "City") as! String
                let street = addressDictionary.object(forKey: "Street") as! String
                
                let finalAddress = "\(street),\(city),\(country)"
                self.locationStrLabel.text = finalAddress
                
            }
        }
    }
    
    
}
