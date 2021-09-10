//
//  RegisterViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit
import CoreData
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    //Mark:- IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var ageErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    private let coreDataContextProvider = CoreDataContextProvider.shared
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.setTitleColor(.gray, for: .disabled)
        setupBindings()
    }
    
    func setupBindings() {
        
        ageTextField.rx.text
            .compactMap({$0})
            .bind(to: viewModel.ageSubject)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .compactMap({$0})
            .bind(to: viewModel.emailSubject)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .compactMap({$0})
            .bind(to: viewModel.passwordSubject)
            .disposed(by: disposeBag)
                        
        viewModel.isValidPassword
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                self?.passwordErrorLabel.text = "Password should be between 6 and 12 characters."
                self?.passwordErrorLabel.isHidden = value
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidAge
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                self?.ageErrorLabel.text = "Age should be between 18 and 99 characters."
                self?.ageErrorLabel.isHidden = value
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidEmail
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                self?.emailErrorLabel.text = "Invalid email."
                self?.emailErrorLabel.isHidden = value
            })
            .disposed(by: disposeBag)
        
        viewModel.isValidForm.bind(to: registerButton.rx.isEnabled).disposed(by: disposeBag)

        registerButton.rx.tap
            .flatMap(viewModel.register)
            .subscribe(onNext: { [weak self] user in
                guard let self = self else {return}
                let unitOfWork = UnitOfWork(context: self.coreDataContextProvider.newBackgroundContext())
                if unitOfWork.userRepository.userAlreadyExists(user: user) {
                    let alert = UIAlertController(title: "Error", message: "User already exists!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                unitOfWork.userRepository.create(user: user)
                unitOfWork.saveChanges()
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.present(homeVC, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
}
