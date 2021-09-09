//
//  RegisterViewController.swift
//  DialaTask
//
//  Created by Diala Aldahabi on 10/09/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //Mark:- IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var ageErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark:- IBActions

    @IBAction func registerButtonPressed(_ sender: UIButton) {
    }
    
}
