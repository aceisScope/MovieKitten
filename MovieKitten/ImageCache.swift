//
//  ImageCache.swift
//  MovieKitten
//
//  Created by Binghui Liu on 17/02/2017.
//  Copyright © 2017 Binghui Liu. All rights reserved.
//

import Foundation
import UIKit

final class ImageCache: NSCache<AnyObject, UIImage> {

    static let shared = ImageCache()

    private var memoryWarningObserver: NSObjectProtocol!

    override init() {
        super.init()

        /// no need to remove observer in deinit since singleton is never deallocated
        memoryWarningObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil, queue: nil) { notification in
            self.removeAllObjects()
        }
    }

    /// Subscript operation to retrieve and update

    subscript(key: AnyObject) -> UIImage? {
        get {
            return object(forKey: key)
        }

        set (newValue) {
            if let object = newValue {
                setObject(object, forKey: key)
            } else {
                removeObject(forKey: key)
            }
        }
    }
    
}
