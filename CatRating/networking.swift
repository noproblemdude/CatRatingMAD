//
//  networking.swift
//  CatRating
//
//  Created by Leonard Roland on 13.01.24.
//

import Foundation

class networking{
    
    let session = URLSession(configuration: .default)
    
    let url = URL(string: "https://api.thecatapi.com/v1/images/search")!
    let factUrl = URL(string: "https://catfact.ninja/fact")!
    
    
    
    func getCatPic(CompletionHandler: @escaping ((Data?)->Void)){
        
        var picinfo: picInfo?
        var urlReq = URLRequest(url: url)
        urlReq.httpMethod = "GET"
        
        let task = session.dataTask(with: urlReq){
            data,response,error in
            let decoder = JSONDecoder()
            picinfo = try! decoder.decode([picInfo].self, from: data!)[0]
            let imagetask = self.session.dataTask(with: URL(string: picinfo!.url)!){
                data,response,error in
                CompletionHandler(data)
            }
            imagetask.resume()
        }
        
        task.resume()
        
        
    }
    
    func getCatFact(CompletionHandler: @escaping ((catFact?)->Void)){
        
        var fact:catFact?
        var urlReq = URLRequest(url: factUrl)
        urlReq.httpMethod = "GET"
        
        let task = session.dataTask(with: urlReq){
            data,response,error in
            let decoder = JSONDecoder()
            fact = try! decoder.decode(catFact.self, from: data!)
            CompletionHandler(fact)
        }
        
        task.resume()
        
    }
}

struct picInfo: Decodable{
    let id: String
    let url: String
    let width: Int
    let height: Int
}

struct catFact: Decodable{
    let fact: String
    let length: Int
}
