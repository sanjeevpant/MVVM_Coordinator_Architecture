//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 19/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit
import CoreData

class NewsDetailViewController: UIViewController,StoryBoard {
    weak var coordinator:MainCoordinator?
    weak var newsModel :NewsModel?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = newsModel?.title
        if let cachedImage = ImageDownloadManager.shared.imageCache.object(forKey: (newsModel?.urlToImage ?? "") as NSString) {
            imageView.image = cachedImage
        }
        else {
            ImageDownloadManager.shared.downloadDataForModel(newsModel!) { [weak self](image, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        self?.imageView.image = image
                    }
                    else{
                        self?.imageView.image = #imageLiteral(resourceName: "PlaceHolderImage")
                    }
                }
            }
       
       }

        if !isFavorite(){
            self.saveFavorites()
        }
        else{
            Utility.showAlertWithTitle("Information", "Already added to favorites", self)
        }
    }
    
    private func isFavorite()-> Bool{
        let coreDataModel = CoreDataModel.init()
        let fetchRequst:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Favorites")
        fetchRequst.returnsObjectsAsFaults = false
        fetchRequst.predicate = NSPredicate.init(format: "name == %@", newsModel?.url ?? "")
        
        do{
            let results = try coreDataModel.managedContext.fetch(fetchRequst)
            if !results.isEmpty{
                return true
            }
            return false
        }
        catch{
            debugPrint("Error in fetching")
        }
        return false
    }
    
    private func saveFavorites(){
        let coreDataModel = CoreDataModel.init()
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: coreDataModel.managedContext)
        let favorites = NSManagedObject.init(entity: entity!, insertInto: coreDataModel.managedContext)
        favorites.setValue(newsModel?.url, forKey: "name")
        coreDataModel.saveContext()
        debugPrint("Checl")
    }
}
