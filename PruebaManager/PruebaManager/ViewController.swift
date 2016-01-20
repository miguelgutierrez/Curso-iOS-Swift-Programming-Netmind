//
//  ViewController.swift
//  PruebaManager
//
//  Created by MGM on 11/12/15.
//  Copyright © 2015 MGM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // datos
    static let fichero = "/prueba.txt"
    
    @IBOutlet weak var textEntradaView: UITextView!
    @IBOutlet weak var textSalidaTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onProceso1(sender: AnyObject) {
        FilesManager.sharedInstance.cargaFicheroAsyncDesde(TipoDirectorio.Tmp, subdirectorio: nil, fichero: ViewController.fichero) { (datos:String?) -> () in

            if let _=datos{
                self.graba()
            }
            else{
                FilesManager.sharedInstance.grabaAsync(datosStr: "hora: \(NSDate())", enTipo: TipoDirectorio.Tmp, subdirectorio: nil, fichero: ViewController.fichero, handler: { (resultado:Bool) -> () in
                    if resultado {
                        self.graba()
                    }
                })
            }
            
        }

    }
    
    @IBAction func onProceso2(sender: AnyObject) {
        lee()
    }

    func graba(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            var contenidoFichero = ""
            FilesManager.sharedInstance.cargaFicheroAsyncDesde(TipoDirectorio.Tmp, subdirectorio: nil, fichero: ViewController.fichero, handler: { (datos:String?) -> () in
                if let datos = datos {
                    contenidoFichero += datos
                    contenidoFichero += self.textEntradaView.text + "hora: \(NSDate())"
                    if let data = contenidoFichero.dataUsingEncoding(NSUTF8StringEncoding){
                        FilesManager.sharedInstance.grabaAsync(data: data, enTipo: TipoDirectorio.Tmp, directory: nil, fichero: ViewController.fichero, handler: { (resultado: Bool) -> () in
                            NSLog("grabado %i", resultado)
                        })
                        
                    }
                }
            })
        }
    }
    
    func lee(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
            FilesManager.sharedInstance.cargaFicheroAsyncDesde(TipoDirectorio.Tmp, subdirectorio: nil, fichero: ViewController.fichero, handler: { (datos:String?) -> () in
                if let datos = datos{
                    self.textSalidaTextView.text = datos
                    NSLog("datos leídos: %@", datos)
                }
            })
            
        }
    }
}

