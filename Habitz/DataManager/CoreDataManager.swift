//
//  CoreDataManager.swift
//  Habitz
//
//  Created by Sam on 2021-05-04.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Habitz")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("LOG: Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?) -> () = {_ in}){
        let context = container.viewContext
        if context.hasChanges{
            do {
                try context.save()
                completion(nil)
            } catch {
                print("LOG: Changes were unsuccessfully saved.\n")
                print("LOG: Error: \(error)")
                return
            }
        }
        print("LOG: Changes were successfully saved.")
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}){
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
}

