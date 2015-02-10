//
//  ImagenesViewController.swift
//  funnyApp
//
//  Created by Miguel Gutiérrez Moreno on 11/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class ImagenesViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var portadaImageView: UIImageView!
    
    // MARK: funciones derivadas
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: actions
    
    @IBAction func cambiaTrasparencia(sender: UISlider) {
        portadaImageView.alpha=CGFloat(sender.value)
    }
    /*
    Ejercicio:
        - desarrollar el control de recibir un nuevo action cuanto todavía se está ejecutando el animateWithDuration
    */
    @IBAction func cambiaVelocidad(sender: UIStepper) {
        NSLog("valor: \(sender.value)")
        let posicion=portadaImageView.center //CGPointMake(CGFloat(160), CGFloat(120))
        
        let tiempoDuracion = NSTimeInterval(sender.value)
        
        UIView.animateWithDuration(tiempoDuracion,
            animations: {
                self.portadaImageView.center=CGPointMake(CGFloat(300), CGFloat(200))},
            completion: {
                finished in
                self.portadaImageView.center=posicion
                NSLog("Valor de finished: \(finished)")
        })
        NSLog("cambiaVelocidad ha finalizado pero no animateWithDuration")
    }
}
