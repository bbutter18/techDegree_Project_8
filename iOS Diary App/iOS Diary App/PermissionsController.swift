//
//  PermissionsController.swift
//  iOS Diary App
//
//  Created by Woodchuck on 1/28/19.
//  Copyright © 2019 Treehouse Island. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit



class PermissionsController: UIViewController, LocationPermissionsDelegate {


    lazy var locationManager: LocationManager = {
        return LocationManager(permissionsDelegate: self, delegate: nil)
    }()
    
    func requestLocationPermission() {
        do {
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            
        } catch let error {
            print("Location Authorization Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: Location Permission Delegate
    func authorizationSucceeded() {
        print("User Location Access Granted")
    }
    
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus) {
        print("User Location Access Denied")
    }









}
