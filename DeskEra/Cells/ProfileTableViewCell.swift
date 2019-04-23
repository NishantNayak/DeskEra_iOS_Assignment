//
//  ProfileTableViewCell.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 22/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

protocol InvalidDataDelegate: class{
    func invalidData(index: Int)
}

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    weak var delegate: InvalidDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueTextField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidJoininghDate(dojString: String) -> Bool{
        let endDate = "30/06/2019"
        if let doj = dojString.stringToDate(){
            if doj < endDate.stringToDate()!{
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }

}

extension ProfileTableViewCell: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        switch textField.tag {
        case 0:
            if isValidEmail(testStr: textField.text!){
                Constants.sharedInstance.email = textField.text!
            }
            else{
                self.delegate?.invalidData(index: 0)
            }
        case 1:
            Constants.sharedInstance.doj = textField.text!
        case 2:
            if isValidJoininghDate(dojString: textField.text!){
                Constants.sharedInstance.hobby = textField.text!
            }
            else{
                self.delegate?.invalidData(index: 1)
            }
        default:
            print("default")
        }
        textField.resignFirstResponder()
        return true
    }
}
