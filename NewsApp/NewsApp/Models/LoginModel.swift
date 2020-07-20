//
//  LoginModel.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 14/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class BaseReponseModel : Decodable{
    var status:Int?
    var message:String?
    
    init(status:Int? ,message:String?) {
        self.status = status
        self.message = message
    }
}

class LoginModel: BaseReponseModel {

    var email:String?
    var password:String?
    
    init(email:String? ,password:String?) {
        super.init(status: nil, message: nil)
        self.email = email
        self.password = password
    }
        
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
}
