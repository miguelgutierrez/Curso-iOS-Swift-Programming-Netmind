//
//  ArticuloViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 23/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
/*
    * v 1.2: tratamiento del artículo y muestra un View Controller (en Modal)
*/
import UIKit

class ArticuloViewController: UIViewController, UITextFieldDelegate {

    struct MainStoryboard {
        struct SegueIdentifiers {
            static let muestraDetalleArticulo = "muestraDetalleArticulo"
        }
    }

    // MARK: properties
    @IBOutlet weak var nombreEscritorTextField: UITextField!
    @IBOutlet weak var fechaArticuloTextField: UITextField!
    @IBOutlet weak var textoArticuloTextView: UITextView!
    
    // MARK: life cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == MainStoryboard.SegueIdentifiers.muestraDetalleArticulo {
            let muestraDetalleArticuloController = segue.destinationViewController as DetalleArticuloViewController
            muestraDetalleArticuloController.setArticulo(texto: textoArticuloTextView.text)
            
        }

    }

    // MARK: cerrar el teclado: el usuario pulsa en la view
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
