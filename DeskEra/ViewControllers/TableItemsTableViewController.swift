//
//  TableItemsTableViewController.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class TableItemsTableViewController: UITableViewController,EditItemsDelegate, UISearchResultsUpdating {

    var fruitsArray = [Dictionary<String,String>]()
    var selectedIndex = 0
    var toDeleteArray = [Dictionary<String,String>]()
    var filteredArray = [Dictionary<String,String>]()
    var deleteButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        //guard let navigationItem = self.navigationController?.navigationItem else { return }
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchResultsUpdater = self
        self.tableView.allowsMultipleSelection = false
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        parseJsonData()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.searchController?.isActive = true
        self.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    func parseJsonData(){
        guard let path = Bundle.main.path(forResource: "Fruits", ofType: "json") else { return  }
        //let jsonData: try;? NSData(contentsOfFile: path!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            let jsonDict = try JSONSerialization.jsonObject(with: data) as? NSDictionary
            fruitsArray = jsonDict!["fruits"] as! [Dictionary<String,String>]
            self.tableView.reloadData()
        } catch let error {
            //print(error.localizedDescription)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filteredArray.removeAll()
        var filtered = self.fruitsArray.filter {
            return $0["name"]?.range(of: searchText! , options: .forcedOrdering) != nil
        }
        filtered = filtered.sorted(by: {$0["name"]! < $1["name"]!})
        self.filteredArray = filtered
        self.tableView.reloadData()
    }
    
    @IBAction func editClicked(_ sender: UIBarButtonItem) {
        
        switch sender.tag {
        case 1:
            sender.title = "Done"
            self.tableView.setEditing(true, animated: true)
            let button1 = UIButton(frame: CGRect(x: 0, y: 0, width: (self.tabBarController?.tabBar.frame.width)!, height: (self.tabBarController?.tabBar.frame.height)!))
            button1.setTitle("Delete", for: .normal)
            button1.addTarget(self, action: #selector(deletePressed), for: UIControl.Event.touchUpInside)
            button1.backgroundColor = UIColor.lightGray
            self.deleteButton = button1
            self.tabBarController?.tabBar.addSubview(button1)
            sender.tag = 2
        case 2:
            self.tableView.setEditing(false, animated: true)
            self.deleteButton?.removeFromSuperview()
            sender.tag = 1
            sender.title = "Edit"
            self.toDeleteArray.removeAll()
        default:
            print("default")
        }
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Add New Fruit", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Fruit Name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let newDict = ["name":firstTextField.text]
            self.fruitsArray.insert(newDict as! [String : String], at: 0)
            self.tableView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func deletePressed(){
        for item in toDeleteArray{
            self.fruitsArray.removeAll(where: {$0 == item})
        }
        self.tableView.reloadData()
    }
    
    func updateTableView(index: Int, name: String) {
        var editDict = fruitsArray[index]
        editDict["name"] = name
        fruitsArray[index] = editDict
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editItemNameSegue"{
            let destination = segue.destination as! EditTableItemsViewController
            destination.delegate = self
            destination.indexValue = selectedIndex
            var itemDict = fruitsArray[selectedIndex]
            if ((self.navigationItem.searchController?.searchBar.text!.count)! > 0){
                itemDict = filteredArray[selectedIndex]
            }
            if let name = itemDict["name"]{
                destination.nameString = name
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if ((self.navigationItem.searchController?.searchBar.text!.count)! > 0){
            return filteredArray.count
        }
        return fruitsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableItemsTableViewCell", for: indexPath) as! TableItemsTableViewCell
        if ((self.navigationItem.searchController?.searchBar.text!.count)! > 0){
            let fruitDict = filteredArray[indexPath.row]
            cell.itemLabel.text = fruitDict["name"]
            return cell
        }
        let fruitDict = fruitsArray[indexPath.row]
        cell.itemLabel.text = fruitDict["name"]
        return cell
    }
    

    
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//
//
//
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .none {
//            // Delete the row from the data source
//            //tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if !(tableView.isEditing){
            self.performSegue(withIdentifier: "editItemNameSegue", sender: self)
        }
        else{
            self.toDeleteArray.append(self.fruitsArray[selectedIndex])
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        if !(tableView.isEditing){
            //self.performSegue(withIdentifier: "editItemNameSegue", sender: self)
        }
        else{
            self.toDeleteArray.removeAll(where: {$0 == fruitsArray[selectedIndex]})
        }
    }

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
