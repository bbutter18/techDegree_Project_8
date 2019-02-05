//
//  iOS_Diary_AppTests.swift
//  iOS Diary AppTests
//
//  Created by user on 2/5/19.
//  Copyright © 2019 Treehouse Island. All rights reserved.
//

import CoreData
import XCTest
@testable import iOS_Diary_App


class iOS_Diary_AppTests: XCTestCase {
    
    var context = CoreDataStack().managedObjectContext
    
    
    func testCreateDiaryEntry() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else { return }
        
        item.text = "TestDiaryEntryCreation"
        item.date = "Tuesday, February 5"
        item.location = "In a Galaxy Far Far Away"
        item.mood = "happy"
        context.saveChanges()
        
        do {
            
            let request = NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            
            XCTAssertTrue(result.contains(item))
        } catch {
            print(error)
        }
    }
    
    func testDeleteDiaryEntry() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else { return }

        item.text = "TestDiaryEntryDeletion"
        item.date = "Tuesday, February 5"
        item.location = "In a Galaxy Far Far Away"
        item.mood = "happy"
        context.saveChanges()
        
        context.delete(item)
        context.saveChanges()
        
        do {
            
            let request = NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            
            XCTAssertFalse(result.contains(item))
        } catch {
            print(error)
        }
    
    }
    
    
    func testEditingDiaryEntry() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else { return }
        
        item.text = "TestDiaryEntryEditing"
        item.date = "Tuesday, February 5"
        item.location = "In a Galaxy Far Far Away"
        item.mood = "happy"
        context.saveChanges()
        
        item.text = "The new edited text is inserted into the diary entry"
        context.saveChanges()
        
        do {
            
            let request = NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            
            XCTAssertTrue(result.contains{ $0.text == "The new edited text is inserted into the diary entry"})
        } catch {
            print(error)
        }
        
    }
        
    
    
    
    
    
    
}
