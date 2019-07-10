//
//  Data.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-04.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation


import UIKit

class Colors {
    

    static let picData: [Colors] = [
        
      Colors(color: UIColor(red: 247/255, green: 86/255, blue: 124/255, alpha: 1.0)),
      Colors(color: UIColor(red: 50/255, green: 157/255, blue: 216/255, alpha: 1.0)),
      Colors(color: UIColor(red: 251/255, green: 197/255, blue: 49/255, alpha: 1.0)),
      Colors(color: UIColor(red: 93/255, green: 87/255, blue: 107/255, alpha: 1.0)),
      Colors(color: UIColor(red: 140/255, green: 122/255, blue: 230/255, alpha: 1.0)),
      Colors(color: UIColor(red: 47/255, green: 54/255, blue: 64/255, alpha: 1.0)),
      Colors(color: UIColor(red: 0/255, green: 210/255, blue: 211/255, alpha: 1.0)),
      Colors(color: UIColor(red: 238/255, green: 82/255, blue: 83/255, alpha: 1.0)),
      Colors(color: UIColor(red: 16/255, green: 172/255, blue: 132/255, alpha: 1.0)),
      Colors(color: UIColor(red: 95/255, green: 39/255, blue: 205/255, alpha: 1.0)),
      Colors(color: UIColor(red: 255/255, green: 159/255, blue: 67/255, alpha: 1.0))
    ]

    var color: UIColor

    init(color: UIColor ) {
        self.color = color
       
    }
}
