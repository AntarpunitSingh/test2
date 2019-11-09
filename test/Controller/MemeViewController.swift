//  MemeViewController.swift
//  test
//  Created by Antarpunit Singh on 2012-07-07.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.


import UIKit
import ImageIO
import MobileCoreServices


protocol changeTextfieldTextDelegate:class {
    func updateTextFieldFont(fontName: String )
    func updateTextFieldColor(color: UIColor )
}
class MemeViewController: UIViewController {
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imageVw: UIImageView!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var slider: UISlider!
    
    var imagePassed: UIImage!
    var colorPassed: UIColor!
    var gifurl:URL!
    var imgArray : [UIImage] = []
   
    
    @IBOutlet weak var imageConstraint: NSLayoutConstraint!
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.font : UIFont(name: "Copperplate", size: 40)!,
        NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.strokeWidth:  -4.0 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageVw.image = imagePassed
        imageVw.backgroundColor = colorPassed
        setStyle(toTextField: topText)
        setStyle(toTextField: bottomText)
        
        let constrint = NSLayoutConstraint(item: imageVw!, attribute: .height, relatedBy: .equal, toItem: imageVw, attribute: .width, multiplier: imageVw.contentRect.height / imageVw.contentRect.width, constant: 0)
        imageVw.addConstraint(constrint)
        imageConstraint.isActive = false
        self.view.layoutIfNeeded()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        subscribeToKeyboardNotifications()
        imageVw?.contentMode = .scaleAspectFit
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        unsubscribeFromKeyboardNotifications()
    }

    @IBAction func cancelToolbar(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    func setStyle(toTextField textField: UITextField) {
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        textField.defaultTextAttributes = memeTextAttributes
        textField.clearsOnBeginEditing = true
        textField.delegate = self
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification){
        if (bottomText.isEditing){ //or bottomTextField.isFirstResponder
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        self.view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        
    }
    @IBAction func shareAction(_ sender: Any) {
       
        let shareImage = generateMemedImage()
        if gifurl != nil {
            guard let data = NSData(contentsOf: savedGif()) else { return }
            let activityController =  UIActivityViewController(activityItems: [data], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
            activityController.completionWithItemsHandler = {(activity, completed, items, error) in
                if (completed){
                    //  self.save()
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
            
        else {
            let activityController =  UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)
            activityController.completionWithItemsHandler = {(activity, completed, items, error) in
                if (completed){
                    //  self.save()
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    //Mark - Generate saving image & gif
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolBar.isHidden = true
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.view.frame.size, false, scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        topToolbar.isHidden = false
        bottomToolBar.isHidden = false
        return memedImage
    }
    
    func savedGif() -> URL {
        loop()
        let url = animatedGif(from: imgArray)!
        return url
    }
    @IBAction func topPan(_ sender: UIPanGestureRecognizer) {
//        let textView = sender.view!
//        let point = sender.translation(in: view)
//
    }
    @IBAction func bottomPan(_ sender: UIPanGestureRecognizer) {
    }
    //Mark- Gif saving methods
    func loop (){
        let frame = getSequence(gifNamed: gifurl)
        for n in frame! {
            let img = textToImage(drawTopText: topText, drawBottomText: bottomText, inImage: n, topPoint: CGPoint(x: 0, y: 5), bottomPoint: CGPoint(x: 0, y: 100))
            imgArray.append(img)
        }
    }
    //modifying the frames of gif
    func textToImage(drawTopText textT: UITextField,drawBottomText textB: UITextField, inImage image: UIImage, topPoint pointA: CGPoint, bottomPoint pointB: CGPoint) -> UIImage {
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(imageVw.contentRect.size, false, scale)
        
        image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: imageVw.contentRect.size))
        let rectA = CGRect(origin: pointA, size: imageVw.contentRect.size)
        let rectB = CGRect(origin: pointB, size: imageVw.contentRect.size)
        textT.drawText(in: rectA)
        textB.drawText(in: rectB)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    // generating each and every frame of gif.
    
    func getSequence(gifNamed: URL) -> [UIImage]? {
        
        guard let imageData = try? Data(contentsOf: gifNamed) else {
            print("Cannot turn image named \"\(gifNamed)\" into NSData")
            return nil
        }
        let gifOptions = [
            kCGImageSourceShouldAllowFloat as String : true as NSNumber,
            kCGImageSourceCreateThumbnailWithTransform as String : true as NSNumber,
            kCGImageSourceCreateThumbnailFromImageAlways as String : true as NSNumber
            ] as CFDictionary
        
        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, gifOptions) else {
            debugPrint("Cannot create image source with data!")
            return nil
        }
        let framesCount = CGImageSourceGetCount(imageSource)
        var frameList = [UIImage]()
        
        for index in 0 ..< framesCount {
            
            if let cgImageRef = CGImageSourceCreateImageAtIndex(imageSource, index, nil) {
                let uiImageRef = UIImage(cgImage: cgImageRef)
                frameList.append(uiImageRef)
            }
        }
        return frameList // Your gif frames is ready
    }
    
    func animatedGif(from images: [UIImage]) -> URL?{
        let fileProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]  as CFDictionary
        let frameProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [(kCGImagePropertyGIFDelayTime as String): 0.1]] as CFDictionary
        
        let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL: URL? = documentsDirectoryURL?.appendingPathComponent("animated.gif")
        
        if let url = fileURL as CFURL? {
            if let destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, nil) {
                CGImageDestinationSetProperties(destination, fileProperties)
                for image in images {
                    if let cgImage = image.cgImage {
                        CGImageDestinationAddImage(destination, cgImage, frameProperties)
                    }
                }
                if !CGImageDestinationFinalize(destination) {
                }
            }
        }
      return fileURL
    }
}
extension MemeViewController: UITextFieldDelegate , changeTextfieldTextDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func updateTextFieldFont(fontName: String) {
        topText.attributedText = NSAttributedString(string: topText.text!, attributes: [NSMutableAttributedString.Key.font : UIFont(name: fontName, size: 40)!])
        bottomText.attributedText = NSAttributedString(string: bottomText.text!, attributes: [NSMutableAttributedString.Key.font : UIFont(name: fontName, size: 40)!])
        memeTextAttributes.updateValue(UIFont(name: fontName, size: 40)!, forKey: NSAttributedString.Key.font)
        updateTextField(textFieldA: topText, textFieldB: bottomText)
        
    }
    func updateTextFieldColor(color: UIColor) {
        topText.attributedText = NSAttributedString(string: topText.text!, attributes: [NSMutableAttributedString.Key.foregroundColor : color])
        bottomText.attributedText = NSAttributedString(string: bottomText.text!, attributes: [NSMutableAttributedString.Key.foregroundColor : color])
        memeTextAttributes.updateValue(color, forKey: NSAttributedString.Key.foregroundColor)
        updateTextField(textFieldA: topText, textFieldB: bottomText)
      
    }
    func updateTextField(textFieldA :UITextField , textFieldB:UITextField){
        textFieldA.defaultTextAttributes = memeTextAttributes
        textFieldA.textAlignment = .center
        textFieldB.defaultTextAttributes = memeTextAttributes
        textFieldB.textAlignment = .center

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFont"  {
            let destinationVC = segue.destination as! MasterViewController
            destinationVC.delegate = self
        }
    }
}
extension UIImageView {
    var contentRect: CGRect {
        guard let image = image else { return frame }
        guard contentMode == .scaleAspectFit else { return frame }
        guard image.size.width > 0 && image.size.height > 0 else { return frame }
        
        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = frame.width / image.size.width
        } else {
            scale = frame.height / image.size.height
        }
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (frame.width - size.width) / 2.0
        let y = (frame.height - size.height) / 2.0
        
        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}

func frameImage(for image: UIImage, inImageViewAspectFit imageView: UIImageView) -> CGRect {
    let imageRatio = (image.size.width / image.size.height)
    let viewRatio = imageView.frame.size.width / imageView.frame.size.height
    if imageRatio < viewRatio {
        let scale = imageView.frame.size.height / image.size.height
        let width = scale * image.size.width
        let topLeftX = (imageView.frame.size.width - width) * 0.5
        return CGRect(x: topLeftX, y: 0, width: width, height: imageView.frame.size.height)
    } else {
        let scale = imageView.frame.size.width / image.size.width
        let height = scale * image.size.height
        let topLeftY = (imageView.frame.size.height - height) * 0.5
        return CGRect(x: 0.0, y: topLeftY, width: imageView.frame.size.width, height: height)
    }
}
