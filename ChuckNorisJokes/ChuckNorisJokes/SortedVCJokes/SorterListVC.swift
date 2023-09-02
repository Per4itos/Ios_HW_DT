//
//  JokesListViewController.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 28.08.2023.
//

import UIKit
import RealmSwift

class SortedListVC: UIViewController {
    
    var categoryArray = [String]()
    let realmService = RealmService()
    let networkService = NetworkService()
    let sortedJokesTableViewCell = SortedJokesTableViewCell()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SortedJokesTableViewCell.self, forCellReuseIdentifier: "JokeCategoryCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupJokesCategory()
        print("CATEGORY LIST !!!! \n", categoryArray)
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 65),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
    }
    
    
    func setupJokesCategory() {
        
        let realm = try! Realm()
        
        let categoryRealm = realm.objects(JokeCategoryModel.self)
        
        networkService.fetchCategories { category in
            
            DispatchQueue.main.async { [self] in
            guard let newCategory = category else { return }
                realmService.createJokesCategory(category: newCategory.categories)
                
                categoryRealm.forEach { categoryOnRealm in
                    self.categoryArray.append(categoryOnRealm.category)
                }
        }
    
        }
        
        print("CATEGORY LIST ON FUNCTION!!!! \n", categoryArray)
        tableView.reloadData()

    }
}

extension SortedListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCategoryCell", for: indexPath) as! SortedJokesTableViewCell
        
        let category = categoryArray[indexPath.row]
        
        cell.configure(category: category)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    
    
    
    
}
