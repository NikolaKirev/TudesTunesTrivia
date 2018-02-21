//
//  CollectionViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 05/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var categoriesData = [Category]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        loadCategories()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewIdentifiers.CollectionViewCell.rawValue, for: indexPath) as! CategoriesCollectionViewCell
        let category = categoriesData[indexPath.row]
        cell.layer.cornerRadius = 7.0
        cell.categoryImage.image = category.image
        cell.categoryName.text = category.name
        cell.categoryName.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        cell.categoryName.textColor = UIColor.white
        cell.categoryName.lineBreakMode = .byWordWrapping
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell
        let extractString = cell?.categoryName.text
        sharedQuizData = QuizData.loadInQuizData(forFileNamed: extractString ?? "")
        self.performSegue(withIdentifier: SegueIdentifiers.QuizScreen.rawValue, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: CategorySectionHeader.viewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewIdentifiers.CategorysHeader.rawValue, for: indexPath as IndexPath)
        return headerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers.first as? MainQuizController, let quizData = sharedQuizData.popLast() {
            vc.quizData = quizData
        }
    }
    
    private func loadCategories() {
        guard let currentMusic = Category(name: "Current Music", image: #imageLiteral(resourceName: "eightiesIcon")) else { fatalError("cannot load category")
        }
        
        guard let ninetiesMusic = Category(name: "90's Music", image: #imageLiteral(resourceName: "ninetiesIcon")) else { fatalError("cannot load category")
        }
        
        guard let noughtiesMusic = Category(name: "Noughties", image: #imageLiteral(resourceName: "eightiesIcon")) else { fatalError("cannot load category")
        }
        
        guard let eightiesMusic = Category(name: "80's Music", image: #imageLiteral(resourceName: "eightiesIcon")) else { fatalError("cannot load category")
        }
        
        guard let seventiesMusic = Category(name: "70's Music", image: #imageLiteral(resourceName: "seventiesIcon")) else { fatalError("cannot load category")
        }
        
        guard let indieMusic = Category(name: "Indie Music", image: #imageLiteral(resourceName: "indieIcon")) else { fatalError("cannot load category")
        }
        
        guard let hipHopMusic = Category(name: "Hip Hop Music", image: #imageLiteral(resourceName: "eightiesIcon")) else { fatalError("cannot load category")
        }
        
        categoriesData += [currentMusic, ninetiesMusic, noughtiesMusic, eightiesMusic, seventiesMusic, indieMusic, hipHopMusic]
    }
}
