//
//  TwitterTableViewController.swift
//  newsApp
//
//  Created by Miguel Gutiérrez Moreno on 30/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit

class TwitterTableViewController: UITableViewController {

    let MaxPostEnTabla = 30
    var arrayDeTweets = [Tweet]()
    lazy var api : STTwitterAPI = twitterAPIClient()
    
    struct MainStoryboard {
        struct TableViewCellIdentifiers {
            // Used for normal items and the add item cell.
            static let listItemCell = "Cell"
        }
    }

    // MARK: ciclo de vida del controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        leerTweets()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrayDeTweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCellWithIdentifier(MainStoryboard.TableViewCellIdentifiers.listItemCell, forIndexPath: indexPath) as UITableViewCell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if arrayDeTweets.count > indexPath.row {
            cell.detailTextLabel?.text = arrayDeTweets[indexPath.row].texto
            
            let fechaFormatter = NSDateFormatter()
            fechaFormatter.dateFormat = FormatoFecha.formatoConHora
            
            if let fecha = arrayDeTweets[indexPath.row].creado {
                cell.textLabel?.text=fechaFormatter.stringFromDate(fecha)
            }
            else{
                cell.textLabel?.text=nil
            }
            
            NSLog("text: \(cell.textLabel?.text), detail: \(cell.detailTextLabel?.text)")
        }
    }

    // MARK: funciones de ayuda
    private func leerTweets () {
        Tweet.ultimosPost({ (posts, error) -> () in
            if let postsLeidos = posts {
                self.arrayDeTweets = postsLeidos 
                self.tableView.reloadData()
            }
        }, withTotal: MaxPostEnTabla)
    }
}
