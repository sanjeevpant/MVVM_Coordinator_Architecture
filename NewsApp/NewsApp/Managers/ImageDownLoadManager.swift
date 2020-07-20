//
//  ImageDownLoadManager.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 19/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class ImageDownloadManager: NSObject {
    
   static let shared = ImageDownloadManager()
   
   //For Caching Images
   let imageCache = NSCache<NSString, UIImage>()

    private override init() {
    
    }
    
    
    /**
     This method download the image for the specified image model that conatins image url
     and returns the image in completion block
     */
    func downloadImageForModel(_ indexPath : IndexPath,_ imageModel: NewsModel, completion: @escaping (_ indexPath : IndexPath, _ image: UIImage?, _ error: Error?  ) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: (imageModel.urlToImage ?? "") as NSString) {
            completion(indexPath,cachedImage, nil)
        } else {
        
            downloadDataForModel(imageModel, completion: { (image, error) in
                completion(indexPath, image, error)

            })
        
        }
    }
    
     func downloadDataForModel(_ imageModel: NewsModel ,completion:@escaping ((UIImage,Error?)->()) ){
     
        if let url = URL(string: String(imageModel.urlToImage ?? "")){
            
            
           let downloadTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                            
                //error Handling
                if let error = error {
                    dump(error)
                    return
                }
                
            if data != nil{
                
                if let downloadedImage = UIImage(data: data!) {
                    self.imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                    completion(downloadedImage,nil)
                    
                }
            }
           })
            
            downloadTask.resume()
        }

            
        }
        
}
