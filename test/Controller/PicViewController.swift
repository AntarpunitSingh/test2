//
//  PicViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-05.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit

class PicViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var color = [Colors]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicViewCell", for: indexPath) as! PicViewCell
        cell.image.backgroundColor = color[indexPath.row].color
        
        return cell
    }
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemPerRow : CGFloat = 3
        let cellWidth: CGFloat = collectionView.frame.width
        let widthPerItem :CGFloat = cellWidth / itemPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
   
   
    
    
}
