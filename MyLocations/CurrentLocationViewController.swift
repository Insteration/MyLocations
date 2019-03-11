//
//  FirstViewController.swift
//  MyLocations
//
//  Created by Artem Karmaz on 3/5/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLocationViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var location: CLLocation? // add user location to this variable
    var updatingLocation = false
    var lastLocationError: Error?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    //MARK:- Actions
    
    @IBAction func getLocation() {
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        
        //        locationManager.delegate = self
        
        startLocationManager()
        updateLabels()
        //        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //        locationManager.startUpdatingLocation()
    }
    
    
}

extension CurrentLocationViewController: CLLocationManagerDelegate {
    
    // MARK:- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error.localizedDescription)")
        
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        lastLocationError = error
        stopLocationManager()
        updateLabels()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        
        // 1
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        // 2
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
        // 3
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            lastLocationError = nil
            location = newLocation
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We're done!")
                stopLocationManager()
            }
            updateLabels()
        }
    }
    
    func updateLabels() {
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            
            tagButton.isHidden = false
            messageLabel.text = ""
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.isHidden = true
            //            messageLabel.text = "Tap 'Get My Location to Start'"
            
            let statusMesage: String
            if let error = lastLocationError as NSError? {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMesage = "Location Service Disabled"
                } else {
                    statusMesage = "Error Getting Location"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMesage = "Location Services Disabled"
            } else if updatingLocation {
                statusMesage = "Searching..."
            } else {
                statusMesage = "Tap 'Get My Location to Start'"
            }
            messageLabel.text = statusMesage
        }
        configureGetButton()
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func configureGetButton() {
        if updatingLocation {
            getButton.setTitle("Stop", for: .normal)
        } else {
            getButton.setTitle("Get My Location", for: .normal)
        }
    }
}

extension CurrentLocationViewController {
    
    //MARK:- Helper Methods
    
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "Location Services Disabled",
                                      message: "Please enable location services for this app in Settings.",
                                      preferredStyle: .alert
        )
        
        let okActions = UIAlertAction(title: "OK",
                                      style: .default)
        
        alert.addAction(okActions)
        
        present(alert, animated: true, completion: nil)
    }
}
