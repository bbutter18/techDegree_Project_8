//
//  DiaryEditController.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/19/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//


import Foundation
import UIKit
import CoreData
import CoreLocation





class DiaryEditController: UIViewController {

    
    var managedObjectContext: NSManagedObjectContext!
    
    let permissionController = PermissionsController()
    
    lazy var locationManager: LocationManager = {
        return LocationManager(permissionsDelegate: nil, delegate: self)
    }()

    var coordinate: String?
    var mood: String?
    
    
    @IBOutlet weak var diaryInputTextField: UITextField!

    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var moodLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeStampLabel.text = Item.createTimeStamp()
        
        print("AddTaskController Context: \(managedObjectContext.description)")
    }
    
    
    @IBAction func goodMoodButton(_ sender: Any) {
        moodLabel.text = "mood is good"
        mood = "good"
    }
    
    
    @IBAction func averageMoodButton(_ sender: Any) {
        moodLabel.text = "mood is average"
        mood = "average"
    }
    
    
    @IBAction func badMoodButton(_ sender: Any) {
        moodLabel.text = "mood is bad"
        mood = "bad"
    }
    
    
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print("AddTaskController Context: \(managedObjectContext.description)")
        
    }
    
    
    
    
    
    @IBAction func save(_ sender: Any) {
        guard let text = diaryInputTextField.text, !text.isEmpty else { return }
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjectContext) as! Item
        
        item.text = text
        item.date = "Created on \(Item.createTimeStamp())"
        item.location = coordinate
        item.mood = mood
        
        managedObjectContext.saveChanges()
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func RequestLocationButton(_ sender: Any) {
        permissionController.requestLocationPermission()
        locationManager.requestLocation()
        
    }
    
}


extension DiaryEditController: LocationManagerDelegate {
    func obtainedCoordinates(_ coordinate: String) {
        
        self.coordinate = coordinate
        print(coordinate)
    }
    
    func failedWithError(_ error: LocationError) {
        print("Error:\(error)")
    }
}
    


