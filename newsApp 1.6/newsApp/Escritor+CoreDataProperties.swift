//
//  Escritor+CoreDataProperties.swift
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

extension Escritor {

    @NSManaged var nombre: String?
    @NSManaged var fechaNacimiento: NSDate?
    @NSManaged var escribe: NSSet?

}
