//
//  CollectionViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 31/01/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//
/*
import UIKit
class CollectionViewController: UICollectionViewController {
    
    var categoriesData = [Categories]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.title = "Categories"
        collectionView?.backgroundColor = UIColor.red
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = "CategoryTableViewCell"
        let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CategoryTableViewCell
        let category = categoriesData[indexPath.row]
        categoryCell?.categoryNameLabel.text = category.name
        categoryCell?.categorySubtitleLabel.text = category.subtitle
        categoryCell?.backgroundColor = UIColor.white
        return (categoryCell)!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
*/
