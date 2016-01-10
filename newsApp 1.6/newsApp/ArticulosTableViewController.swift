//
//  ArticulosTableViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 26/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
//   v 1.5: tabla con los artículos que se van añadiendo 
import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        for  i in 0...20 {
            let articulo = Articulo()
            articulo.nombre = "nombre: \(i)"
            articulo.texto =  "texto: \(i)"
            
            arrayDeArticulos.append(articulo)
        }*/
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrayDeArticulos.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.listItemCell, forIndexPath: indexPath) as UITableViewCell
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if arrayDeArticulos.count > indexPath.row {
            cell.textLabel?.text=arrayDeArticulos[indexPath.row].nombre
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == MainStoryboard.SegueIdentifiers.muestraDetalleArticulo {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if arrayDeArticulos.count > indexPath.row {
                    let muestraDetalleArticuloController = segue.destinationViewController as! DetalleArticuloViewController
                    muestraDetalleArticuloController.articulo = arrayDeArticulos[indexPath.row]

                    muestraDetalleArticuloController.delegate = self
                }
                
            }
        }
        else if segue.identifier == MainStoryboard.SegueIdentifiers.añadeArticulo {
            let articulo = Articulo ()
            arrayDeArticulos.append(articulo)
            
            if let controlador =  segue.destinationViewController as? ArticuloViewController{
                // inicializo los valores de la entidad
                controlador.articulo = articulo
                controlador.delegate = self
            }

        }
    }
    
    // MARK: funciones de ayuda
    private func muestraBadge (){
        if arrayDeArticulos.count>0 {
            self.navigationController?.tabBarItem.badgeValue="\(arrayDeArticulos.count)";
        }
    }
    
    func cerrar(controller : UIViewController) {
        // cierra el detalle o cualquier otro que he abierto
        //self.dismissViewControllerAnimated(false, completion: nil) // cierra modal
        self.navigationController?.popViewControllerAnimated(false)  // cierra push
        
        self.tableView.reloadData()
        self.muestraBadge()

    }
}
