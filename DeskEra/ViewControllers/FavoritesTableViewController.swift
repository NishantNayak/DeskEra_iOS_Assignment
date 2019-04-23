//
//  FavoritesTableViewController.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, FavoritesAddedDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.register(UINib(nibName: "ItemsTableViewCell", bundle: nil), forCellReuseIdentifier: "itemsTableViewCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Constants.sharedInstance.favoritesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsTableViewCell", for: indexPath) as! ItemsTableViewCell
        cell.delegate = self
        let itemValue = Constants.sharedInstance.favoritesArray[indexPath.row]
        cell.nameLabel.text = itemValue.itemName
        cell.descriptionLabel.text = itemValue.itemDescription
        cell.categoryLabel.text = itemValue.itemCategoyString
        if (itemValue.isFavorite)!{
            cell.favoritesButton.isSelected = true
        }
        else{
            cell.favoritesButton.isSelected = false
        }
        return cell
    }
    
    //MARK: - FavoriteAddedDelegate methods
    func addFavorite(name: String, seleted: Bool) {
        for item in Constants.sharedInstance.itemArray where item.itemName == name{
            let index = Constants.sharedInstance.itemArray.firstIndex(where: {$0 === item})
            if seleted{
                item.isFavorite = true
                Constants.sharedInstance.itemArray[index!] = item
                Constants.sharedInstance.favoritesArray.append(item)
            }
            else{
                item.isFavorite = false
                Constants.sharedInstance.itemArray[index!] = item
                Constants.sharedInstance.favoritesArray.removeAll(where: {$0 === item})
            }
        }
        self.tableView.reloadData()
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
