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
import UIKit

class NoticiasViewController: UIViewController, UIWebViewDelegate {

    // MARK: properties
    @IBOutlet weak var tipoPeriodicoSwitch: UISwitch!
    @IBOutlet weak var periodicoSegmented: UISegmentedControl!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: ciclo de vida del controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.scalesPageToFit = true
    
        mostrarWeb(esDeportivo: tipoPeriodicoSwitch.on, periodico: periodicoSegmented.selectedSegmentIndex)

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
    @IBAction func tipoPeriodicoElegido(sender: UISwitch) {
        
        NSLog("Tipo periódico \(sender.on)");
        // cambia los textos del segmented
        
        periodicoSegmented.removeAllSegments()

        if sender.on {
            for i in 0..<Periodico.totalPeriodicos(TipoPeriodico.Deportivo) {
                periodicoSegmented.insertSegmentWithTitle(Periodico(tipo: TipoPeriodico.Deportivo, periodico: i)?.nombre(), atIndex: i, animated: true)
            }
        }
        else{
            for i in 0..<Periodico.totalPeriodicos(TipoPeriodico.Generalista) {
                periodicoSegmented.insertSegmentWithTitle(Periodico(tipo: TipoPeriodico.Generalista, periodico: i)?.nombre(), atIndex: i, animated: true)
            }
            
        }
        periodicoSegmented.selectedSegmentIndex=0
        mostrarWeb(esDeportivo: sender.on,periodico: 0)
    }
    @IBAction func periodicoElegido(sender: UISegmentedControl) {
        mostrarWeb(esDeportivo: tipoPeriodicoSwitch.on, periodico: sender.selectedSegmentIndex)
    }
    @IBAction func ajustaWeb(sender: UISwitch) {
        webView.scalesPageToFit=sender.on
        mostrarWeb(esDeportivo: tipoPeriodicoSwitch.on, periodico: periodicoSegmented.selectedSegmentIndex)
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
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        NSLog("Error al cargar la web")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()        
    }
    // MARK: métodos de ayuda
    private func mostrarWeb(# esDeportivo:Bool,  periodico: Int){
        if esDeportivo {
            mostrarWeb(TipoPeriodico.Deportivo, periodico: periodico)
        }
        else{
            mostrarWeb(TipoPeriodico.Generalista, periodico: periodico)
        }
    }
    private func mostrarWeb(tipoPeriodico:TipoPeriodico,  periodico: Int){
        NSLog("Mostrar web: \(tipoPeriodico) periodico: \(periodico)")
        
        if let url = Periodico(tipo:tipoPeriodico, periodico: periodico)?.url() {
            if let periodicoNSURL = NSURL(string: url) {
                let periodicoRequest = NSURLRequest(URL: periodicoNSURL)
                webView.loadRequest(periodicoRequest)
            }
        }
    }

}
