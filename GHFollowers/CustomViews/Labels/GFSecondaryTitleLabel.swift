//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Aya on 10/16/20.
//  Copyright © 2020 Aya. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

   override init(frame: CGRect) {
          super.init(frame: frame)
          configre()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
     convenience init(fontSize : CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
          
      }
    
      private func configre(){
          textColor = .secondaryLabel
          adjustsFontSizeToFitWidth = true
          font = UIFont.preferredFont(forTextStyle: .body)
          minimumScaleFactor = 0.90
          lineBreakMode = .byTruncatingTail
          translatesAutoresizingMaskIntoConstraints = false
          
      }
}
