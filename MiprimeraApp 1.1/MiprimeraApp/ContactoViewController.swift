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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        saluda("Hola a todos,", de: "Miguel", esPorLaTarde: false)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
