//
//  RegisterViewModel.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import RxCocoa
import RxSwift

class RegisterViewModel {
    
    let ageSubject = PublishSubject<String>()
    let emailSubject = PublishSubject<String>()
    let passwordSubject = PublishSubject<String>()
    let disposeBag = DisposeBag()
    let minPasswordCharacters = 6
    let maxPasswordCharacters = 12
    let minAge = 18
    let maxAge = 99
    
    lazy var isValidPassword: Observable<Bool> = {
        passwordSubject.map { (value: String) -> Bool in
            value.count >= self.minPasswordCharacters && value.count <= self.maxPasswordCharacters
        }
    }()
    
    lazy var isValidEmail: Observable<Bool> = {
        emailSubject.map { (value: String) -> Bool in
            value.validateEmail()
        }
    }()
    
    lazy var isValidAge: Observable<Bool> = {
        ageSubject.map { (value: String) -> Bool in
            Int(value) ?? 0 >= self.minAge && Int(value) ?? 0 <= self.maxAge
        }
    }()
    
    lazy var isValidForm: Observable<Bool> = {
      Observable.combineLatest(isValidEmail, isValidPassword, isValidAge)
        .map { $0 && $1 && $2}
    }()
    
    func register() -> Observable<User> {
        return Observable.combineLatest(ageSubject.asObservable(), emailSubject.asObservable(), passwordSubject.asObservable()).map { age, email, password in
            return User(email: email, password: password, age: age)
        }
    }
    
}
