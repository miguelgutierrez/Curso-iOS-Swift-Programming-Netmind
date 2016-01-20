//
//  FilesManager.swift
//  PruebaManager
//
//  Created by MGM on 11/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//
// Sigleton: http://stackoverflow.com/questions/24024549/dispatch-once-singleton-model-in-swift

import Foundation

let kBackgroundQueueName = "es.empresa.app"

class FilesManager {
    // MARK: declaraciones
    static let sharedInstance = FilesManager()

    let backgrounQueue : dispatch_queue_t
    
    // MARK: inicialización
    private init(){
        self.backgrounQueue = dispatch_queue_create(kBackgroundQueueName, DISPATCH_QUEUE_SERIAL) // si se quiere utilizar queue concurrentes se puede utilizar dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_xxx, 0)

    }
    // MARK: lectura
    func cargaFicheroAsyncDesde(tipo:TipoDirectorio,subdirectorio:String?, fichero:String, handler:(String? -> ())){
        dispatch_async(self.backgrounQueue) { () -> Void in
            
            NSLog("cargaFicheroDeBundleAsync - inicio: %@", NSThread.currentThread())
            //objc_sync_enter(self)
            let datos = cargaFicheroDesde(tipo, subdirectorio: subdirectorio, fichero: fichero)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                NSLog("cargaFicheroDeBundleAsync - fin: %@", NSThread.currentThread())
                handler(datos)
                })
        }
    }
    /*
    func cargaFicheroDeDocumentsAsync(subdirectorio subdirectorio:String?, fichero:String, handler:(String? -> ())){
        dispatch_async(self.backgrounQueue) { () -> Void in
            
            NSLog("cargaFicheroDeDocumentsAsync - inicio: %@", NSThread.currentThread())
            //objc_sync_enter(self)
            let datos = cargaFicheroDesde(TipoDirectorio.Documents, subdirectorio: subdirectorio, fichero: fichero)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                NSLog("cargaFicheroDeDocumentsAsync - fin: %@", NSThread.currentThread())
                handler(datos)
            })
        }
    }*/
    // MARK: escritura
    func grabaAsync(datosStr datosStr:String,enTipo:TipoDirectorio, subdirectorio:String?, fichero:String, handler:(Bool -> ())){
        if let data = datosStr.dataUsingEncoding(NSUTF8StringEncoding){
            grabaAsync(data: data, enTipo: TipoDirectorio.Tmp, directory: nil, fichero: fichero, handler: { (result: Bool) -> () in
                handler(result)
            })
        }
    }
    func grabaAsync(data data:NSData,enTipo:TipoDirectorio,directory:String?, fichero:String, handler:(Bool -> ())){
        dispatch_async(self.backgrounQueue) { () -> Void in
            NSLog("grabaAsync - inicio: %@", NSThread.currentThread())
            var result=false
            if let path = pathFicheroEn(enTipo, subdirectorio: directory, fichero: fichero){
                data.writeToFile(path, atomically: true)
                result=true
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                NSLog("grabaAsync - fin: %@", NSThread.currentThread())
                handler(result)
            })
        }
        
    }
    
/*
    
    func grabaEnDocumentsAsyn(string string:String,directory:String?, fichero:String, handler:(Bool -> ())){
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding){
            grabaEnDocumentsAsyn(data: data, directory: directory, fichero: fichero, handler: { (result: Bool) -> () in
                handler(result)
            })
        }
    }
    func grabaEnDocumentsAsyn(data data:NSData,directory:String?, fichero:String, handler:(Bool -> ())){
        dispatch_async(self.backgrounQueue) { () -> Void in
            NSLog("grabaEnDocumentsAsyn - inicio: %@", NSThread.currentThread())
            var result=false
            if let path = pathFicheroEn(TipoDirectorio.Documents, subdirectorio: directory, fichero: fichero){
                data.writeToFile(path, atomically: true)
                result=true
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                NSLog("grabaEnDocumentsAsyn - fin: %@", NSThread.currentThread())
                handler(result)
            })
        }
        
    }

    func grabaEnBundleAsyn(data data:NSData,directory:String?, fichero:String, handler:(Bool -> ())){
        dispatch_async(self.backgrounQueue) { () -> Void in
            NSLog("grabaEnBundleAsyn - inicio: %@", NSThread.currentThread())
            var result=false
            if let path = pathFicheroEn(TipoDirectorio.Bundle, subdirectorio: directory, fichero: fichero){
                data.writeToFile(path, atomically: true)
                result=true
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                NSLog("grabaEnBundleAsyn - fin: %@", NSThread.currentThread())
                handler(result)
            })
        }
        
    }
*/
    // MARK: funciones privadas
}