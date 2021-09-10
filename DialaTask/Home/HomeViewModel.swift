//
//  HomeViewModel.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct HomeListViewModel {
    let homeVM: [HomeViewModel]
}

extension HomeListViewModel {
    
    init(_ photos: [Photo]) {
        self.homeVM = photos.compactMap(HomeViewModel.init)
    }
    
}

extension HomeListViewModel {
    
    func photoAt(_ index: Int) -> HomeViewModel {
        return self.homeVM[index]
    }
}

struct HomeViewModel {
    
    let photo: Photo
    
    init(_ photo: Photo) {
        self.photo = photo
    }
    
}

extension HomeViewModel {
    
    var userPhoto: Observable<UIImage> {
        return Observable<UIImage>.just(photo.getImage() ?? UIImage())
    }
    
    var user: Observable<String> {
        return Observable<String>.just(photo.user ?? "")
    }
    
}
