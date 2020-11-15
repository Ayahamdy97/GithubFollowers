//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Aya on 10/25/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseId  = "FavoriteCell"
    let avatarImageview = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite : Follower){
        avatarImageview.downloadImage(fromUrl: favorite.avatarUrl)
        usernameLabel.text = favorite.login
    }
    private func configure(){
        
        addSubviews(avatarImageview,usernameLabel)
        accessoryType        = .disclosureIndicator
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            
            avatarImageview.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageview.heightAnchor.constraint(equalToConstant: 60),
            avatarImageview.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageview.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
            
            
            
        ])
    }
}
