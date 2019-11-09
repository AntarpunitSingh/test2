//
//  ImageDelegate.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-21.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import Foundation
import UIKit
protocol ImageDelegate: class {
    // pass the the image or any variable you want in the func params
    func imagePassed(image: UIImage)
    func colorPassed(color: UIColor)
    func gifPassed(gifUrl:String)
}
