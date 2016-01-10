//
//  ContactoViewController.swift
//  MiprimeraApp
//
//  Created by Miguel Gutiérrez Moreno on 11/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
//  * No pasa al estado "suspended"
//  * Al pulsar el botón ACTUAL:
//      - cambia la hora automáticamente cada sg.

import UIKit

class ContactoViewController: UIViewController {

    @IBOutlet weak var saludoLabel: UILabel!
    @IBOutlet weak var fechaYHoraLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        UIApplication.sharedApplication().idleTimerDisabled=true // tener en cuenta el uso de la batería
        
        //saluda("Hola a todos,", de: "Miguel", esPorLaTarde: false)
        saluda("Hola a todos", de: "Miguel")
        
       NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("muestraFechaYHora:"), userInfo: nil, repeats: true)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    func saluda(saludo:String, de:String, esPorLaTarde:Bool){
        var mañanaOTarde=""
        if esPorLaTarde {
            mañanaOTarde = "buenas tardes"
        }
        else{
            mañanaOTarde = "buenos días"
        }
        
        saludoLabel.text = saludo+" "+mañanaOTarde+" de parte de "+de;
        
    }

    func saluda(saludo:String, de:String){
        
        let calendar = NSCalendar.currentCalendar()

        let components = calendar.components(.Hour, fromDate: NSDate())
        let hour = components.hour

        var mañanaOTarde=""
        
        if(hour >= 0 && hour < 12){
            mañanaOTarde="buenos días";
        }
        else if(hour >= 12 && hour < 19){
            mañanaOTarde="buenas tardes";
        }
        else if(hour >= 19){
            mañanaOTarde="buenas noches";
        }
        let cadena = saludo+" "+mañanaOTarde+" de parte de "+de
        
        saludoLabel.text=cadena;
        
    }
    
    @IBAction func muestraFechaYHora(sender: UIButton) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
        
        fechaYHoraLabel.text=dateFormatter.stringFromDate(NSDate())
        
    }

}
