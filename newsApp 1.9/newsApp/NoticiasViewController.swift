//
//  NoticiasViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
// v 1.3:
//      * Incluir un switch que permita seleccionar entre periódicos deportivos/generalistas
//      * modificar el SegmentedControl en función de la selección 
//  v 1.5: sustituye UISegmentedControl por UIPickerView

import UIKit

class NoticiasViewController: UIViewController, UIWebViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    enum ComponentePeriodicos : Int {
        case Tipos = 0, Periodicos
        
        static func totalComponentes() -> Int {
            return 2
        }
    }
    
    // MARK: properties
    @IBOutlet weak var periodicosPickerView: UIPickerView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: ciclo de vida del controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.scalesPageToFit = true
        mostrarWeb(TipoPeriodico.Generalista, periodico: 0)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.delegate=self;
        
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webView.delegate=nil // para que deje de informar
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false // lo paro por si estaba activo

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: eventos
    @IBAction func ajustaWeb(sender: UISwitch) {
        webView.scalesPageToFit=sender.on
        if let tipoPeriodico = TipoPeriodico(rawValue: periodicosPickerView.selectedRowInComponent(ComponentePeriodicos.Periodicos.rawValue)) {
            mostrarWeb(tipoPeriodico, periodico: periodicosPickerView.selectedRowInComponent(ComponentePeriodicos.Periodicos.rawValue))        
        }
    }

    // MARK: UIPickerViewDataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return ComponentePeriodicos.totalComponentes()
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if let componente = ComponentePeriodicos(rawValue: component) {
            switch componente {
            case .Tipos:
                return TipoPeriodico.totalTiposPeriodico()
            case .Periodicos: // depende del tipo de periódico seleccionado
                if let tipoPeriodicoSeleccionado = TipoPeriodico(rawValue: periodicosPickerView.selectedRowInComponent(ComponentePeriodicos.Tipos.rawValue)) {
                    return Periodico.totalPeriodicos(tipoPeriodicoSeleccionado)
                }
            }
        }
        return 0;
    }

    // MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if let componente = ComponentePeriodicos(rawValue: component) {
            switch componente {
            case .Tipos:
                return TipoPeriodico(rawValue: row)?.nombre()

            case .Periodicos: // depende del tipo de periódico seleccionado
                if let tipoPeriodicoSeleccionado = TipoPeriodico(rawValue: periodicosPickerView.selectedRowInComponent(ComponentePeriodicos.Tipos.rawValue)) {
                    return Periodico(tipo: tipoPeriodicoSeleccionado, periodico: row)?.nombre()
                }
            }
        }
        
        return nil
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let componente = ComponentePeriodicos(rawValue: component) {
            switch componente {
            case .Tipos:
                periodicosPickerView.reloadComponent(ComponentePeriodicos.Periodicos.rawValue)
                periodicosPickerView.selectRow(0, inComponent: ComponentePeriodicos.Periodicos.rawValue, animated: true)

                if let tipoPeriodicoSeleccionado = TipoPeriodico(rawValue: row) {
                    mostrarWeb(tipoPeriodicoSeleccionado, periodico: 0)
                }
            case .Periodicos: // depende del tipo de periódico seleccionado
                if let tipoPeriodicoSeleccionado = TipoPeriodico(rawValue: periodicosPickerView.selectedRowInComponent(ComponentePeriodicos.Tipos.rawValue)) {
                    if let _ = Periodico(tipo: tipoPeriodicoSeleccionado, periodico: row) {
                        mostrarWeb(tipoPeriodicoSeleccionado, periodico: row)
                    }
                }
            }
        }
    }
    // MARK: UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        activityIndicator.startAnimating()

    }
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        activityIndicator.stopAnimating()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        NSLog("Error al cargar la web")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()        
    }
    // MARK: métodos de ayuda
    private func mostrarWeb(tipoPeriodico:TipoPeriodico,  periodico: Int){
        NSLog("Mostrar web: \(tipoPeriodico) periodico: \(periodico)")
        
        if let url = Periodico(tipo: tipoPeriodico, periodico: periodico)?.url() {
            if let periodicoNSURL = NSURL(string: url) {
                let periodicoRequest = NSURLRequest(URL: periodicoNSURL)
                webView.loadRequest(periodicoRequest)
            }
        }
    }

}
