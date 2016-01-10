//
//  ContactoViewController.swift
//  MiprimeraApp
//
//  Created by Miguel Gutiérrez Moreno on 11/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class ContactoViewController: UIViewController {

    @IBOutlet weak var saludoLabel: UILabel!
    @IBOutlet weak var fechaYHoraLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //saluda("Hola a todos,", de: "Miguel", esPorLaTarde: false)
        saluda("Hola a todos", de: "Miguel")
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
            mañanaOTarde="Buenos días";
        }
        else if(hour >= 12 && hour < 19){
            mañanaOTarde="Buenas tardes";
        }
        else if(hour >= 19){
            mañanaOTarde="Buenas noches";
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
