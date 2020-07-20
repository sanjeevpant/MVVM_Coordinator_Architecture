//
//  Utility.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 20/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class Utility: NSObject {
    static func showAlertWithTitle(_ title:String ,_ description:String, _ controller:UIViewController?){
        
        let noInternetAlert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        noInternetAlert.addAction(alertAction)
        controller?.present(noInternetAlert, animated: true, completion: nil)
    }
}
