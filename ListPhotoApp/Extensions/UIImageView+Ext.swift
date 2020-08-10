//
//  UIImageView+Ext.swift
//  ListPhotoApp
//
//  Created by Macintosh HD on 8/8/20.
//  Copyright © 2020 Macintosh HD. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

var imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView {
    var imageURL : URL?
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) { 
        contentMode = mode
        imageURL = url
        image = nil
        
        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                let imageToCache = image
                if self?.imageURL == url {
                    self?.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: url as AnyObject)
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIImageView {
    func downloadImages(imageURL: String) {
        self.kf.setImage(with: URL(string: imageURL))
    }
}
