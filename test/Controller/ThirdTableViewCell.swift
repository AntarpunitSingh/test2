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

    var gif = [DataObject](){
        didSet{
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
        
        return gif.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
        cell.imageBc.sd_setImage(with: URL(string: gif[indexPath.row].images.fixed.url), placeholderImage: UIImage(named: "imagePlaceHolder"), options: .forceTransition, completed: nil)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gifId = gif[indexPath.row].id
        NetworkClient.getGifById(id: gifId) { (image, error) in
            if let image = image {
                Fetch.trendingGifId = image
            }
            else {
                print(error?.localizedDescription ?? "")
            }
        }
        let largeGifUrl = (Fetch.trendingGifId)?.images.downsized.url
        guard let largeUrl = largeGifUrl else {return}
        delegate.gifPassed(gifUrl: largeUrl )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145, height: 150)
    }
}
