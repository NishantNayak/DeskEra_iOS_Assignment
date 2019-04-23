//
//  ItemsTableViewCell.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

protocol FavoritesAddedDelegate: class{
    func addFavorite(name: String, seleted: Bool)
}

class ItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    weak var delegate: FavoritesAddedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.borderWidth = 1.0
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            sender.tag = 2
            sender.isSelected = true
            delegate?.addFavorite(name: nameLabel.text!, seleted: true)
        case 2:
            sender.tag = 1
            sender.isSelected = false
            delegate?.addFavorite(name: nameLabel.text!, seleted: false)
        default:
            delegate?.addFavorite(name: nameLabel.text!, seleted: false)
        }
        
    }
    
}
