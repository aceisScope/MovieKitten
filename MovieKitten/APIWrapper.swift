//
//  APIWrapper.swift
//  MovieKitten
//
//  Created by Binghui Liu on 2017/1/31.
//  Copyright © 2017年 Binghui Liu. All rights reserved.
//

import UIKit

class APIWrapper: NSObject {
    static func test() {
        let url = URL(string: "https://www.omdbapi.com/?t=star&y=&plot=short&r=json")!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("connection error: \(error)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()

    }
}
