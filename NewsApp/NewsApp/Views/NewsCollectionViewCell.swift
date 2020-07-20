//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Sanjeev Pant on 19/07/20.
//  Copyright © 2020 Sanjeev Pant. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    var label:UILabel =  UILabel.init()
    var imageView:UIImageView =  UIImageView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12.0 , weight: .bold))
        label.textColor = .black
        label.numberOfLines = 0
        imageView.layer.cornerRadius = 5.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        let stackView = UIStackView.init(arrangedSubviews: [imageView,label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(5.0, after: imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = #imageLiteral(resourceName: "PlaceHolderImage")
    }
    
    func updateView(_ model:NewsModel){
        label.text = model.title
    }
    
}
