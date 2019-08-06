//
//  ThirdTableViewCell.swift
//  test
//
//  Created by Antarpunit Singh on 2012-08-06.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit
import SDWebImage
class ThirdTableViewCell: UITableViewCell,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate  {
    
    @IBOutlet weak var collectionView: UICollectionView!
//    weak var delegate : ImageDelegate!
    var gif = [DataObject](){
        didSet{
            collectionView.reloadData()
        }
    }
    func trendingNetworkCall(){
        NetworkClient.getTrendingGif { (imageUrl, error) in
            if let imageUrl = imageUrl {
                Fetch.trendingGifURL = imageUrl
                print(imageUrl)
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FirstCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstCollectionViewCell")
        
        collectionView.reloadData()
        trendingNetworkCall()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gif.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        cell.imageBc.sd_setImage(with: URL(string: gif[indexPath.row].images.fixed.url), completed: nil)
        print(gif[indexPath.row].images.fixed.url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate.imagePassed(image: img[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145, height: 150)
    }
    
}
