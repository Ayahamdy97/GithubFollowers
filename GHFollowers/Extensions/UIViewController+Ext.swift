//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Aya on 10/9/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func presentGFAlertOnMainThread(title : String, message : String, buttonTitle : String)  {
        DispatchQueue.main.async {
            let alerVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alerVC.modalPresentationStyle = .overFullScreen
            alerVC.modalTransitionStyle = .crossDissolve
            self.present(alerVC,animated: true)
        }
    }
    
  
    func presentSafariVC(with url:URL)  {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
   
}
