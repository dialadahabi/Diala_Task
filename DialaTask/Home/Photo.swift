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
    let user: String?
}

extension Photo {
    
    func getImage() -> UIImage? {
        guard let imageURL = URL(string: largeImageURL) else {
            return nil
        }
        return UIImage.loadImageUsingCacheWithUrlString(largeImageURL)
    }
}
