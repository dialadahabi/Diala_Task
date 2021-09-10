//
//  LoginViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
import CoreData

class LoginViewController: UIViewController {
    
    //Mark:- IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    private let viewModel = LoginViewModel()
    
    private let userRepository = UserRepository(context: CoreDataContextProvider.shared.newBackgroundContext())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.setTitleColor(.gray, for: .disabled)
        setupBindings()
    }
    
    func setupBindings() {
        emailTextField.rx.text.bind(to: viewModel.emailSubject).disposed(by: disposeBag)
        passwordTextField.rx.text.bind(to: viewModel.passwordSubject).disposed(by: disposeBag)
        
        viewModel.isValidForm.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        loginButton.rx.tap
            .flatMap(viewModel.login)
            .subscribe(onNext: { [weak self] user in
                guard let email = user.email else {return}
                self?.get(email: email)
            })
            .disposed(by: viewModel.disposeBag)
        
        registerButton.rx.tap
            .asDriver()
            .drive(){ [weak self] _ in
                let registerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                self?.present(registerVC, animated: true, completion: nil)
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    func get(email: String) {
        switch userRepository.getUser(predicate: NSPredicate(format: "email = %d", argumentArray: [email])) {
        case .success(let fetchedUsers):
            if fetchedUsers.first?.password == viewModel.passwordSubject.value {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                present(homeVC, animated: true, completion: nil)
            } else {
                loginErrorLabel.text = "Invalid email or password."
                loginErrorLabel.isHidden = false
            }
        case .failure: break
        }
    }

}

