//
//  DetalleArticuloViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 23/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class DetalleArticuloViewController: UIViewController {

    // MARK: properties
    @IBOutlet weak var articuloTextView: UITextView!
    var articulo : Articulo?
    
    weak var delegate : ArticulosTableViewController?
    
    // MARK: life cicle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let articulo = self.articulo {

            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = FormatoFecha.formatoGeneral
            let fechaStr = dateFormatter.stringFromDate(articulo.fecha )

            articuloTextView.text = "Nombre: \(articulo.nombre)\n Fecha: \(fechaStr)\n Texto: \(articulo.texto)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: eventos
    @IBAction func ok(sender: UIButton) {
        delegate?.cerrar(self)
         //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
