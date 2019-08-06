//  MemeViewController.swift
//  test
//  Created by Antarpunit Singh on 2012-07-07.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.


import UIKit

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
    
    var imagePassed: UIImage!
    var colorPassed: UIColor!
    
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
    
    @IBAction func shareAction(_ sender: Any) {
        let shareImage = generateMemedImage()
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
    func generateMemedImage() -> UIImage {
        // Render view to an image
        topToolbar.isHidden = true
        bottomToolBar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        topToolbar.isHidden = false
         bottomToolBar.isHidden = false
   
        return memedImage
    }
    
    @IBAction func topPan(_ sender: UIPanGestureRecognizer) {
        let textView = sender.view!
        let point = sender.translation(in: view)
       
      
    }
    
    
    @IBAction func bottomPan(_ sender: UIPanGestureRecognizer) {
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

