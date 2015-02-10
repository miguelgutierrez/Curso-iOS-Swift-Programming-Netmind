//
//  PeriodicosTableTableViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//
/*
    V 1.1: muestra una lista con los periódicos
    v 1.3: Ejercicio: mostrar los periódicos deportivos
*/
import UIKit

class PeriodicosTableViewController: UITableViewController {

    struct MainStoryboard {
        struct TableViewCellIdentifiers {
            // Used for normal items and the add item cell.
            static let listItemCell = "Cell"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // para que se desplace la tableView hacia abajo y no aparezca ajustada al Top
        self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);

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
        return Periodico.totalPeriodicos()
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.listItemCell, forIndexPath: indexPath) as UITableViewCell
    }


    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        // pongo primero los generalistas
        if (indexPath.row < Periodico.totalPeriodicos(TipoPeriodico.Generalista)){
            if let periodico = Periodico(tipo: TipoPeriodico.Generalista,periodico: indexPath.row) {
                cell.textLabel?.text = periodico.nombre()
            }
        }
        else { // deportivos
            if let periodico = Periodico(tipo: TipoPeriodico.Deportivo, periodico: indexPath.row - Periodico.totalPeriodicos(TipoPeriodico.Generalista)) {
                cell.textLabel?.text = periodico.nombre()
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
