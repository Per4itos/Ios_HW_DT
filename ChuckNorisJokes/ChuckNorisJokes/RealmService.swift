//
//  RealmService.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 23.08.2023.
//

import Foundation
import RealmSwift



class JokeModel: Object  {
    
    @objc dynamic var icon_url: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var date: String = ""
}

final class RealmService {
    
    let realm = try! Realm()
    
    func createJoke(icon_url: String,id: String ,value: String, date: String) {
        
        let newJoke = JokeModel()
        
        newJoke.icon_url = icon_url
        newJoke.id = id
        newJoke.value = value
        newJoke.date = date
        
        try! realm.write {
            realm.add(newJoke)
        }
        
    }
    func deleteJoke(id: String ) {
        
        let newJoke = JokeModel()
        
        newJoke.id = id
    
        try! realm.write {
            realm.delete(newJoke)
        }
        
        
    }
}
