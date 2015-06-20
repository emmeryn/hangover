//
//  ImageCache.swift
//  Hangover
//
//  Created by Peter Sobot on 6/20/15.
//  Copyright © 2015 Peter Sobot. All rights reserved.
//

import Cocoa

class ImageCache {
    static let sharedInstance = ImageCache()

    //  TODO: This is real dumb. Make this an LRU cache, flush to disk, or something.
    private var cache = Dictionary<UserID, NSImage>()

    func putImage(image: NSImage, forUser user: User) {
        cache[user.id] = image
    }

    func getImage(forUser user: User) -> NSImage? {
        return cache[user.id]
    }

    func fetchImage(forUser user: User, cb: ((NSImage?) -> Void)?) {
        if let existingCachedImage = getImage(forUser: user) {
            cb?(existingCachedImage)
            return
        }

        if let photo_url = user.photo_url, let url = NSURL(string: photo_url) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response, data, error) -> Void in
                if let data = data {
                    let image = NSImage(data: data)
                    self.cache[user.id] = image
                    cb?(image)
                }
            }
        } else {
            cb?(nil)
        }
    }
}