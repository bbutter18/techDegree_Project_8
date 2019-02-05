//
//  Item+CoreDataClass.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/17/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import Foundation
import CoreData

public class Item: NSManagedObject {

    @NSManaged public var text: String?

    @NSManaged public var date: String
    
    @NSManaged public var location: String?
    
    @NSManaged public var mood: String?
}
