//
//  SecondTableViewCell.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-04.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate  {
 
    @IBOutlet weak var collectionView: UICollectionView!
    var img = [UIImage](){
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate : ImageDelegate!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        
        collectionView.reloadData()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return img.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        cell.imageBc.image = img[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.imagePassed(image: img[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145, height: 150)
    }
   
}
