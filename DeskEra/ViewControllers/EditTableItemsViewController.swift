//
//  EditTableItemsViewController.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

protocol EditItemsDelegate: class{
    func updateTableView(index:Int, name:String)
}

class EditTableItemsViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    var nameString : String?
    var indexValue : Int?
    weak var delegate: EditItemsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.text = nameString
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editName(_ sender: UIBarButtonItem) {
        switch sender.tag {
        case 1:
            sender.title = "Save"
            self.nameTextField.isEnabled = true
            sender.tag = 2
        case 2:
            sender.title = "Edit"
            sender.tag = 1
            self.nameTextField.isEnabled = false
            delegate?.updateTableView(index: indexValue!, name: nameTextField.text!)
            self.navigationController?.popViewController(animated: true)
        default:
            print("nothing")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
