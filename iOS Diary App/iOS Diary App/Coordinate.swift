//
//  Coordinate.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/8/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import CoreLocation


struct Coordinate {
    let latitude: Double
    let longitude: Double
}


extension Coordinate {
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}





