//
//  FechaViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 26/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class FechaViewController: UIViewController {

    @IBOutlet weak var dateFicker: UIDatePicker!
    
    weak var delegate : ArticuloViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: eventos
    @IBAction func ok(sender: UIButton) {
        
        delegate?.actualizaFecha (dateFicker.date)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
