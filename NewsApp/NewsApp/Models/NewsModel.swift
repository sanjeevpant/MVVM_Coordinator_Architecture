//
//  NewsModel.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 19/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class NewsModel: Decodable {
    var author : String?
    var title : String?
    var url : String?
    var urlToImage : String?
    var publishedAt : String?
}
