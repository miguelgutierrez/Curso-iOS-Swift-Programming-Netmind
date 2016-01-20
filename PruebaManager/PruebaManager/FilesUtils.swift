//
//  Utils.swift
//  PruebaManager
//
//  Created by MGM on 11/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

import Foundation

enum TipoDirectorio{
    case Bundle
    case Documents
    case Tmp
}
//MARK: lectura ficheros  (la escritura: NSData.writeToFile)
func pathFicheroEn(tipo:TipoDirectorio,subdirectorio:String?,fichero:String)->String?{
    var path:String?
    switch (tipo){
    case .Bundle:
        if let subdirectorio = subdirectorio {
            path = NSBundle.mainBundle().pathForResource(subdirectorio, ofType: nil)
            path = path?.stringByAppendingString(fichero)
        }
        else{
            path = NSBundle.mainBundle().pathForResource(fichero, ofType: nil)
        }
        
    case .Documents:
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        path = dirs[0] // documents directory, si no existe es que hay un problema grabe con el dispositivo
        
        if let subdirectorio = subdirectorio{
            path = path!+subdirectorio
        }
        path = path! + fichero

    case .Tmp:
        path = NSTemporaryDirectory() // si no existe es que hay un problema grabe con el dispositivo
        if let directory = subdirectorio{
            // TODO pendiente if directory.length
            path = path!+directory
        }
        path = path!+fichero

    }
    return path
}
func existeFicheroEn(tipo:TipoDirectorio,subdirectorio:String?,fichero:String)->Bool{
    if let path = pathFicheroEn(tipo,subdirectorio: subdirectorio, fichero: fichero){
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    else{
        return false
    }
    
}
func cargaFicheroToDataDesde(tipo:TipoDirectorio,subdirectorio:String?,fichero:String)->NSData?{
    if let path = pathFicheroEn(tipo, subdirectorio: subdirectorio, fichero: fichero){
        return cargaFicheroDePathToData(path: path)
    }
    else{
        return nil
    }
}
func cargaFicheroDesde(tipo:TipoDirectorio,subdirectorio:String?,fichero:String)->String?{
    if let data = cargaFicheroToDataDesde(tipo, subdirectorio: subdirectorio, fichero: fichero){
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
    else{
        return nil
        
    }
}
func cargaFicheroDePathToData(path path:String)->NSData?{
    if NSFileManager.defaultManager().fileExistsAtPath(path){
        return NSData(contentsOfFile: path)
    }
    else{
        return nil;
    }
}

/*
func pathFicheroEnDocuments(directory directory:String?,fichero:String)->String?{
    let dirs : [String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
    var path = dirs[0] // documents directory
    
    if let directory = directory{
        // TODO pendiente if directory.length
        path = path+directory
    }
    return path+fichero

}
func pathFicheroEnTmp(directory directory:String?,fichero:String)->String?{
    var path = NSTemporaryDirectory()
    if let directory = directory{
        // TODO pendiente if directory.length
        path = path+directory
    }
    return path+fichero
    
}
func pathFicheroEnBundle(directory directory:String?,fichero:String)->String?{
    var path : String?
    if let directory = directory{
        // TODO pendiente if directory.length
        path = NSBundle.mainBundle().pathForResource(directory, ofType: nil)
        path = path?.stringByAppendingString(fichero)
    }
    else{
        path = NSBundle.mainBundle().pathForResource(fichero, ofType: nil)
    }

    return path
}
*/

/*
func existeFicheroEnBundle(directory directory:String?,fichero:String)->Bool{
    if let path = pathFicheroEnBundle(directory: directory, fichero: fichero){
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    else{
        return false
    }
}
func existeFicheroEnDocuments(directory directory:String?,fichero:String)->Bool{
    if let path = pathFicheroEnDocuments(directory: directory, fichero: fichero){
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    else{
        return false
    }
}
func existeFicheroEnTmp(directory directory:String?,fichero:String)->Bool{
    if let path = pathFicheroEnTmp(directory: directory, fichero: fichero){
        return NSFileManager.defaultManager().fileExistsAtPath(path)
    }
    else{
        return false
    }
}
*/

/*
func cargaFicheroDeBundleToData(directory directory:String?,fichero:String)->NSData?{
    if let path = pathFicheroEnBundle(directory: directory, fichero: fichero){
        return cargaFicheroDePathToData(path: path)
    }
    else{
        return nil
    }
}
func cargaFicheroDeDocumentsToData(directory directory:String?,fichero:String)->NSData?{
    
    if let path =  pathFicheroEnDocuments(directory: directory, fichero: fichero){
        return cargaFicheroDePathToData(path:path)
    }
    else{
        return nil
    }
    
}
*/

/*
func cargaFicheroDeBundle(directory directory:String?,fichero:String)->String?{
    if let data = cargaFicheroDeBundleToData(directory: directory, fichero: fichero){
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
    else{
        return nil
        
    }
}
func cargaFicheroDeDocuments(directory directory:String?,fichero:String)->String?{
    if let data = cargaFicheroDeDocumentsToData(directory: directory, fichero: fichero){
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
    else{
        return nil
    }
}
*/
// MARK: escritura de ficheros

