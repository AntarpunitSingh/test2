//
//  FirstCollectionViewCell.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-04.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageBc: UIImageView!
    @IBOutlet weak var mainView: UIView!
    var color: [Colors] = [Colors]()
  
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageBc.layer.cornerRadius = CGFloat(15)
        
    
    }

}
