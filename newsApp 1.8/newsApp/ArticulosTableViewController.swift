//
//  ArticulosTableViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 26/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
//  Este es un ejercicio y se utiliza como apoyo a la formación, por lo que su objetivo es sólo didáctico
//   v 1.5: tabla con los artículos que se van añadiendo
//   v 1.7:
//      - Grabar en NSUserDefaults la cantidad de lecturas de artículos que ha realizado el usuario
//      - Grabar en Core Data los artículos
//
import UIKit
import CoreData

class ArticulosTableViewController: UITableViewController {
    struct MainStoryboard {
        struct TableViewCellIdentifiers {
            // Used for normal items and the add item cell.
            static let listItemCell = "Cell"
        }
        struct SegueIdentifiers {
            static let muestraDetalleArticulo = "muestraDetalleArticulo"
            static let añadeArticulo = "addArticulo"
        }

    }
    
    var arrayDeArticulos = [Articulo]()

    lazy var lecturasRealizadas : Int = self.leeCantidadDeLecturasDeUserDefaults ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.actualizaArticulosDeCoreData()
        
        self.tableView.reloadData()
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        self.muestraBadgeConTotalArticulos()
        self.muestraCantidadDeLecturas(lecturasRealizadas)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return arrayDeArticulos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.listItemCell, forIndexPath: indexPath) as UITableViewCell
        
        if arrayDeArticulos.count > indexPath.row {
            cell.textLabel?.text=arrayDeArticulos[indexPath.row].nombre
        }
        return cell
    }
    /* se puede utilizar también cellForRowAtIndexPath
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if arrayDeArticulos.count > indexPath.row {
            cell.textLabel?.text=arrayDeArticulos[indexPath.row].nombre
        }
    }*/
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == MainStoryboard.SegueIdentifiers.muestraDetalleArticulo {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if arrayDeArticulos.count > indexPath.row {
                    lecturasRealizadas++;
                    grabaUserDefaults(lecturasRealizadas)
                    
                    let muestraDetalleArticuloController = segue.destinationViewController as! DetalleArticuloViewController
                    muestraDetalleArticuloController.articulo = arrayDeArticulos[indexPath.row]
                    muestraDetalleArticuloController.delegate = self
                }                
            }
        }
        else if segue.identifier == MainStoryboard.SegueIdentifiers.añadeArticulo {
            if let articulo = NSEntityDescription.insertNewObjectForEntityForName(Articulo.entityName(), inManagedObjectContext:StoreNewsApp.defaultStore().context) as? Articulo {
                
                if let controlador =  segue.destinationViewController as? ArticuloViewController{
                    // inicializo los valores de la entidad
                    controlador.articulo = articulo
                    controlador.delegate = self
                }
                
            } else {
                NSLog(MensajesErrorCoreData.errorCrearObjectFormat, Articulo.entityName())
            } 
        }
    }
    
    // MARK: - funciones de ayuda
    private func muestraBadgeConTotalArticulos (){
        if arrayDeArticulos.count>0 {
            self.navigationController?.tabBarItem.badgeValue="\(arrayDeArticulos.count)";
        }
    }
    
    func cerrar(controller : UIViewController) {
        // cierra el detalle o cualquier otro que he abierto
        //self.dismissViewControllerAnimated(false, completion: nil) // cierra modal
        self.navigationController?.popViewControllerAnimated(false)  // cierra push
        
        self.tableView.reloadData()
        // self.muestraBadge()
    }
    private func actualizaArticulosDeCoreData() {

        arrayDeArticulos.removeAll(keepCapacity: true)
        if let articulos = Articulo.articulos() {
            arrayDeArticulos = articulos
        }
    }
    private func leeCantidadDeLecturasDeUserDefaults() -> Int {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let lecturas = userDefaults.objectForKey("lecturasDeArticulos") as? Int {
            return lecturas
        }
        else{
            return 0
        }
        
    }
    private func grabaUserDefaults(lecturas : Int) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setInteger(lecturas, forKey: "lecturasDeArticulos")
        userDefaults.synchronize()
    }
    private func muestraCantidadDeLecturas(lecturas : Int){
        
        let titulo = NSLocalizedString("Lecturas", comment: "")
        let okButtonTitle = NSLocalizedString("OK", comment: "")
        
        let alertController = UIAlertController(title: titulo, message: "Has realizado \(lecturas) lecturas", preferredStyle: .Alert)
        
        // Create the action.
        let okAction = UIAlertAction(title: okButtonTitle, style: .Cancel) {
            action in
            NSLog("Ha pulsado ok")
        }
        
        // Add the action.
        alertController.addAction(okAction)
        
        presentViewController(alertController, animated: true, completion: nil)

    }

}
