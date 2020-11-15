//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Aya on 10/11/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
 static let reuseId     = "FollowerCell"
    let avatarImageview = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower : Follower){
        avatarImageview.downloadImage(fromUrl: follower.avatarUrl)
        usernameLabel.text = follower.login
        
        
    }
    
    
    private func configure(){
        addSubviews(avatarImageview,usernameLabel)
        let padding : CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageview.heightAnchor.constraint(equalTo: avatarImageview.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageview.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
}
