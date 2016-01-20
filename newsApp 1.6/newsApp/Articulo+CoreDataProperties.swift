//
//  Articulo+CoreDataProperties.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 19/1/16.
//  Copyright © 2016 MGM. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Articulo {

    @NSManaged var fecha: NSDate?
    @NSManaged var nombre: String?
    @NSManaged var texto: String?
    @NSManaged var descripcion: String?
    @NSManaged var escritoPor: NSManagedObject?

}
