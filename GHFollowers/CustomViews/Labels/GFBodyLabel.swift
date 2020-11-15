//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Aya on 10/9/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

   override init(frame: CGRect) {
       super.init(frame: frame)
       configre()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   convenience init(textAlignment : NSTextAlignment) {
       self.init(frame: .zero)
       self.textAlignment = textAlignment
       
   }
   private func configre(){
       textColor                 = .secondaryLabel
       adjustsFontSizeToFitWidth = true
       font                      = UIFont.preferredFont(forTextStyle: .body)
       minimumScaleFactor        = 0.75
       lineBreakMode             = .byWordWrapping
       adjustsFontForContentSizeCategory = true
       translatesAutoresizingMaskIntoConstraints = false
       
   }
}
