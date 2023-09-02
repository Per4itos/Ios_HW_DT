//
//  ViewController.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 22.08.2023.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let jokesTableViewCell = JokesTableViewCell()
    let realmService = RealmService()
    let networkService = NetworkService()
    
    var jokesArray: [JokeModel] = []
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JokesTableViewCell.self, forCellReuseIdentifier: "JokeCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Random Jokes"
        setupView()
        setupJockesArray()
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
    
    
    func setupJockesArray() {
        let realm = try! Realm()
        
        let allJokes = Array(realm.objects(JokeModel.self)) //получаем из бд все имеющиеся шутки
        
        let newJokes = allJokes.filter { joke in //фильтруем
            !self.jokesArray.contains(where: { $0.id == joke.id })
            
        }
        jokesArray.append(contentsOf: newJokes) // Добавляем новые объекты в массив jokesArray
        tableView.reloadData() // Обновляем таблицу
    }
    
    func getCurrentTime() -> String {  //получаем текущее время нужного формата
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"
        let currentDate = Date()
        let currentTimeString = dateFormatter.string(from: currentDate)
        
        return currentTimeString
    }
    
    @IBAction func jokesAddButtonAction(_ sender: UIBarButtonItem) { // нажимаем на плюс
        let getTime = self.getCurrentTime() // получаем время из функции выше
        
        networkService.downLoadRandomJokes { joke in // обращаемся к апи
            DispatchQueue.main.async { [self] in
                
                self.realmService.createJoke(icon_url: joke?.icon_url ?? "", //заполняем модель шутки полученными данными и добавляем ее в нашу базу данных (реалм)
                                             id: joke?.id ?? "",
                                             value: joke?.value ?? "",
                                             date: getTime)
                
                self.setupJockesArray() // запускаем функцию добавления шутки во временный массив
                self.jokesArray.sort(by: { $0.date > $1.date})
                tableView.reloadData()
                NotificationCenter.default.post(name: Notification.Name("reloadJoke"), object: nil)
            }
            
        }
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        jokesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as! JokesTableViewCell
        
        let jokes = jokesArray[indexPath.row]
//        cell.textLabel?.text = jokes.value
//        cell.detailTextLabel?.text = jokes.date
        cell.configure(title: jokes.value, subtitleText: jokes.date, id: jokes.id)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let cell = tableView.cellForRow(at: indexPath) as! JokesTableViewCell
            let id = cell.id
            
            realmService.deleteJoke(id: id)
            
        }
        
        self.jokesArray = [JokeModel]()
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
        tableView.endUpdates()
        
        DispatchQueue.main.async{
            self.setupJockesArray() 
        }
    }
}
    

