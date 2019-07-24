//
//  FontColorViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-23.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//
//
import UIKit

class FontColorViewController: UIViewController,UICollectionViewDataSource , UICollectionViewDelegate {

    @IBOutlet weak var colView: UICollectionView!
    
    @IBOutlet weak var tintButton: UIButton!
    @IBOutlet weak var outlineButton: UIButton!
    var delegate : TextDelegate?
     let redColor =  UIColor(red: 193/255, green: 0/255, blue: 0/255, alpha: 1.0)
    lazy var color: [Colors] = {
        return Colors.picData
    }()
    
    var tap: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.delegate = self
        colView.dataSource = self
        tintButton.layer.cornerRadius = CGFloat(20)
        outlineButton.layer.cornerRadius = CGFloat(20)
        buttonToggle(button1: tintButton, button2: outlineButton, state: true)
    
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = colView.dequeueReusableCell(withReuseIdentifier: "FontCollectionViewCell", for: indexPath) as! FontCollectionViewCell
      cell.imageView.backgroundColor = color[indexPath.row].color
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.updateLabelFont(color: color[indexPath.row].color)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 90)
    }
    func buttonToggle(button1: UIButton,button2 : UIButton, state: Bool){
        if state{
            button1.backgroundColor = redColor
            button1.tintColor = UIColor.white
            button2.tintColor = redColor
            button2.backgroundColor = UIColor.white
        }
    }
    
    
    @IBAction func tintAction(_ sender: Any) {
        
         buttonToggle(button1: tintButton, button2: outlineButton, state: true)
    }
    @IBAction func outlineAction(_ sender: Any) {
         buttonToggle(button1: outlineButton, button2: tintButton, state: true)
        
    }
}
