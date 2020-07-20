//
//  MainCoordinator.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 17/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator{
    var childCoordinator: [Coordinator] = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController:UINavigationController) {
        self.navigationController =  navigationController
    }
    
    func navigate() {
        let viewController  = ViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToNewsVC(){
        let viewController  = NewsViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)

    }
    
//    func navigateToNewDetailView(_ viewModel:NewsViewModel?){
//        let viewController  = NewsDetailViewController.instantiate()
//        viewController.coordinator = self
//        viewController.newsViewModel = viewModel
//        navigationController.pushViewController(viewController, animated: true)
//
//    }
}
