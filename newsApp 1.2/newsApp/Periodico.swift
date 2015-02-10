//
//  TipoPeriodico.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import Foundation

enum Periodico: Int  {
    case ElPais=0, ElMundo, ABC
    
    static func totalPeriodicos () -> Int {
        return 3
    }
    
    func url () -> String {
        switch self {
        case .ElPais:
            return "http://www.elpais.es"
        case .ElMundo:
            return "http://www.elmundo.es"
        case .ABC:
            return "http://www.abc.es"
        }
    }
    
    func nombre()->String {
        switch self {
        case .ElPais:
            return "El País"
        case .ElMundo:
            return "El Mundo"
        case .ABC:
            return "ABC"
        }
        
    }
}