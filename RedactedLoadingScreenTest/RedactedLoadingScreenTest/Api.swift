//
//  Api.swift
//  RedactedLoadingScreenTest
//
//  Created by Matthias Zarzecki on 23.11.20.
//

import Foundation

class Api {
 public func getPosts(
   completion: @escaping ([Post]) -> ()
 ) {
   guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
     return
   }
   
   var request = URLRequest(url: url)
   request.httpMethod = "GET"

   URLSession.shared.dataTask(with: request) { (data, _, _) in
     let postGroup = try! JSONDecoder().decode([Post].self, from: data!)
     DispatchQueue.main.async {
       completion(postGroup)
     }
   }
   .resume()
 }
}

struct Post: Codable, Hashable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}
