//
//  NetworkService.swift
//  ChuckNorisJokes
//
//  Created by Адхам Тангиров on 22.08.2023.
//
// https://api.chucknorris.io/jokes/random




import Foundation

struct Joke: Decodable  {
    
    var icon_url: String
    var id: String
    var value: String
}
struct ChuckNorrisCategories: Decodable {
    var categories: String
}


class NetworkService {
    
    func downLoadRandomJokes(complition: @escaping (_ joke: Joke?)-> ()) { // делаем запрос в сеть и захватываем(эскейпинг) шутку
        
        let seesion = URLSession(configuration: .default)
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!
        
        let task = seesion.dataTask(with: url) { data, response, error in
            
            if let error {
                print(error.localizedDescription)
                complition(nil)
                return
            }
            
            let code = (response as? HTTPURLResponse)?.statusCode
            if code != 200 {
                //                print("Status code \(String(describing: code))")
                complition(nil)
                
                return
            }
            
            guard let data else{
                print("Datat is nil")
                complition(nil)
                
                return
            }
            do{
                let answer = try JSONDecoder().decode(Joke.self,
                                                      from: data)
                complition(answer) //получаем если нет ошибок
            }catch  {
                //                print(error.localizedDescription)
                complition(nil)
                
            }
        }
        task.resume()
    }
    
    func fetchCategories(completion: @escaping (ChuckNorrisCategories?) -> Void) {
        let session = URLSession(configuration: .default)
        let url = URL(string: "https://api.chucknorris.io/jokes/categories")!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Data is nil")
                completion(nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(nil)
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                print("Invalid status code: \(httpResponse.statusCode)")
                completion(nil)
                return
            }
            
            do {
                let categories = try JSONDecoder().decode(ChuckNorrisCategories.self, from: data)
                completion(categories)
            } catch {
                print("Error decoding categories: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
}















