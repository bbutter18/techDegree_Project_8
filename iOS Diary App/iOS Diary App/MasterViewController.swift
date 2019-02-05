//
//  MasterViewController.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/8/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//



import UIKit
import CoreData

class MasterViewController: UITableViewController {
    
   
    let managedObjectContext = CoreDataStack().managedObjectContext
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView, context: self.managedObjectContext)
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 160.0
        
    }
    
    
    //MARK: Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newItem" {
            let navigationController = segue.destination as! UINavigationController

            let addDiaryEntryController = navigationController.topViewController as! DiaryEditController
            
            addDiaryEntryController.managedObjectContext = self.managedObjectContext
            
        } else if segue.identifier == "showDetail" {
            guard let detailVC = (segue.destination as! UINavigationController).topViewController as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            let item = dataSource.object(at: indexPath)
            detailVC.item = item
            detailVC.context = self.managedObjectContext
        }
    }
    
    
    
    
}

