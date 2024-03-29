//
//  DataTableViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-04.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//

import UIKit
import Photos
import SDWebImage
class DataTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
   // var images: [UIImage] = []
    var gifImage :UIImage!
    
    lazy var colorData: [Colors] = {
        return Colors.picData
    }()
    
    lazy var imgData : [UIImage] = {
        return Fetch.imageData
    }()
    
    var gifData : [DataObject] {
        return Fetch.trendingGifURL
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navBar()
        tableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        tableView.register(UINib(nibName: "ThirdTableViewCell", bundle: nil), forCellReuseIdentifier: "ThirdTableViewCell")
        tableView.layer.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 250/255, alpha: 1.0).cgColor
        tableView.reloadData()
        fetchPhotos()
        trendingNetworkCall()
        giftestting()
    }
    func giftestting(){
        
        
        

    }
    func trendingNetworkCall(){
        NetworkClient.getTrendingGif { (imageUrl, error) in
            if let imageUrl = imageUrl  {
                Fetch.trendingGifURL = imageUrl
               
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func pickCameraImage(_ sender: Any) {
        presentImagePickerWith(sourceType: .camera)
    }
    //Mark - NavigationBar UI method
    func navBar(){
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        navBar.isHidden = false
        navBar.barTintColor = UIColor(red: 193/255, green: 0, blue: 0, alpha: 1.0)
        navBar.tintColor = UIColor.black
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
    //Mark- Photolibrary fetching method from stackflow 
    func fetchPhotos () {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: false)]
        fetchOptions.fetchLimit = 10
    
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            let totalImageCountNeeded = 10 // <-- The number of images to fetch
            fetchPhotoAtIndex(0, totalImageCountNeeded, fetchResult)
        }
    }
    func fetchPhotoAtIndex(_ index:Int, _ totalImageCountNeeded: Int, _ fetchResult: PHFetchResult<PHAsset>) {
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        PHImageManager.default().requestImage(for: fetchResult.object(at: index) as PHAsset,
                                              targetSize: CGSize(width: 200, height: 200),
                                              contentMode: PHImageContentMode.aspectFill,
                                              options: requestOptions,
                                              resultHandler: { (image, _) in
                                                if let image = image {
                                                    Fetch.imageData += [image]
                                                }
                                                if index + 1 < fetchResult.count && Fetch.imageData.count < totalImageCountNeeded {
                                                    self.fetchPhotoAtIndex(index + 1, totalImageCountNeeded, fetchResult)
                                                }
        })
    }
}
extension DataTableViewController: UITableViewDelegate ,UITableViewDataSource {
    //Mark - TableView Data Source methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            cell.data = colorData
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            cell.img = imgData
            cell.delegate = self
            return cell
        }
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
            cell.gif = gifData
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    // Mark - TableView Delegate Methods
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Colors"
        case 1:
            return "Memes"
        case 2:
            return "Gifs"
        default:
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
        
        let label = UILabel(frame: CGRect(x: 18, y: 0, width: 150, height: 20))
        label.font = UIFont(name:"DIN Alternate", size: 18)
        
        if section == 0 {
            label.text = "Colors"
        }
        else if section == 1 {
            label.text = "Photo Library"
            button.addTarget(self, action: #selector(pickerAlbum), for: .touchUpInside)
            vw.addSubview(button)
        }
        else if section == 2 {
            label.text = "Gifs"
            button.addTarget(self, action: #selector(gifAlbum), for: .touchUpInside)
            vw.addSubview(button)
        }
        vw.addSubview(label)
        return vw
    }
    @objc func pickerAlbum(button: UIButton!){
        presentImagePickerWith(sourceType: .photoLibrary)
    }
    @objc func gifAlbum(button: UIButton!){
        print("not connected")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(130)
        }
        else if indexPath.section == 1 {
            return CGFloat(160.0)
        }
        return CGFloat(160.0)
    }
    
}
//Mark - UIPickerController Methods
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

//Mark - ImageDelegate Methods
extension DataTableViewController: ImageDelegate {
    
    func imagePassed(image: UIImage) {
        let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        memeVC.imagePassed = image
        self.dismiss(animated: true, completion: nil)
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(memeVC, animated: true)
    }
    func colorPassed(color: UIColor) {
        let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        memeVC.colorPassed = color
        self.dismiss(animated: true, completion: nil)
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(memeVC, animated: true)
    }
    func gifPassed(gifUrl: String) {
        
        let memeVC = storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        memeVC.imagePassed = UIImage.gifImageWithURL(gifUrl)
        memeVC.gifurl = URL(string: gifUrl)
        self.dismiss(animated: true, completion: nil)
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(memeVC, animated: true)
        
        
    }
}


