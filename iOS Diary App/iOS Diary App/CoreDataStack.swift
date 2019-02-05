//
//  CoreDataStack.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/11/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

//CHECKED OFF LIST

import Foundation
import CoreData

class CoreDataStack {

lazy var managedObjectContext: NSManagedObjectContext = {
    let container = self.persistentContainer
    return container.viewContext
}()


private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "iOS_Diary_App")
    
    container.loadPersistentStores() { storeDescription, error in
        
        //so we'll check if the error object exists and attempt to cast that to NSError.
        if let error = error as NSError? {
            fatalError("Unresolved Error: \(error), \(error.userInfo)")
        }
    }
    
        return container
    }()
}



extension NSManagedObjectContext {
    func saveChanges() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}

