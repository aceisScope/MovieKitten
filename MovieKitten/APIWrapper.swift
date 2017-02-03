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
        let session = URLSession.shared
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
}
