//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Aya on 10/22/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

protocol GFRepoItemVCDelegate {
    func didTapGithubProfile(for user: User)
    
}
class GFRepoItemVC: GFItemInfoVC {
    var delegate: GFRepoItemVCDelegate!

    
    init(user: User, delegate: GFRepoItemVCDelegate) {
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
        itemInfoVewOne.setItem(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.setItem(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgrounColor: .systemPurple, title: "Github Profile")
        
    }
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
