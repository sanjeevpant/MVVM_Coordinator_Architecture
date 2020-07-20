//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 14/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {

    typealias authenticateLoginCallBack = (_ status:Bool , _ message:String) -> Swift.Void
    
    var loginCallBack:authenticateLoginCallBack?
    
    func authenticateUser(_ email:String , andPassword password:String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             if !email.isEmpty{
                   if !password.isEmpty{
                       let loginModel = LoginModel.init(email: email, password: password)
                       self.verifyUser(loginModel)
                   }
                   else{
                       self.loginCallBack?(false, "Password cannot be empty")
                   }
               }
               else{
                   self.loginCallBack?(false, "User name cannot be empty")
               }
        }
    }
    
    private func verifyUser(_ model:LoginModel){
        let apiManager = APIManager.init()
        apiManager.logInService(model: model) { (response, message, statusCode) in
            if let _ = response{
                self.loginCallBack?(true, message ?? "")
            }
            else{
                self.loginCallBack?(false, message ?? "")
            }
        }
    }
    
    func loginCompletionHandler(_ callBack:@escaping authenticateLoginCallBack){
        self.loginCallBack = callBack
    }
    
}
