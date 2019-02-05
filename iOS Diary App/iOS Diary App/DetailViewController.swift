//
//  DetailViewController.swift
//  iOS Diary App
//
//  Created by Woodchuck on 12/8/18.
//  Copyright © 2018 Treehouse Island. All rights reserved.
//

import UIKit
import CoreData


class DetailViewController: UIViewController {

    
    var item: Item?
    var context: NSManagedObjectContext!
    

    @IBOutlet weak var detailTextField: UITextField!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            detailTextField.text = item.text
            timeStampLabel.text = item.date
            locationLabel.text = item.location
        }
        
        
    }
    
    
    @IBAction func deleteDiaryEntryButton(_ sender: Any) {
        if let item = item {
            context.delete(item)
            context.saveChanges()
            navigationController?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    @IBAction func saveDiaryEntryButton(_ sender: Any) {
        
        if let item = item, let newText = detailTextField.text {
            item.text = newText
            item.date = "Updated on \(Item.createTimeStamp())"
            context.saveChanges()
            navigationController?.navigationController?.popViewController(animated: true)
        }
    }
    

}

