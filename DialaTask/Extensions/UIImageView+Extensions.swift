//
//  UIImageView+Extensions.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImage {
    static func loadImageUsingCacheWithUrlString(_ urlString: String) -> UIImage {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            return cachedImage
        }

        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                }
            })

        }).resume()
        return UIImage()
    }
}
