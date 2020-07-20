//
//  Coordinator.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 16/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinator :[Coordinator] { get set}
    
    var navigationController:UINavigationController {get set}
    
    func navigate()
}


protocol StoryBoard {
    static func instantiate()-> Self
}

extension StoryBoard where Self: UIViewController{
    static func instantiate()->Self{
        let id = String(describing: self)
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(identifier: id) as! Self
    }
}
