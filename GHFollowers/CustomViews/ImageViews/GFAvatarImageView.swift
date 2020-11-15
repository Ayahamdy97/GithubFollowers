//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Aya on 10/11/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let placeHolderImage = Image.placeholder
    let cache = NetworkManager.shared.cache
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure()  {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    func downloadImage(fromUrl url: String){
           NetworkManager.shared.downloadImage(from: url) { [weak self] image in
               guard let self = self else{return}
               DispatchQueue.main.async {
                   self.image = image
               }
           }
       }
}
