//
//  DataSource.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/12/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//


//CHECKED OFF LIST
import Foundation
import UIKit
import CoreData



class DataSource: NSObject, UITableViewDataSource {

    private let tableView: UITableView
    private let context: NSManagedObjectContext
    var diaryWillDelete: ((IndexPath) -> Void)?
    
    lazy var fetchedResultsController: DiaryFetchedResultsController = {
        return DiaryFetchedResultsController(managedObjectContext: self.context, tableView: self.tableView)
    }()
    
    func object(at indexPath: IndexPath) -> Item {
        return fetchedResultsController.object(at: indexPath)
    }
    
    init(tableView: UITableView, context: NSManagedObjectContext) {
        self.tableView = tableView
        self.context = context
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! DiaryCell
        
        
        return configureCell(cell, at: indexPath)
        
    }
    //swipe to delete method
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    
    
    
    private func configureCell(_ cell: DiaryCell, at indexPath: IndexPath) -> UITableViewCell {
        
        let item = fetchedResultsController.object(at: indexPath)
        cell.diaryEntryText.text = item.text
        cell.diaryTimeStampLabel.text = item.date
        
        if let mood = item.mood {
            switch mood {
            case "good": cell.moodIconImage.image = UIImage(named: "icn_happy")
            case "average": cell.moodIconImage.image = UIImage(named: "icn_average")
            case "bad": cell.moodIconImage.image = UIImage(named: "icn_bad")
            default:
                cell.moodIconImage.image = UIImage(named: "icn_noimage")
                break
            }
            
        }
        
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 160
//    }

}
