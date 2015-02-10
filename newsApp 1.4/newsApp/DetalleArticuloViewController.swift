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
    private var articuloTexto = ""
    
    // MARK: life cicle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        articuloTextView.text=articuloTexto
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: eventos
    @IBAction func ok(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: funciones de ayuda
    func setArticulo(# texto:String){
        articuloTexto=texto
    }

    
}
