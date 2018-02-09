//
//  CollectionViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 05/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit
import CardsLayout

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var categoriesData = [Categories]()
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        collectionView.collectionViewLayout = CardsCollectionViewLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.green
    }
    
    var colors: [UIColor]  = [
        UIColor(red: 237, green: 37, blue: 78),
        UIColor(red: 249, green: 220, blue: 92),
        UIColor(red: 194, green: 234, blue: 189),
        UIColor(red: 1, green: 25, blue: 54),
        UIColor(red: 255, green: 184, blue: 209)
    ]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = categoriesData[indexPath.row]
        cell.layer.cornerRadius = 7.0
        cell.backgroundColor = colors[indexPath.row]
        cell.categoryName.text = category.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CategoriesCollectionViewCell
        let extractString = cell?.categoryName.text
        sharedQuizData = QuizData.loadInQuizData(forFileNamed: extractString ?? "")
        self.performSegue(withIdentifier: "loadQuestions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers.first as? ViewController, let quizData = sharedQuizData.popLast() {
            vc.quizData = quizData
        }
    }
    
    private func loadCategories() {
        guard let currentMusic = Categories(name: "Current Music") else { fatalError("cannot load category")
        }
        
        guard let ninetiesMusic = Categories(name: "90's Music") else { fatalError("cannot load category")
        }
        
        guard let noughtiesMusic = Categories(name: "Noughties") else { fatalError("cannot load category")
        }
        
        guard let eightiesMusic = Categories(name: "80's Music") else { fatalError("cannot load category")
        }
        
        guard let seventiesMusic = Categories(name: "70's Music") else { fatalError("cannot load category")
        }
        
        guard let indieMusic = Categories(name: "Indie Music") else { fatalError("cannot load category")
        }
        
        guard let hipHopMusic = Categories(name: "Hip Hop Music") else { fatalError("cannot load category")
        }
        
        categoriesData += [currentMusic, ninetiesMusic, noughtiesMusic, eightiesMusic, seventiesMusic, indieMusic, hipHopMusic]
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255 ,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: 1.0)
    }
}
