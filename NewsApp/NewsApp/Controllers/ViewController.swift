//
//  ViewController.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 14/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit


class ViewController: UIViewController ,StoryBoard {

    //MARK:- Outlets
    @IBOutlet weak var loginField:UITextField!
    @IBOutlet weak var passwordField:UITextField!
    @IBOutlet weak var errorLabel:UILabel!
    
    var loginViewModel = LoginViewModel.init()
    weak var coordinator:MainCoordinator?


    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    private func getData(){
        guard let userName = loginField.text , let password = passwordField.text else { return }
        loginViewModel.authenticateUser(userName, andPassword: password)
        loginViewModel.loginCompletionHandler { [unowned self](status, message) in
                self.errorLabel.isHidden = false
                self.errorLabel.text = message
                if status{
                    self.coordinator?.navigateToNewsVC()
                    _ = KeychainWrapper.standard.set(true, forKey: "isLoggedIn")
                }
        }
    }
    
    //MARK:- Action Methods
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.getData()
    }
    
}

