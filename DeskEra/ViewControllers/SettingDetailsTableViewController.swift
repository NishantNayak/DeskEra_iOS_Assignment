//
//  SettingDetailsTableViewController.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 22/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class SettingDetailsTableViewController: UITableViewController {
    
    let detailsArray = ["Username", "E-mail", "Date of joing", "Temperature Display Units", "Sound", "Notifications", "Date probation ends", "Probation Duration", "Date becomes permanent", "Probation length"]
    var settingObject: SettingObject?
    var valueArray: [String]?
    var sixMonthsDuratinString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let startDate = Constants.sharedInstance.doj.stringToDate()
        let endDate = (settingObject?.probationEndDate.stringToDate())!
        
        self.valueArray = Array.init()
        self.valueArray?.append(Constants.sharedInstance.username)
        self.valueArray?.append(Constants.sharedInstance.email)
        self.valueArray?.append(Constants.sharedInstance.doj)
        self.valueArray?.append(settingObject?.temperatureDisplayUnit ?? "none")
        self.valueArray?.append(settingObject?.sounds.description ?? "none")
        self.valueArray?.append(settingObject?.notifications.description ?? "none")
        self.valueArray?.append(settingObject?.probationEndDate ?? "none")
        self.valueArray?.append(durationFromDates(fromDate: startDate!, toDate: endDate))
        self.valueArray?.append(endDate.returnNextDate().dateToString())
        self.valueArray?.append(sixMonthsDuratinString)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingDetailsViewCell", for: indexPath)

        let detailLabel = cell.viewWithTag(101) as! UILabel
        let valueLabel = cell.viewWithTag(102) as! UILabel
        detailLabel.text = detailsArray[indexPath.row]
        if let valueString = valueArray?[indexPath.row]{
            valueLabel.text = valueString
        }
        return cell
    }
    
    func durationFromDates(fromDate: Date, toDate: Date) -> String{
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let intermediateDate = calendar.startOfDay(for: fromDate)
        let date2 = calendar.startOfDay(for: toDate)
        let date1 = intermediateDate.returnPreviousDate()
        
        let components = calendar.dateComponents([.month, .day], from: date1, to: date2)
        let daysString = "\(String(describing: components.month!)) months \(String(describing: components.day!)) days"
        if (components.month! >= 6){
            sixMonthsDuratinString = "More than 6 months"
        }
        else{
            sixMonthsDuratinString = "Less than 6 months"
        }
        return daysString
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
