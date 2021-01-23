//
//  ImageCache.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/1/23.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit

private let imageCacheCapacity = 10

class ImageCache {
    static let shared = ImageCache()
    
    private var dic = [URL:UIImage]()
    private var LRUArray = [URL]()
    private init() {
        
    }
    
    func imageFor(url: URL) -> UIImage? {
        if let image = dic[url] {
            bringURLToFront(url: url)
            return image
        } else {
            return nil
        }
    }
    
    func set(image: UIImage, for url: URL) {
        bringURLToFront(url: url)
        dic[url] = image
        
    }
    
    private func bringURLToFront(url: URL) {
        if let index = LRUArray.firstIndex(of: url) {
            LRUArray.remove(at: index)
        } else {
            removeImageIfNeed()
        }
        LRUArray.insert(url, at: 0)
    }
    
    private func removeImageIfNeed() {
        if LRUArray.count > imageCacheCapacity {
            let url = LRUArray.removeLast()
            dic[url] = nil
        }
    }
}
