//
//  Photo.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit

struct PhotoResponse: Decodable {
    let hits: [Photo]
}

struct Photo: Decodable {
    let largeImageURL: String
    let imageSize: Int?
    let type: String?
    let tags: String?
    let user: String?
    let views: Int?
    let likes: Int?
    let comments: Int?
    let downloads: Int?
}

extension Photo {
    
    func getImage() -> UIImage? {
        return UIImage.loadImageUsingCacheWithUrlString(largeImageURL)
    }
}
