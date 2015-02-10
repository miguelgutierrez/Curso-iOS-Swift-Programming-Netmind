//
//  ArticuloViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 23/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
/*
    * v 1.2: tratamiento del artículo y muestra un View Controller (en Modal)
    * v 1.4: revisar Storyboard
    * v 1.5: permite guardar artículos en la tabla y seleccionar la fecha con DatePicker
*/
import UIKit

struct FormatoFecha {
    static let formatoGeneral = "dd/MM/yyyy"
    static let formatoConHora = "dd/MM/yyyy hh:mm:ss"
}

class ArticuloViewController: UIViewController, UITextFieldDelegate {

    struct MainStoryboard {
        struct SegueIdentifiers {
            static let muestraDetalleArticulo = "muestraDetalleArticulo"
            static let aFecha = "aFecha"
            
        }
    }

    // MARK: properties
    @IBOutlet weak var nombreEscritorTextField: UITextField!
    @IBOutlet weak var fechaArticuloTextField: UITextField!
    @IBOutlet weak var textoArticuloTextView: UITextView!
    
    weak var delegate : ArticulosTableViewController?

    var articulo : Articulo!
    
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

            muestraDetalleArticuloController.articulo = articulo
        }
        else if segue.identifier == MainStoryboard.SegueIdentifiers.aFecha {
            let fechaController = segue.destinationViewController as FechaViewController
            
            fechaController.delegate = self
            
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
    
    // MARK: eventos
    @IBAction func grabar(sender: UIButton) {
        articulo?.nombre = nombreEscritorTextField.text
        articulo?.texto = textoArticuloTextView.text

        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = FormatoFecha.formatoGeneral
        articulo.fecha = dateFormatter.dateFromString(fechaArticuloTextField.text)
        
        delegate?.cerrar(self)
        
        // self.navigationController?.popViewControllerAnimated(true)
    }

    // MARK: interface 
    func actualizaFecha (fecha : NSDate) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = FormatoFecha.formatoGeneral
        
        fechaArticuloTextField.text = dateFormatter.stringFromDate(fecha)
        articulo.fecha = fecha
    }
}
