//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Aya on 10/28/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...)  {
        for view in views{
            addSubview(view)
        }
    }
}
