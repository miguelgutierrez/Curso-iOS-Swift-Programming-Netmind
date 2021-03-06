//
//  Articulo.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 19/1/16.
//  Copyright © 2016 MGM. All rights reserved.
//

import Foundation
import CoreData

@objc(Articulo)
class Articulo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    func inicializaValores(){
        nombre = ""
        fecha = NSDate()
        texto = ""
        
    }
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
    class func articulosAnterioresA(fecha:NSDate) -> [Articulo]? {
        let request = NSFetchRequest()
        let model = StoreNewsApp.defaultStore().model
        
        let entidad = model.entitiesByName[Articulo.entityName()]
        request.entity = entidad
        
        let sd = NSSortDescriptor(key: "nombre", ascending: true)
        request.sortDescriptors = [sd]
        
        let context = StoreNewsApp.defaultStore().context
        
        request.predicate = NSPredicate(format: "fecha <= %@", fecha)
        
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
