//
//  SettingsTableViewController.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 22/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class SettingObject{
    var temperatureDisplayUnit = "Farenheit"
    var sounds = true
    var notifications = true
    var probationEndDate = "30/06/2019"
    
    init() {
        
    }
}

class SettingsTableViewController: UITableViewController {
    
    let section1LabelArray = ["Temperature Display Units", "Sound"]
    let section2LabelArray = ["Notifications", "Date probation ends"]
    let section3LabelArray = ["View Details"]
    var settingObject = SettingObject()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0,1:
            return 2
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.delegate = self
        switch indexPath.section {
        case 0:
            switch indexPath.row{
            case 0:
                cell.itemLabel.text = section1LabelArray[indexPath.row]
                cell.offOnSwitch.isHidden = true
                cell.valueLabel.text = settingObject.temperatureDisplayUnit
            case 1:
                cell.itemLabel.text = section1LabelArray[indexPath.row]
                cell.offOnSwitch.isHidden = false
                cell.offOnSwitch.tag = indexPath.section
                cell.offOnSwitch.isOn = settingObject.sounds
                cell.valueLabel.isHidden = true
            default:
                print("default")
            }
        case 1:
            switch indexPath.row{
            case 0:
                cell.itemLabel.text = section2LabelArray[indexPath.row]
                cell.offOnSwitch.isHidden = false
                cell.offOnSwitch.tag = indexPath.section
                cell.offOnSwitch.isOn = settingObject.notifications
                cell.valueLabel.isHidden = true
            case 1:
                cell.itemLabel.text = section2LabelArray[indexPath.row]
                cell.offOnSwitch.isHidden = true
                cell.valueLabel.isHidden = false
                cell.valueLabel.text = settingObject.probationEndDate
            default:
                print("default")
            }
        case 2:
            cell.itemLabel.text = section3LabelArray[indexPath.row]
            cell.offOnSwitch.isHidden = true
            cell.valueLabel.isHidden = true
        default:
            print("default")
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
                self.performSegue(withIdentifier: "temperatureTableViewControllerSegue", sender: self)
            }
        case 2:
            self.performSegue(withIdentifier: "settingViewDetailsSegue", sender: self)
        default:
            print("default")
        }
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

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "settingViewDetailsSegue"{
            let destination = segue.destination as! SettingDetailsTableViewController
            destination.settingObject = self.settingObject
        }
        else if segue.identifier == "temperatureTableViewControllerSegue"{
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.topViewController as! TemperatureTableViewController
            destination.delegate = self
        }
    }

}

extension SettingsTableViewController: SwichValueChangedDelegate, TemperatureDisplayUnitDelegate{
    func switchValueChanged(value: Bool, tag: Int) {
        switch tag{
        case 0:
            self.settingObject.sounds = value
        case 1:
            self.settingObject.notifications = value
        default:
            print("default")
        }
    }
    
    func displayUnitChanged(value: String) {
        self.settingObject.temperatureDisplayUnit = value
        self.tableView.reloadData()
    }
    
    
}
