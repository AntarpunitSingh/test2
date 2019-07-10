//
//  FirstTableViewCell.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-04.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.

import UIKit

class FirstTableViewCell: UITableViewCell , UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var data = [Colors](){
        didSet{
            collectionView.reloadData()
            
        }
    }
    var dataImage = [DataTableViewController](){
        didSet{
            collectionView.reloadData()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
        return data.count
        }
        return dataImage.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
      //  let pic: Colors = data[indexPath.row]
        if indexPath.section == 0 {
        cell.imageBc.backgroundColor = data[indexPath.row].color
         
        }
        else  if indexPath.section == 1 {
            print("aunda")
            
           
          cell.imageBc.backgroundColor = UIColor.blue
           
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item selected")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 120)
        
    }
    
    
}
