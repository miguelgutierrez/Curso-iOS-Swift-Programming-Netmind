//
//  Articulo.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 2/2/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import Foundation
import CoreData

@objc(Articulo)

class Articulo: NSManagedObject {

    // MARK: properties
    @NSManaged var fecha: NSDate
    @NSManaged var nombre: String
    @NSManaged var texto: String

    // MARK: métodos de ayuda
    class func entityName() -> String {
        return "Articulo"
    }
    
    class func articulos() -> [Articulo]? {
        let request = NSFetchRequest()
        let model = StoreNewsApp.defaultStore().model
        
        let entidad = model.entitiesByName[Articulo.entityName()]
        request.entity = entidad
        
        let sd = NSSortDescriptor(key: "nombre", ascending: true)
        request.sortDescriptors = [sd]
        
        let context = StoreNewsApp.defaultStore().context
        
        let result: [AnyObject]?
        do {
            result = try context.executeFetchRequest(request)
            return result as? [Articulo]
        } catch let error as NSError {
            NSException.raise(MensajesErrorCoreData.fetchFailed, format: MensajesErrorCoreData.errorFetchObjectFormat, arguments:getVaList([error]))
            return nil
        }
    }

}
