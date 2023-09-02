//
//  TargetViewController.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 28.08.2023.
//

import UIKit
import RealmSwift

class SortedDataVC: UIViewController {
    
    var jokesArray: [JokeModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SortedDataCell.self, forCellReuseIdentifier: "JokeCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sorted Jokes"
        setupView()
        getJokes()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "reloadJoke"), object: nil, queue: nil) { _ in
            self.getJokes()
        }
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
    
    private func getJokes() {
        let realm = try! Realm()
        
        let allJokes = Array(realm.objects(JokeModel.self))
        
        let newJoke = allJokes.filter { joke in
            !self.jokesArray.contains(where: { $0.date == joke.date })
        }
        let sortedJokes = newJoke.sorted(by: { $0.date > $1.date })
        
        jokesArray.append(contentsOf: sortedJokes)
        tableView.reloadData()
    }
}


extension SortedDataVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! SortedDataCell
        let joke = jokesArray[indexPath.row]
        cell.configure(title: joke.value, subtitleText: joke.date)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    
    
    
    
}
