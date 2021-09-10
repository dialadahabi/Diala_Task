//
//  HomeViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import Foundation
import UIKit
import RxSwift


class HomeViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    private var homeListVM: HomeListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeListVM == nil ? 0: (self.homeListVM?.homeVM.count ?? 0)
    }
    
    private func populateNews() {
        
        guard let pixabayURL = URL(string: Configuration.pixabayURL) else {return}
        let resource = Resource<PhotoResponse>(url: pixabayURL)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { response in
                
                let photos = response.hits
                self.homeListVM = HomeListViewModel(photos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }).disposed(by: disposeBag)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
            fatalError("HomeTableViewCell is not found")
        }
        
        let homeVM = self.homeListVM?.photoAt(indexPath.row)
        
        homeVM?.userPhoto.asDriver(onErrorJustReturn: UIImage())
            .drive(cell.photo.rx.image)
            .disposed(by: disposeBag)
        
        homeVM?.user.asDriver(onErrorJustReturn: "")
            .drive(cell.username.rx.text)
            .disposed(by: disposeBag)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
