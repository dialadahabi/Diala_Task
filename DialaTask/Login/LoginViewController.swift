//
//  LoginViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    //Mark:- IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark:- IBActions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
    }
    

}

