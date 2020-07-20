//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 19/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class NewsViewModel: Decodable {
    var status : String?
    var statusCode : Int?
    var totalResults : Int?
    var articles : [NewsModel]?
    var message:String?
    
    func getNews(withCompletionHandler completionHandler:@escaping (NewsViewModel? , Error?)-> Void){
        let apiManager = APIManager.init()
        apiManager.getNewsFromServer { (viewModel, error) in
            DispatchQueue.main.async {
                completionHandler(viewModel,error)
            }
        }
    }
}
