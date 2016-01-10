//
//  Store.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 2/2/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import Foundation
import CoreData

struct MensajesErrorCoreData {

    static let exceptionRaise = "Open failed"
    static let fetchFailed = "Fetcj failed"
    static let exceptionFormat = "Reason: %@"
    static let errorCrearObjectFormat = "Error crear managed object context: %@"
    static let errorSaveObjectFormat = "Error crear managed object context: %@"
    static let errorFetchObjectFormat = "Failed to fetch with error = %@"
    static let errorSaveContextObjectFormat = "Failed to save the context with error = %@"

}

class StoreNewsApp {
    
    // singleton
    struct Static {
        static var instance : StoreNewsApp?
    }
    
    // MARK: properties
    let context : NSManagedObjectContext!
    let model : NSManagedObjectModel!
    
    // MARK: inicializador
    init() {
        
        model = NSManagedObjectModel.mergedModelFromBundles(nil)
        let psc = NSPersistentStoreCoordinator(managedObjectModel: model!)
        
        // Where does the SQLite file go?
        do {
            try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil,
                URL: StoreNewsApp.myNewsAppArchivePath(), options: nil)
        } catch let error1 as NSError {
            NSException.raise(MensajesErrorCoreData.exceptionRaise, format: MensajesErrorCoreData.exceptionFormat, arguments:getVaList([error1]))
        }
        
        context = NSManagedObjectContext()
        context?.persistentStoreCoordinator = psc
    }
    // MARK: métodos
    func graba() -> Bool {
        var error : NSError?
        let succesful: Bool
        do {
            try context.save()
            succesful = true
        } catch let error1 as NSError {
            error = error1
            succesful = false
        }
        if (error != nil) {
            NSLog("Error saving: \(error?.localizedDescription)")
        }
        return succesful
    }
    /*
    NSError *err = nil;
    BOOL successful = [_context save:&err];
    if (!successful) {
    NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
    }*/

    // MARK: métodos estáticos
    class func defaultStore() -> StoreNewsApp {
        
        if Static.instance == nil {
            Static.instance = StoreNewsApp()
        }
        
        return Static.instance!;
    }

    
    // nombre de la bbdd
    class func myNewsAppArchivePath() -> NSURL {
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL.URLByAppendingPathComponent("myNewsApp.sqlite")
    }
    
}

