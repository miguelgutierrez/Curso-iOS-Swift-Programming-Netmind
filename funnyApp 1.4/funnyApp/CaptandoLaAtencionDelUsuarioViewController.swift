//
//  CaptandoLaAtencionDelUsuarioViewController.swift
//  funnyApp
//
//  Created by Miguel Gutiérrez Moreno on 13/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
/*
    v 1.04 se añade el control del teclado
    Storyboard: se debe incluir UIScrollView y un View (contenedor de nuestros recursos), esta debe:
            * tener los constrains y además debe tener definido unos tamaños
            * basado en: 
                https://github.com/mattneub/Programming-iOS-Book-Examples/blob/master/bk2ch10p522textFieldScrollView/ch23p805textFieldSliding/ViewController.swift

    Se incluye el tratamiento del keyboard (mostrando y ocultando y moviendo el scroll):
        - todos los UITextField deben tener asignado el delegate al controller:
            * oculta el teclado con Return
        - se actualiza en el InterfaceBuilder: UIScrollView - keyboard -> Dismiss on drag para que oculte el teclado cuando se mueve

*/
import UIKit
import AVFoundation

class CaptandoLaAtencionDelUsuarioViewController: UIViewController, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet weak var mensajeLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!

    var audioPlayer : AVAudioPlayer?

    // MARK: gestión del teclado
    var activeView : UIView?  // para saber qué activeView está activo y no permitir hacer rotate
    var oldContentInset = UIEdgeInsetsZero
    var oldIndicatorInset = UIEdgeInsetsZero
    var oldOffset = CGPointZero

    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the audio player
        
        if let pathFichero = NSBundle.mainBundle().pathForResource("splash", ofType: "wav"){
            if let ficheroSonidoURL = NSURL(fileURLWithPath: pathFichero){
                var error:NSError?
                audioPlayer = AVAudioPlayer(contentsOfURL: ficheroSonidoURL, error: &error)
                if let audio = audioPlayer {
                    audio.prepareToPlay()
                }
            }
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // añado observers para la gestión del teclado
        NSNotificationCenter.defaultCenter().addObserver(self,selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector: Selector("keyboardWillBeHidden:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
            /* diferentes maneras de acceder
            if let fields = alertController.textFields as? [UITextField] {
                for textField in fields {
                    textoIntroducido += " " + textField.text
                }
            }*/
            for textField in alertController.textFields as [UITextField] {  // no se controla el type porque estamos seguros que será UITextField
                textoIntroducido += " " + textField.text
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

    // MARK: cerrar el teclado
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: gestión del Scroll
    func textFieldDidBeginEditing(textField: UITextField) {
        self.activeView = textField;
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.activeView = nil;
    }
    
    // si estoy con el recurso de edición no permitir la rotación
    override func shouldAutorotate() -> Bool {
        return self.activeView  == nil
    }
    
    func keyboardDidShow(notification : NSNotification){

        self.oldContentInset = self.scrollView.contentInset
        self.oldIndicatorInset = self.scrollView.scrollIndicatorInsets
        self.oldOffset = self.scrollView.contentOffset
        
        if var keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            keyboardRect = self.scrollView.convertRect(keyboardRect, fromView: nil)
            self.scrollView.contentInset.bottom = keyboardRect.size.height
            self.scrollView.scrollIndicatorInsets.bottom = keyboardRect.size.height
        }

    }
    func keyboardWillBeHidden(notification : NSNotification){
        self.scrollView.bounds.origin = self.oldOffset
        self.scrollView.scrollIndicatorInsets = self.oldIndicatorInset
        self.scrollView.contentInset = self.oldContentInset
    }
}
