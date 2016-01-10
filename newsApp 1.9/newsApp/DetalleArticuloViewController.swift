//
//  DetalleArticuloViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 23/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
//  v 1.8: permite compartir por email y Twitter

import UIKit
import MessageUI
import Social

class DetalleArticuloViewController: UIViewController, MFMailComposeViewControllerDelegate, UISplitViewControllerDelegate {

    // MARK: properties
    @IBOutlet weak var articuloTextView: UITextView!
    var articulo : Articulo? {
        didSet {
            // Update the view.
            if isViewLoaded() {
                muestraInformacion()
            }
        }
    }

    weak var delegate : ArticulosTableViewController?
    weak var masterPopoverController : UIPopoverController?
    
    // MARK: life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        muestraInformacion()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - eventos
    @IBAction func compartir(sender: UIButton) {
        let titulo = NSLocalizedString("Compártelo", comment: "")
        
        let mailButtonTitle = NSLocalizedString("Mail", comment: "")
        let twitterButtonTitle = NSLocalizedString("Twitter", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        
        let alertController = UIAlertController(title: titulo, message: nil, preferredStyle: .ActionSheet)
        
        // Create the action.
        let mailAction = UIAlertAction(title: mailButtonTitle, style: .Default) {
            [unowned self]
            action in
            self.enviarMail()
        }
        
        let twitterAction = UIAlertAction(title: twitterButtonTitle, style: .Default) {
            [unowned self]
            action in
            self.compartirTwitter()
        }
        let destructiveAction = UIAlertAction(title: cancelButtonTitle, style: .Destructive, handler: nil)
        
        // Add the action.
        alertController.addAction(mailAction)
        alertController.addAction(twitterAction)
        alertController.addAction(destructiveAction)

        // necesario para el iPAD
        if let popover = alertController.popoverPresentationController{
            popover.sourceView = sender
            popover.sourceRect = sender.bounds
            popover.permittedArrowDirections = UIPopoverArrowDirection.Any
        }
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    // MARK: - UISplitViewControllerDelegate
    // sustituir están deprecated en iOS 8
    /*
    func splitViewController(svc: UISplitViewController, willHideViewController aViewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController pc: UIPopoverController) {
        
        barButtonItem.title = "Artículos"
        navigationItem.setLeftBarButtonItem(barButtonItem, animated: true)
        masterPopoverController = pc
        
    }
    func splitViewController(svc: UISplitViewController, willShowViewController aViewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        // Called when the view is shown again in the split view, invalidating the button and popover controller.
        navigationItem.setLeftBarButtonItem(nil, animated: true)
        masterPopoverController = nil
    }
    func splitViewController(svc: UISplitViewController, shouldHideViewController vc: UIViewController, inOrientation orientation: UIInterfaceOrientation) -> Bool {
        if orientation == UIInterfaceOrientation.LandscapeLeft ||  orientation == UIInterfaceOrientation.LandscapeRight {
            return false
        }
        else {
            return true
        }
    }
    */
    func muestraInformacion() {


        if let articulo = self.articulo {

            navigationItem.title = "Artículo de \(articulo.nombre)"

            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = FormatoFecha.formatoGeneral
            let fechaStr = dateFormatter.stringFromDate(articulo.fecha)
            
            articuloTextView.text = "Nombre: \(articulo.nombre)\n Fecha: \(fechaStr)\n Texto: \(articulo.texto)"
        }

        if let masterPopoverController = masterPopoverController {
            masterPopoverController.dismissPopoverAnimated(true)
        }
        
    }
    // MARK: - funciones auxiliares
    private func enviarMail() {
        if MFMailComposeViewController.canSendMail() {
            if let articulo = articulo {
                let mailComposer = MFMailComposeViewController()
                mailComposer.mailComposeDelegate = self
                
                mailComposer.setToRecipients(["miguel.gutierrez.moreno@gmail.com","otro.correo@gmail.com"])
                let asunto = NSString(format: "Escritor: %@  Fecha: %@ \n Artículo: %@", articulo.nombre,articulo.fecha,articulo.texto)
                mailComposer.setSubject("Artículo de " + articulo.nombre)
                mailComposer.setMessageBody(asunto as String, isHTML: false)
                
                mailComposer.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                presentViewController(mailComposer, animated: true, completion: nil)
            }
        }
    }
    private func compartirTwitter() {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            if let articulo = articulo {
                let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                tweetSheet.setInitialText("Lee el artículo de: "+articulo.nombre)
                presentViewController(tweetSheet, animated: true, completion: nil)
            }
        }
    }
    
}
