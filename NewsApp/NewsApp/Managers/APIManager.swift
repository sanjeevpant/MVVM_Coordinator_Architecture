//
//  APIManager.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 14/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class APIManager: NSObject {

    typealias loginCompletionHandler = (Any?,String?,Int?) -> Void
    
    func logInService(model :LoginModel ,_ handler: @escaping loginCompletionHandler){
        
        if model.email == "Rahul.r@gmail.com" && model.password == "demo"{                            handler(model,"User successfully signed-in" ,200)
        }
        else{
            handler(nil,"Wrong Credentials" ,400)
        }
        
        let url = URL.init(string: Constants.baseUrlLogin + "Email=\(model.email ?? ""   )&Password=\(model.password ?? "")")
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if error == nil , let data = data{
//                do{
//                    let result = try JSONDecoder().decode(LoginModel.self, from: data)
//                    result.status = (response as? HTTPURLResponse)?.statusCode
//                    result.message = error?.localizedDescription
//                    DispatchQueue.main.async {
//                        handler(result,nil,nil)
//                    }
//                }
//                catch let jsonError{
//                    debugPrint("Error in serialising the response\(jsonError.localizedDescription)")
//                }
//            }
//            else{
//                handler(nil,error?.localizedDescription,(response as? HTTPURLResponse)?.statusCode)
//            }
//        }.resume()
    }
    
    
    func getNewsFromServer(_ handler: @escaping (NewsViewModel? , Error?) -> Void){
        let url = URL(string: Constants.NEWS_BASE_URL)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil , let data = data{
                do{
                    let result = try JSONDecoder().decode(NewsViewModel.self, from: data)
                    result.statusCode = (response as? HTTPURLResponse)?.statusCode
                    result.message = error?.localizedDescription
                    DispatchQueue.main.async {
                        handler(result,nil)
                    }
                }
                catch let jsonError{
                    debugPrint("Error in serialising the response\(jsonError.localizedDescription)")
                }
            }
            else{
                handler(nil, error)
            }
        }.resume()
    }
    
}



struct Constants {
    static let baseUrlLogin = "http://184.106.114.93/DemoApp/Login?"
    static let NEWS_BASE_URL = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(API_KEY)"
    static let API_KEY = "e1674fdcfa564b3e978cab9c4cffe750"
}
