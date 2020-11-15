//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Aya on 10/18/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit
enum ItemInfoType {
    case repos, gists, followers,following
}
class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let counterLabel    = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure()  {
        addSubviews(symbolImageView, titleLabel, counterLabel)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            counterLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            counterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            counterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            counterLabel.heightAnchor.constraint(equalToConstant: 18)
            
            
            
        ])
    }
    func setItem(itemInfoType: ItemInfoType, withCount count: Int) {
        
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text       = "Public Repo"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text       = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text       = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text       = "Following"
            
        }
        counterLabel.text = String(count)
    }
}
