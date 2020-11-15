//
//  FavouritesVC.swift
//  GHFollowers
//
//  Created by Aya on 10/8/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class FavouritesVC: GFDataLoadingVC {

    var tableView              = UITableView()
    var favorites : [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController(){
         view.backgroundColor = .systemBackground
         title = "Favorites"
         navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame      = view.bounds
        tableView.rowHeight  = 80
        tableView.delegate   = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
    }
    
    
    func getFavorites()  {
        PersistenceManager.retrieveFavorites { result in
            switch result{
            case .success(let favorite):
                self.updateUI(with: favorite)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Somethig went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    func updateUI(with favorite:[Follower]){
        if favorite.isEmpty{
            self.showEmptyStateView(with: "No followers\nAdd new one on the follower screen", in: self.view)
        }else{
            self.favorites = favorite
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }

}
extension FavouritesVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = FollowerListVC(username:  favorites[indexPath.row].login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        guard editingStyle == .delete else{return}
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
                
            }
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
