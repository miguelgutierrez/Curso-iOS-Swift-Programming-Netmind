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
        
        let entidad = model.entitiesByName[Articulo.entityName()] as NSEntityDescription
        request.entity = entidad
        
        let sd = NSSortDescriptor(key: "nombre", ascending: true)
        request.sortDescriptors = [sd]
        
        let context = StoreNewsApp.defaultStore().context

        var error : NSError?
        
        let result = context.executeFetchRequest(request, error: &error)
        
        if result == nil {
            NSException.raise(MensajesErrorCoreData.fetchFailed, format: MensajesErrorCoreData.errorFetchObjectFormat, arguments:getVaList([error!]))
            return nil
        }
        else {
            return result as? [Articulo]
        }
    }

}
