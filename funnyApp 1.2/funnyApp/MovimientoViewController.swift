//
//  MovimientoViewController.swift
//  funnyApp
//
//  Created by Miguel Gutiérrez Moreno on 21/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
/*
    Detecta los diferentes cambios de orientación del device y detección de gestos del usuario
*/
import UIKit

class MovimientoViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var movimientoLabel: UILabel!
    @IBOutlet weak var gestosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()// necesario para gestionar shake
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        var texto=""
        switch UIDevice.currentDevice().orientation{
        case .Portrait:
            texto="Portrait"
        case .PortraitUpsideDown:
            texto="PortraitUpsideDown"
        case .LandscapeLeft:
            texto="LandscapeLeft"
        case .LandscapeRight:
            texto="LandscapeRight"
        default:
            texto="No sé qué has movido"
        }
        movimientoLabel.text=texto
        NSLog("Has movido: \(texto)")
    }
    /* también se puede utilizar
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
    }*/

    // MARK: eventos
    
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        if sender.state ==  UIGestureRecognizerState.Ended {
            gestosLabel.text="SWIPE: El usuario ha movido el dedo a la derecha";
        }
    }
    @IBAction func tap(sender: UITapGestureRecognizer) {
        if sender.state ==  UIGestureRecognizerState.Ended {
            gestosLabel.text="TAP: El usuario ha pulsado 2 veces con 1 dedo";
        }
    }
    
    @IBAction func rotation(sender: UIRotationGestureRecognizer) {
        if sender.state ==  UIGestureRecognizerState.Ended {
            gestosLabel.text="ROTATION: El usuario ha rotado los dedos";
        }
    }
    
    @IBAction func pinch(sender: UIPinchGestureRecognizer) {
        if sender.state ==  UIGestureRecognizerState.Ended {
            gestosLabel.text="PINCH: El usuario ha pellizcado";
        }
    }
    
    @IBAction func pan(sender: UIPanGestureRecognizer) {
        if sender.state ==  UIGestureRecognizerState.Ended {
            gestosLabel.text="PAN: El usuario ha arrastrado 2 dedos";
        }
    }
    
    @IBAction func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state ==  UIGestureRecognizerState.Ended {
            gestosLabel.text="LONGPRESS: El usuario ha pulsado largo tiempo ";
        }
    }
    /* PROCESO
    - el usuario ha agitado el dispositivo
    -
    */
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        movimientoLabel.text="Se ha agitado"
    }
    /* PROCESO
    -  necesario para shake/motionEnded
    -
    */
    override func canBecomeFirstResponder() -> Bool {
        return true
    }

}
