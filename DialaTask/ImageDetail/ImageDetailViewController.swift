//
//  ImageDetailViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var photo: Photo?
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var imageSize: UILabel!
    @IBOutlet weak var imageTags: UILabel!
    @IBOutlet weak var imageType: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var amountOfViews: UILabel!
    @IBOutlet weak var amountOfLikes: UILabel!
    @IBOutlet weak var amountOfComments: UILabel!
    @IBOutlet weak var amountOfDownloads: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        photoImageView.image = photo?.getImage()
        imageSize.text = "Size: \(photo?.imageSize ?? 0)"
        imageTags.text = "Tags: \(photo?.tags ?? "")"
        imageType.text = "Type: \(photo?.type ?? "")"
        userName.text = "User: \(photo?.user ?? "")"
        amountOfViews.text = "\(photo?.views ?? 0) Views"
        amountOfLikes.text = "\(photo?.likes ?? 0) Likes"
        amountOfComments.text = "\(photo?.comments ?? 0) Comments"
        amountOfDownloads.text = "\(photo?.downloads ?? 0) Downloads"
    }
    
}
