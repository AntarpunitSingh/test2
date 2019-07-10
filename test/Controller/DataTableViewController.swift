//
//  DataTableViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-04.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit
import Photos

class DataTableViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
 
    
    var images: [UIImage] = []
    lazy var colorData: [Colors] = {
       
        
        return Colors.picData
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navBar()
        tableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        tableView.layer.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 250/255, alpha: 1.0).cgColor
        fetchPhotos()
       
        print("images\(images)")
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
     
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
        if indexPath.section == 0 {
        
            cell.data = colorData
            
        
        
        }
        else if indexPath.section == 1{
            
        }
           
        
        
        return cell
    }
    
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Color"
        }
        else if section == 1 {
            return "Memes"
            
        }
        else {
            return ""
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 20)
        let button = UIButton(frame: CGRect(x: view.frame.width - 60, y: 0, width: 60, height: 28))
        button.backgroundColor = UIColor(red: 147/255, green: 152/255, blue: 158/255, alpha: 1.0)
        button.setTitle("SeeAll", for: .normal)
        button.layer.cornerRadius = CGFloat(10)
        button.addTarget(self, action: #selector(headerButton), for: .touchUpInside)
        let label = UILabel(frame: CGRect(x: 18, y: 0, width: 60, height: 20))
        label.font = UIFont(name:"DIN Alternate", size: 18)
       
        if section == 0 {
            label.text = "Colors"
        }
        else if section == 1 {
            label.text = "Memes"
        }
        vw.addSubview(label)
        vw.addSubview(button)
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return CGFloat(130)
        }
        return CGFloat(160.0)
    }
    
    @objc func headerButton(button:UIButton!) {
  
        let Controller = storyboard?.instantiateViewController(withIdentifier: "PicViewController") as! PicViewController
        navigationController?.pushViewController(Controller, animated: true)
        Controller.color = Colors.picData
    }
    func navBar(){
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        navBar.isHidden = false
        navBar.barTintColor = UIColor(red: 193/255, green: 0, blue: 0, alpha: 1.0)
        navBar.tintColor = UIColor.black
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
       
    }
    
    @IBAction func pickCameraImage(_ sender: Any) {
        presentImagePickerWith(sourceType: .photoLibrary)
        
    }
    //Mark- Photolibrary fetching method from stackflow 
    func fetchPhotos () {
        // Sort the images by descending creation date and fetch the first 3
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        fetchOptions.fetchLimit = 3
        
        // Fetch the image assets
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        // If the fetch result isn't empty,
        // proceed with the image request
        if fetchResult.count > 0 {
            let totalImageCountNeeded = 10 // <-- The number of images to fetch
            fetchPhotoAtIndex(0, totalImageCountNeeded, fetchResult)
            
        }
    }
    func fetchPhotoAtIndex(_ index:Int, _ totalImageCountNeeded: Int, _ fetchResult: PHFetchResult<PHAsset>) {
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        
        // Perform the image request
        PHImageManager.default().requestImage(for: fetchResult.object(at: index) as PHAsset,
                                              targetSize: CGSize(width: 200, height: 200),
                                              contentMode: PHImageContentMode.aspectFill,
                                              options: requestOptions,
                                              resultHandler: { (image, _) in
                                                if let image = image {
                                                    
                                                  self.images += [image]
                                                }
                                                if index + 1 < fetchResult.count && self.images.count < totalImageCountNeeded {
                                                    self.fetchPhotoAtIndex(index + 1, totalImageCountNeeded, fetchResult)
                                                } else {
                                                    print("Completed array: \(self.images)")
                                                }
        })
    }

    
}
extension DataTableViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
           let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
           memeVC.imagePassed = image
           self.dismiss(animated: true, completion: nil)
           navigationController?.pushViewController(memeVC, animated: true)
            
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func presentImagePickerWith(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }
}
