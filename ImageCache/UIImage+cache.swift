//
//  UIImage+cache.swift
//  RobotCheck
//
//  Created by yuxiao on 2021/1/23.
//  Copyright © 2021 Yulong Xiao. All rights reserved.
//

import UIKit

class ImageDownloadError: Error {
    
}

extension UIImage {
    func asycDownload(with url: URL, complation: @escaping (UIImage?, Error?) -> Void) {
        if let image = ImageCache.shared.imageFor(url: url) {
            complation(image, nil)
        } else {
            DispatchQueue.global().async {
                if let image = UIImage(contentsOfFile: url.absoluteString) {
                    DispatchQueue.main.async {
                        ImageCache.shared.set(image: image, for: url)
                        complation(image, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        complation(nil, ImageDownloadError())
                    }
                }
            }
        }
    }
}
