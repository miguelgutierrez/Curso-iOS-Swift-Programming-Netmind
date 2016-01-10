//
//  CaptandoLaAtencionDelUsuarioViewController.swift
//  funnyApp
//
//  Created by Miguel Gutiérrez Moreno on 13/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
/*
Storyboard: se debe incluir UIScrollView y un View (contenedor de nuestros recursos), esta debe:
* tener los constrains y además debe tener definido unos tamaños
* basado en: http://spin.atomicobject.com/2014/03/05/uiscrollview-autolayout-ios/
*/

import UIKit
import AVFoundation

class CaptandoLaAtencionDelUsuarioViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var mensajeLabel: UILabel!
    
    var audioPlayer : AVAudioPlayer?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the audio player
        
        if let pathFichero = NSBundle.mainBundle().pathForResource("splash", ofType: "wav"){
            
            let ficheroSonidoURL = NSURL(fileURLWithPath: pathFichero)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOfURL: ficheroSonidoURL)
            } catch  {
                
                audioPlayer = nil
            }
            if let audio = audioPlayer {
                audio.prepareToPlay()
            }

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - actions
    @IBAction func error(sender: AnyObject) {
        
        let titulo = NSLocalizedString("ERROR", comment: "")
        let mensaje = NSLocalizedString("Falta introducir el nombre. Quieres continuar?", comment: "")
        let okButtonTitle = NSLocalizedString("OK", comment: "")
        
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        
        // Create the action.
        let okAction = UIAlertAction(title: okButtonTitle, style: .Cancel) {
            // se requiere ya que accedemos a self
            [unowned self]
            action in
            self.mensajeLabel.text = "Ha pulsado OK."
        }
        
        // Add the action.
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func solicitaClave(sender: AnyObject) {

        let titulo = NSLocalizedString("Clave", comment: "")
        let mensaje = NSLocalizedString("Por favor, introduce la clave", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let okButtonTitle = NSLocalizedString("OK", comment: "")
        
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        
        // Add the text field for text entry.
        alertController.addTextFieldWithConfigurationHandler { textField in
            // If you need to customize the text field, you can do so here.
            textField.secureTextEntry = true
        }

        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) {
            [unowned self]
            action in
            self.mensajeLabel.text = "Ha pulsado Cancel"
            
        }
        
        let okAction = UIAlertAction(title: okButtonTitle, style: .Default) { action in
            var textoIntroducido = "Ha introducido:"
            
            if let textFields = alertController.textFields{
                for textField in textFields {
                    if let texto = textField.text{
                        textoIntroducido += " " + texto
                    }
                }
                
            }

            self.mensajeLabel.text = textoIntroducido
            
        }
        
        // Add the actions.
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)

    }
    
    @IBAction func compartelo(sender: UIButton) {
        let titulo = NSLocalizedString("Compártelo", comment: "")
        
        let mailButtonTitle = NSLocalizedString("Mail", comment: "")
        let twitterButtonTitle = NSLocalizedString("Twitter", comment: "")
        let facebookButtonTitle = NSLocalizedString("Facebook", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        
        let alertController = UIAlertController(title: titulo, message: nil, preferredStyle: .ActionSheet)
        
        // Create the action.
        let mailAction = UIAlertAction(title: mailButtonTitle, style: .Default) {
            [unowned self]
            action in
            self.mensajeLabel.text = "Ha pulsado MAIL"
        }

        let twitterAction = UIAlertAction(title: twitterButtonTitle, style: .Default) {
            [unowned self]
            action in
            self.mensajeLabel.text = "Ha pulsado TWITTER"
        }

        let facebookAction = UIAlertAction(title: facebookButtonTitle, style: .Default) {
            [unowned self]
            action in
            self.mensajeLabel.text = "Ha pulsado FACEBOOK"
        }

        let destructiveAction = UIAlertAction(title: cancelButtonTitle, style: .Destructive) {
            [unowned self]
            action in
            self.mensajeLabel.text = "Ha pulsado CANCEL"
        }

        // Add the action.
        alertController.addAction(mailAction)
        alertController.addAction(twitterAction)
        alertController.addAction(facebookAction)
        alertController.addAction(destructiveAction)
        
        // necesario para el iPAD
        if let popover = alertController.popoverPresentationController{
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
            popover.permittedArrowDirections = UIPopoverArrowDirection.Any
        }
        

        presentViewController(alertController, animated: true, completion: nil)
        

    }
    
    @IBAction func sonido(sender: AnyObject) {
        if let audio = audioPlayer {
            audio.play()
        }

    }
    
    @IBAction func vibracion(sender: AnyObject) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }

}
