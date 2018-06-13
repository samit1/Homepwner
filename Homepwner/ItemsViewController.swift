//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Sami Taha on 6/12/18.
//  Copyright © 2018 Sami Taha. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    
    var itemStore: ItemStore!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        
        /// Create new item and add into store
        let newItem = itemStore.createItem()
        
        /// Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            /// Insert this new row into table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /// If the tableview is asking to commit a delete command
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            /// Remove item from the store
            itemStore.removeItem(item)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.nameLabel?.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel?.text = "$\(item.valueInDollars)"
        return cell 
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewContoller
                detailViewController.item = item
            }
        default: preconditionFailure("Unexpected segue identifier")
        }
    }
    
}
