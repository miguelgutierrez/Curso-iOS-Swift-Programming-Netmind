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
import CoreData

struct FormatoFecha {
    static let formatoGeneral = "dd/MM/yyyy"
    static let formatoConHora = "dd/MM/yyyy hh:mm:ss"
}

class ArticuloViewController: UIViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {

    struct MainStoryboard {
        struct SegueIdentifiers {
            static let aFecha = "aFecha"
        }
        struct Identifiers {
            static let popoverViewController = "popoverViewController"
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

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
        if segue.identifier == MainStoryboard.SegueIdentifiers.aFecha {
            let fechaController = segue.destinationViewController as! FechaViewController
            
            fechaController.delegate = self
            
        }

    }

    // MARK: cerrar el teclado: el usuario pulsa en la view
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - eventos
    @IBAction func mostrarFecha(sender: UIButton) {
        let popoverViewController = UIStoryboard(name: AppDelegate.MainStoryboard.name, bundle: nil).instantiateViewControllerWithIdentifier(MainStoryboard.Identifiers.popoverViewController) as? FechaViewController
        
        popoverViewController?.delegate = self  // necesario para que llame a actualizaFecha
        
        popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.Popover
        popoverViewController?.popoverPresentationController?.delegate = self
        
        self.presentViewController(popoverViewController!, animated: true, completion: nil)
        
        popoverViewController?.popoverPresentationController?.sourceView = sender
        popoverViewController?.popoverPresentationController?.permittedArrowDirections = .Any
        popoverViewController?.preferredContentSize = CGSizeMake(300.0, 200.0)  // alternativa: definir el tamaño en el Storyboard

    }
    @IBAction func grabar(sender: UIButton) {
        if let nombre = nombreEscritorTextField.text{
            articulo.nombre = nombre
        }
        if let texto = textoArticuloTextView.text{
            articulo.texto = texto
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = FormatoFecha.formatoGeneral
        if let fechaStr = fechaArticuloTextField.text {
            if let fecha = dateFormatter.dateFromString(fechaStr) {
                articulo.fecha = fecha
            }
        }
        
        delegate?.cerrar(self)
        
        // self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: interface 
    func actualizaFecha (fecha : NSDate) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = FormatoFecha.formatoGeneral
        
        fechaArticuloTextField.text = dateFormatter.stringFromDate(fecha)
        articulo.fecha = fecha
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }

}
