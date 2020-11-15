//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Aya on 10/22/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

protocol GFFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User)
}
class GFFollowerItemVC: GFItemInfoVC {
     var delegate: GFFollowerItemVCDelegate!

    init(user: User, delegate: GFFollowerItemVCDelegate) {
           super.init(user: user)
           self.delegate = delegate
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
 
    
    func configureItems()  {
        itemInfoVewOne.setItem(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.setItem(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgrounColor: .systemGreen, title: "Get Followers")
        
    }
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
