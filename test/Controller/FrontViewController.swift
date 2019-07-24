//
//  ViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-06-18.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var picView: UIView!
    @IBOutlet weak var pic1: UIImageView!
    
    let color1 = UIColor(red: 255/255, green: 73/255, blue: 73/255, alpha: 1.0).cgColor
    let color2 = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0).cgColor

     override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = CGFloat(10)
        view.clipsToBounds = true
        subView.layer.cornerRadius = CGFloat(10)
    //  subView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        subView.layer.shadowRadius = CGFloat(10)
        subView.layer.shadowOpacity = Float(1)
        button.layer.cornerRadius = CGFloat(10)
        view.layer.backgroundColor = color2
    }
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        view.addSubview(subView)
    }
    @IBAction func createButton(_ sender: Any) {
    }
}
    
