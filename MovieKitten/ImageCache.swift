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

    /// Observer for `UIApplicationDidReceiveMemoryWarningNotification`.

    private var memoryWarningObserver: NSObjectProtocol!

    /// Note, this is `private` to avoid subclassing this; singletons shouldn't be subclassed.
    ///
    /// Add observer to purge cache upon memory pressure.

    override init() {
        super.init()

        memoryWarningObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil, queue: nil) { notification in
            self.removeAllObjects()
        }
    }

    /// The singleton will never be deallocated, but as a matter of defensive programming (in case this is
    /// later refactored to not be a singleton), let's remove the observer if deallocated.

    deinit {
        NotificationCenter.default.removeObserver(memoryWarningObserver)
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
