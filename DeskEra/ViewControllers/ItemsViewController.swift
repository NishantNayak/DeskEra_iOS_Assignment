//
//  ItemsViewController.swift
//  DeskEra
//
//  Created by Nayak, Nishant (external - Project) on 20/04/19.
//  Copyright © 2019 Nayak, Nishant (external - Project). All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, AddFavoriteInViewDelegate {

    struct System {
        static func clearNavigationBar(forBar navBar: UINavigationBar) {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
            navBar.isTranslucent = true
        }
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    var lastContentOffset: CGFloat = 0
    var cellIndex = 0
    var direction = ""
    
    var button1: UIButton?
    var button2: UIButton?
    var button3: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.navigationController else { return }
        System.clearNavigationBar(forBar: navigationController.navigationBar)
        navigationController.view.backgroundColor = .clear
        self.headerView.layer.borderColor = UIColor.lightGray.cgColor
        self.headerView.layer.borderWidth = 0.5
        initializeItems()
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height)
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        self.collectionView.isScrollEnabled = false
        button1 = self.view.viewWithTag(100) as! UIButton
        button2 = self.view.viewWithTag(101) as! UIButton
        button3 = self.view.viewWithTag(102) as! UIButton
        
        addSwipe()
        // Do any additional setup after loading the view.
    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizer.Direction] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer.init()
            gesture.addTarget(self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.collectionView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            //right swipe
            if cellIndex > 0{
                let indexPath = IndexPath.init(row: cellIndex-1, section: 0)
                cellIndex -= 1
                self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            }
        case .left:
            //left swipe
            if cellIndex < 2{
                let indexPath = IndexPath.init(row: cellIndex+1, section: 0)
                cellIndex += 1
                self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
            }
        default:
            print("default")
        }
        switch cellIndex {
        case 0:
            button1!.isSelected = true
            button2!.isSelected = false
            button3!.isSelected = false
        case 1:
            button1!.isSelected = false
            button2!.isSelected = true
            button3!.isSelected = false
        case 2:
            button1!.isSelected = false
            button2!.isSelected = false
            button3!.isSelected = true
        default:
            print("default")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    func initializeItems(){
        let item1 = Item.init(itemName: "NameOne", itemDescription: "DescriptionOne", itemCategory: .A, isFavorite: false)
        Constants.sharedInstance.itemArray.append(item1)
        let item2 = Item.init(itemName: "NameTwo", itemDescription: "DescriptionTwo", itemCategory: .B, isFavorite: false)
        Constants.sharedInstance.itemArray.append(item2)
        let item3 = Item.init(itemName: "NameThree", itemDescription: "DescriptionThree", itemCategory: .A, isFavorite: false)
        Constants.sharedInstance.itemArray.append(item3)
    }
    
    func addFavoriteToView(name: String, seleted: Bool) {
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
        self.collectionView.reloadData()
    }

    @IBAction func categoryButtonClicked(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            let indexPath = IndexPath.init(row: 0, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
            cellIndex = 0
            button1!.isSelected = true
            button2!.isSelected = false
            button3!.isSelected = false
        case 101:
            let indexPath = IndexPath.init(row: 1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
            cellIndex = 1
            button1!.isSelected = false
            button2!.isSelected = true
            button3!.isSelected = false
        case 102:
            let indexPath = IndexPath.init(row: 2, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .right, animated: false)
            cellIndex = 2
            button1!.isSelected = false
            button2!.isSelected = false
            button3!.isSelected = true
        default:
            print("default")
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

extension ItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemsCollectionViewCell", for: indexPath) as! ItemsCollectionViewCell
        cell.itemsArrayInCollectionCell = Constants.sharedInstance.itemArray
        cell.itemIndex = indexPath.row
        cell.divideCategories()
        cell.delegate = self
        cell.tableView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

}
