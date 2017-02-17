//
//  ImageLoader.swift
//  MovieKitten
//
//  Created by Binghui Liu on 17/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader {

    static let shared = ImageLoader()

    let cache = ImageCache()

    private var memoryWarningObserver: NSObjectProtocol!

// MARK: - Lifecycle
    private init() {
        memoryWarningObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil, queue: nil) { notification in
            self.cache.removeAllObjects()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(memoryWarningObserver)
    }

    func loadImageFromServerURL(urlString: String, completion: @escaping (_ image: UIImage?, _ url: String) -> Void) {

        let image = cache.object(forKey: urlString as AnyObject)
        if let goodImage = image {
            DispatchQueue.main.async(execute: { () -> Void in
                completion(goodImage, urlString)
            })
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                completion(nil, urlString)
                return
            }

            let image = UIImage(data: data!)
            if let goodImage = image {
                self.cache.setObject(goodImage, forKey: urlString as AnyObject)

                DispatchQueue.main.async(execute: { () -> Void in
                    completion(goodImage, urlString)
                })
            }

        }).resume()
    }

}
