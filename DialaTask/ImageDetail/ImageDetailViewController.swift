//
//  ImageDetailViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ImageDetailViewController: UIViewController {
        
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var imageSize: UILabel!
    @IBOutlet weak var imageTags: UILabel!
    @IBOutlet weak var imageType: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var amountOfViews: UILabel!
    @IBOutlet weak var amountOfLikes: UILabel!
    @IBOutlet weak var amountOfComments: UILabel!
    @IBOutlet weak var amountOfDownloads: UILabel!
    
    var viewModel: ImageDetailViewModel?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        retrieveOrDownloadImage(key: viewModel?.photo.largeImageURL ?? "", url: viewModel?.photo.largeImageURL ?? "")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] image in
                self?.photoImageView.image = image
            })
            .disposed(by: disposeBag)
       
        imageSize.text = "Size: \(viewModel?.photo.imageSize ?? 0)"
        imageTags.text = "Tags: \(viewModel?.photo.tags ?? "")"
        imageType.text = "Type: \(viewModel?.photo.type ?? "")"
        userName.text = "User: \(viewModel?.photo.user ?? "")"
        amountOfViews.text = "\(viewModel?.photo.views ?? 0) Views"
        amountOfLikes.text = "\(viewModel?.photo.likes ?? 0) Likes"
        amountOfComments.text = "\(viewModel?.photo.comments ?? 0) Comments"
        amountOfDownloads.text = "\(viewModel?.photo.downloads ?? 0) Downloads"
    }
    
}
