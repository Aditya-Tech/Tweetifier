//
//  CoreDataHelper.swift
//  Tweetifier
//
//  Created by Aditya Paruchuri on 1/7/17.
//  Copyright © 2017 Aditya Paruchuri. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Your Model File Name")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    
    
    
    
    
    
}



