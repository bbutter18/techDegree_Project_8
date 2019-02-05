//
//  Item+CoreDataProperties.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        
        //Here, we've created a single instance of a sort descriptor, takes a string describing the attribute on which to sort, and a boolean value for ascending, that looks good for the fetch request.
        let request = NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)] //an array of sortdescriptor
        return request
    
    }

    
    
}


    extension Item {
        static func createTimeStamp() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            let convertedDate = dateFormatter.string(from: Date())
            return convertedDate
        }
        
    }


