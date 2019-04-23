//
//  SettingTableViewCell.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 22/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

protocol SwichValueChangedDelegate: class{
    func switchValueChanged(value: Bool, tag: Int)
}

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var offOnSwitch: UISwitch!
    weak var delegate: SwichValueChangedDelegate?
    
    override func awakeFromNib() {
        self.offOnSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        super.awakeFromNib()
        // Initialization code
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        delegate?.switchValueChanged(value: mySwitch.isOn, tag: mySwitch.tag)
        // Do something
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
