//
//  LocationManager.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/13/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


enum LocationError: Error {
    case unknownError
    case disallowedByUser
    case unableToFindLocation
}

protocol LocationPermissionsDelegate: class {
    func authorizationSucceeded()
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus)
}



protocol LocationManagerDelegate: class {
    func obtainedCoordinates(_ coordinate: String)
  
    func failedWithError(_ error: LocationError)
}



class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    weak var permissionsDelegate: LocationPermissionsDelegate?
    
    weak var delegate: LocationManagerDelegate?
    
    
    init(permissionsDelegate: LocationPermissionsDelegate?, delegate: LocationManagerDelegate?) {
        self.permissionsDelegate = permissionsDelegate
        self.delegate = delegate
        super.init()
        
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

func requestLocationAuthorization() throws {
    
    let authorizationStatus = CLLocationManager.authorizationStatus()
    
    if authorizationStatus == .restricted || authorizationStatus == .denied {
        
        throw LocationError.disallowedByUser
    
    } else if authorizationStatus == .notDetermined {
        
        manager.requestWhenInUseAuthorization()
    
    } else {
        
        return
    }
}




func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    if status == .authorizedWhenInUse {
        permissionsDelegate?.authorizationSucceeded()
    } else {
        permissionsDelegate?.authorizationFailedWithStatus(status)
    }
}


func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    
    guard let error = error as? CLError else {
        delegate?.failedWithError(.unknownError)
        return
    }
    
    switch error.code {
    case .locationUnknown, .network: delegate?.failedWithError(.unableToFindLocation)
    case .denied: delegate?.failedWithError(.disallowedByUser)
    default: return
        
    }
}

func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    guard let location = locations.last else {
        delegate?.failedWithError(.unableToFindLocation)
        return
    }
    
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { (placemark, error) in
        if let placemark = placemark {
            var stringLocation = ""
            let info = placemark[0]
            if let name = info.name, let city = info.locality, let countryCode = info.isoCountryCode {
                
                stringLocation = "\(name), \(city), \(countryCode)"
                
                self.delegate?.obtainedCoordinates(stringLocation)
            }
        }
        
        
    }
    
    
}
    
    
    
    
    
    //end

}





















