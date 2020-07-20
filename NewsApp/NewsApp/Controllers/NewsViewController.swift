//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 17/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController,StoryBoard {
    
    weak var coordinator:MainCoordinator?
    @IBOutlet weak var newsCollectionView:UICollectionView!
    var newsViewModel: NewsViewModel = NewsViewModel.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        self.getDataFromWebService()
    }
    
    private func registerCollectionViewCell(){
         guard let collectionView = newsCollectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let margin: CGFloat = 10
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        newsCollectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: "\(NewsCollectionViewCell.self)")
                
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.isUserInteractionEnabled = true
    }
    
    private func getDataFromWebService(){
        newsViewModel.getNews {[weak self]   (viewModel, error) in
            
            if error != nil{
                Utility.showAlertWithTitle( "Error" , error?.localizedDescription ?? "Error Occurred", self)
                return
            }
            
            if let model = viewModel{
                self?.newsViewModel = model
                self?.newsCollectionView.reloadData()
                return
            }
            Utility.showAlertWithTitle( "Error" , viewModel?.message ?? "No News Available",self)
        }
    }
}

extension NewsViewController: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsViewModel.articles?.count ?? 0
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(NewsCollectionViewCell.self)", for: indexPath) as! NewsCollectionViewCell
       cell.updateView((newsViewModel.articles?[indexPath.row])!)
       return cell
   
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: nil)
        let controller = NewsDetailViewController.instantiate()
        controller.newsModel = newsViewModel.articles?[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: false)
    }
        
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let newsModel = newsViewModel.articles?[indexPath.row]{
                  
                  //Start Downloading Of Image
                  ImageDownloadManager.shared.downloadImageForModel(indexPath ,newsModel, completion: { (indexPath , image , error) in
                      
                      DispatchQueue.main.async {
                          
                          /**If Cell for the specified indexpath for which image has been downloaded exists than only plot the image otherwise next time image will be rendered from cache
                           */
                          
                          if let cell = self.newsCollectionView.cellForItem(at: indexPath) as? NewsCollectionViewCell{
                              
                              if(error == nil){
                                  
                                cell.imageView.image = image
                                  
                              }else{
                                  //Show PlaceHolder On Error
                                  cell.imageView.image = #imageLiteral(resourceName: "PlaceHolderImage")
                              }
                          }
                      }
                  })
                  
              }
    }
    
    
}
