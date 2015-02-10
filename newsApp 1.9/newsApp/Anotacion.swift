//
//  Anotacion.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 2/2/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import Foundation
import MapKit

class Anotacion: NSObject, MKAnnotation {
    
    var coordinate:CLLocationCoordinate2D 
    var title: String {return "Mi casa"}
    var subtitle: String {
        return NSString(format: "Coordenadas: %0.5f, %0.5f", coordinate.latitude, coordinate.longitude)
    }
    
    init(coordenada:CLLocationCoordinate2D){
        self.coordinate = coordenada
    }
}
