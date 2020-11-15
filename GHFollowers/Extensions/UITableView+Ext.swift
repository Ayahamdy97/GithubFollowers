//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Aya on 10/28/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

extension UITableView{
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
