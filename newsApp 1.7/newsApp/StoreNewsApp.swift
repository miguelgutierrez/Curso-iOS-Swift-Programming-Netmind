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
        let storeURL = NSURL(fileURLWithPath: StoreNewsApp.myNewsAppArchivePath())
        var error : NSError?
        
        if psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil, error: &error) == nil {
            NSException.raise(MensajesErrorCoreData.exceptionRaise, format: MensajesErrorCoreData.exceptionFormat, arguments:getVaList([error!]))
        }
        
        context = NSManagedObjectContext()
        context?.persistentStoreCoordinator = psc
    }
    // MARK: métodos
    func graba() -> Bool {
        var error : NSError?
        let succesful = context.save(&error)
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
    class func myNewsAppArchivePath() -> String {
        let documentDirectories = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        let documentDirectory = documentDirectories[0] as String
        return documentDirectory.stringByAppendingPathComponent("myNewsApp.sqlite")
    }
    
    
}

