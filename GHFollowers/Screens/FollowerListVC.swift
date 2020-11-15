//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Aya on 10/8/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    
    enum Section {
        case main
    }
    var userName : String?
    var followers : [Follower]         = []
    var filteredFollowers : [Follower] = []
    var page                           = 1
    var hasMoreFollowers               = true
    var isLoadingMoreFollowers         = false
    var isSearching                    = false
    var collectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section , Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = username
        title         = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: userName!, page: page)
        configureDataSource()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureCollectionView(){
        collectionView                  = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelpers.creareThreeColumnsFlowlayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate         = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater                 = self
        //   searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
    
    
    
    func getFollowers(username:String , page : Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username, page: page) {[weak self] (result) in
            guard let self = self else{return}
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened!", message: error.rawValue, buttonTitle: "Ok!")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    func updateUI(with followers: [Follower]){
        if followers.count < 100 {self.hasMoreFollowers = false}
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty{
            let message = "this user has no follwers go and follow them 😃"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)}
            return
        }
        self.updateData(followers: followers)
    }
    
    
    func configureDataSource(){
        dataSource   = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indecPath, follower) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indecPath) as? FollowerCell
            cell?.set(follower: follower)
            
            return cell
            
        })
    }
    func updateData(followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
            
        }
    }
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName!) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result{
            case .success(let user):
                self.addUserToFavorite(user: user)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    func addUserToFavorite(user: User){
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) {[weak self] error in
            guard let self = self else { return }
            guard let error = error else{
                self.presentGFAlertOnMainThread(title: "Success ", message: "You have successfully favorited this user 🥳", buttonTitle: "Horaaay!")
                return
            }
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}


extension FollowerListVC : UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y        //how you scrolled up and down
        let contentHeight = scrollView.contentSize.height     // entire scrollview
        let height        = scrollView.frame.size.height      //height of your screen
        guard hasMoreFollowers, !isLoadingMoreFollowers else {return}
        
        if offsetY > contentHeight - height {
            page += 1
            getFollowers(username: userName!, page: page)
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArr     = isSearching ? filteredFollowers : followers
        let follower      = activeArr[indexPath.item]
        let destVC        = UserInfoVC()
        destVC.username   = follower.login
        destVC.delegate   = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}



extension FollowerListVC : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text ,!filter.isEmpty else{
            filteredFollowers.removeAll()
            updateData(followers: followers)
            isSearching = false
            return
            
        }
        filteredFollowers = followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        isSearching = true
        updateData(followers: filteredFollowers)
    }
    //, UISearchBarDelegate
    /* func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
     print("clicked")
     isSearching = false
     updateData(followers: followers)
     }*/
}





extension FollowerListVC: UserInfoVCDelegate{
    func getFollower(with username: String) {
        self.userName = username
        title         = username
        page          = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: 1)
        //   collectionView.setContentOffset(.zero, animated: true)

        
        
    }
    
    
}
