//
//  LoginViewModel.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let emailSubject = BehaviorRelay<String?>(value: nil)
    let passwordSubject = BehaviorRelay<String?>(value: nil)
    let disposeBag = DisposeBag()
    
    var isValidForm: Observable<Bool> {

        return Observable.combineLatest(emailSubject, passwordSubject) {email, password in
            guard !(email?.isEmpty ?? false) && !(password?.isEmpty ?? false) else {
                return false
            }
            return true
        }
    }
    
    func login() -> Observable<User> {
      return Observable.combineLatest(emailSubject, passwordSubject)
        .take(1)
        .flatMap { [weak self](_, _) -> Observable<User> in
            Observable.just(User(email: self?.emailSubject.value, password: self?.passwordSubject.value, age: nil))
        }
    }
}
