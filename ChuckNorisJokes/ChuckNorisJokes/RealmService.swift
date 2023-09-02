//
//  RealmService.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 23.08.2023.
//

import Foundation
import RealmSwift

class JokeCategoryModel: Object {
    @objc dynamic var category: String = ""
}

class JokeModel: Object  {
    
    @objc dynamic var icon_url: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var value: String = ""
    @objc dynamic var date: String = ""
}

final class RealmService {
    
    let realm = try! Realm()
    
    func createJokesCategory(category: String) {
        let categoryJokes = JokeCategoryModel()
        
        categoryJokes.category = category
        
        try! realm.write{
            realm.add(categoryJokes)
        }
        
    }
    
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
        
        guard let deletJoke = realm.objects(JokeModel.self).filter("id == %@", id).first else {
            return
        }
            try! realm.write {
                realm.delete(deletJoke)
            }
    }
}
