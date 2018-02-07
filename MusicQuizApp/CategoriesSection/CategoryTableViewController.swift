//
//  CategoryTableViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 04/12/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit

var categoriesData = [Categories]()

class CategoryTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let category = categoriesData[indexPath.row]
        collectionCell.categoryName.text = category.name
        
        return collectionCell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers.first as? ViewController, let quizData = sharedQuizData.popLast() {
            vc.quizData = quizData
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoryTableViewCell"
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryTableViewCell else { fatalError("The dequeued cell is not an instance")
        }
        return categoryCell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CategoryTableViewCell {
            cell.collectionView.dataSource = self
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width
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

   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell
        let extractString = cell?.categoryNameLabel.text
        sharedQuizData = QuizData.loadInQuizData(forFileNamed: extractString ?? "")
        self.performSegue(withIdentifier: "loadQuestions", sender: self)
    }*/
