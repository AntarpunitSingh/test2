//
//  FontCollectionViewCell.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-23.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class FontCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        imageView.layer.cornerRadius = CGFloat(8)
    }
}
