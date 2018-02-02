//
//  CategoryTableViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 04/12/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    var categoriesData = [Categories]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        createSearchFunction()
        setNavBarProperties()
    }
    
    func setNavBarProperties() {
        title = "Music Categories"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createSearchFunction() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self as? UISearchResultsUpdating
        self.navigationItem.searchController = search
        search.obscuresBackgroundDuringPresentation = ((false as? UISearchResultsUpdating) != nil)
        search.searchBar.placeholder = "Search categories"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController, let vc = nav.viewControllers.first as? ViewController, let quizData = sharedQuizData.popLast() {
            vc.quizData = quizData
        }
    }
    
    private func loadCategories() {
        guard let currentMusic = Categories(name: "Current Music", subtitle: "Trivia round all about todays music") else { fatalError("cannot load category")
        }
        
        guard let ninetiesMusic = Categories(name: "90's Music", subtitle: "Trivia round including some of the big names of the 90s") else { fatalError("cannot load category")
        }
        
        guard let noughtiesMusic = Categories(name: "Noughties", subtitle: "Trivia round discussing the noughties") else { fatalError("cannot load category")
        }
        
        guard let eightiesMusic = Categories(name: "80's Music", subtitle: "Trivia round all about todays music") else { fatalError("cannot load category")
        }

        guard let seventiesMusic = Categories(name: "70's Music", subtitle: "Trivia round all about todays music" ) else { fatalError("cannot load category")
        }

        guard let indieMusic = Categories(name: "Indie Music", subtitle: "Trivia round all about todays music") else { fatalError("cannot load category")
        }
        
        guard let hipHopMusic = Categories(name: "Hip Hop Music", subtitle: "Trivia round all about todays music") else { fatalError("cannot load category")
        }

        categoriesData += [currentMusic, ninetiesMusic, noughtiesMusic, eightiesMusic, seventiesMusic, indieMusic, hipHopMusic]
    }

}

extension CategoryTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CategoryTableViewCell"
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoryTableViewCell else { fatalError("The dequeued cell is not an instance")
        }
        let category = categoriesData[indexPath.row]
        categoryCell.categoryNameLabel.text = category.name
        categoryCell.categorySubtitleLabel.text = category.subtitle
        return categoryCell
    }
}

extension CategoryTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCell
        let extractString = cell?.categoryNameLabel.text
        sharedQuizData = QuizData.loadInQuizData(forFileNamed: extractString ?? "")
        self.performSegue(withIdentifier: "loadQuestions", sender: self)
    }
}
