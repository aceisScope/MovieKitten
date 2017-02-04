//
//  APIWrapper.swift
//  MovieKitten
//
//  Created by Binghui Liu on 2017/1/31.
//  Copyright © 2017年 Binghui Liu. All rights reserved.
//

import UIKit
import Foundation

class APIWrapper: NSObject {
    typealias Response = (_ data: Any?, _ error: Error?) -> Void
    
    static func search(title: String, page: Int = 1, completion: @escaping Response) {
        let url = URL(string: "https://www.omdbapi.com/?s=\(title)&page=\(page)")!
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completion(json, nil)
                }
            } catch let error {
                completion(nil, error)
            }
        })
        
        task.resume()

    }

    static func detail(imdbID: String, completion: @escaping Response) {
        let url = URL(string: "https://www.omdbapi.com/?i=\(imdbID)&plot=full&r=json")!
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print(datastring)

                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: Any] {
                    completion(json, nil)
                }
            } catch let error {
                completion(nil, error)
            }
        })

        task.resume()

    }
}
