//
//  NoticiasViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class NoticiasViewController: UIViewController, UIWebViewDelegate {

    enum TipoPeriodico: Int  {
        case ElPais=0, ElMundo, ABC
    }
    // MARK: properties
    @IBOutlet weak var periodicoSegmented: UISegmentedControl!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: ciclo de vida del controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.scalesPageToFit = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        webView.delegate=self;
        
        mostrarWeb(periodicoSegmented.selectedSegmentIndex)
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webView.delegate=nil // para que deje de informar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: eventos
    @IBAction func periodicoElegido(sender: UISegmentedControl) {
        mostrarWeb(sender.selectedSegmentIndex)
    }
    @IBAction func ajustaWeb(sender: UISwitch) {
        webView.scalesPageToFit=sender.on
        mostrarWeb(periodicoSegmented.selectedSegmentIndex)
    }

    // MARK: métodos de ayuda
    private func mostrarWeb(periodico: Int){
        var url:String?
        if let tipoPeriodico = TipoPeriodico(rawValue: periodico){
            switch tipoPeriodico{
            case .ElPais:
                url="http://www.elpais.es"
            case .ElMundo:
                url="http://www.elmundo.es"
            case .ABC:
                url="http://www.abc.es"
            }
        }
        if let periodicoURL = url {
            if let periodicoNSURL = NSURL(string: periodicoURL) {
                let periodicoRequest = NSURLRequest(URL: periodicoNSURL)
                webView.loadRequest(periodicoRequest)
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
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
            NSLog("Error al cargar la web")
    }
}
