//
//  TipoPeriodico.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import Foundation

enum TipoPeriodico: Int {
    case Generalista=0, Deportivo
    
    func nombre() -> String {
        switch self{
        case .Generalista:
            return "Generalista"
        case .Deportivo:
            return "Deportivo"
        }
    }
    
    static func totalTiposPeriodico() -> Int{
        return 2
    }
}

enum Periodico  {
    case ElPais,ElMundo, ABC    // periódicos generalistas
    case Marca, As              // periódicos deportivos
    
    init? (tipo: TipoPeriodico, periodico : Int) {
        switch tipo {
        case .Deportivo:
            if (periodico == 0) {
                self = .Marca
            }
            else if (periodico == 1) {
                self = .As
            }
            else{
                return nil
            }
        case .Generalista:
            if (periodico == 0) {
                self = .ElPais
            }
            else if (periodico == 1) {
                self = .ElMundo
            }
            else if (periodico == 2) {
                self = .ABC
            }
            else{
                return nil
            }
        }
    }
    
    func url () -> String {
        switch self {
        case .ElPais:
            return "http://www.elpais.es"
        case .ElMundo:
            return "http://www.elmundo.es"
        case .ABC:
            return "http://www.abc.es"
        case .Marca:
            return "http://www.marca.com"
        case .As:
            return "http://www.as.com"
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
        case .Marca:
            return "Marca"
        case .As:
            return "AS"
        }
    }
    
    static func totalPeriodicos (tipoPeriodico : TipoPeriodico) -> Int {
        switch tipoPeriodico {
        case .Deportivo:
            return 2
        case .Generalista:
            return 3
        }
    }
    static func totalPeriodicos () -> Int {
        return Periodico.totalPeriodicos(TipoPeriodico.Generalista) + Periodico.totalPeriodicos(TipoPeriodico.Deportivo)
    }
}

