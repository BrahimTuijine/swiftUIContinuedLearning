//
//  PhotoModelCacheManager.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 31/10/2024.
//

import Foundation
import SwiftUI


class PhotoModelCacheManager {
    static let instance = PhotoModelCacheManager()
    
    
    private init() {
        
    }
    
    var imageCache : NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200Mb
        return cache
    }()
    
    func add(image: UIImage, name: String) -> Void {
        imageCache.setObject(image, forKey: name as NSString)
        print("added to Cache")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}

