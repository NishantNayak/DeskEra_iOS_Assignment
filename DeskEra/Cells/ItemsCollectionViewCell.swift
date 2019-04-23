//
//  ItemsCollectionViewCell.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 21/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

protocol AddFavoriteInViewDelegate: class{
    func addFavoriteToView(name: String, seleted: Bool)
}

class ItemsCollectionViewCell: UICollectionViewCell, FavoritesAddedDelegate {

    @IBOutlet weak var tableView: UITableView!
    var itemsArrayInCollectionCell = Array<Item>()
    var itemsCategoryA = Array<Item>()
    var itemsCategoryB = Array<Item>()
    var itemIndex = 0
    weak var delegate: AddFavoriteInViewDelegate?
    
    func divideCategories(){
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.layoutIfNeeded()
        itemsCategoryA.removeAll()
        itemsCategoryB.removeAll()
        for item in itemsArrayInCollectionCell{
            if (item.itemCategory == Category.A){
                itemsCategoryA.append(item)
            }
            else{
                itemsCategoryB.append(item)
            }
        }
    }
    
    func addFavorite(name: String, seleted: Bool) {
        self.delegate?.addFavoriteToView(name: name, seleted: seleted)
    }
    
}

extension ItemsCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch itemIndex {
        case 0:
            return itemsArrayInCollectionCell.count
        case 1:
            return itemsCategoryA.count
        case 2:
            return itemsCategoryB.count
        default:
            print("default")
        }
        return itemsArrayInCollectionCell.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsTableViewCell", for: indexPath) as! ItemsTableViewCell
        var itemValue: Item? = nil
        switch itemIndex {
        case 0:
            itemValue = itemsArrayInCollectionCell[indexPath.row]
        case 1:
            itemValue = itemsCategoryA[indexPath.row]
        case 2:
            itemValue = itemsCategoryB[indexPath.row]
        default:
            print("nothing")
        }
        cell.nameLabel.text = itemValue?.itemName
        cell.descriptionLabel.text = itemValue?.itemDescription
        cell.categoryLabel.text = itemValue?.itemCategoyString
        if (itemValue?.isFavorite)!{
            cell.favoritesButton.isSelected = true
        }
        else{
            cell.favoritesButton.isSelected = false
        }
        cell.delegate = self
        return cell
    }
    
    
}
