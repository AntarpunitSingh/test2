//
//  MasterViewController.swift
//  test
//
//  Created by Antarpunit Singh on 2012-07-23.
//  Copyright © 2019 AntarpunitSingh. All rights reserved.
//
import UIKit

protocol TextDelegate:class {
    func updateLabelText(value: String)
    func updateLabelFont(color: UIColor)
}

class MasterViewController: UIViewController , TextDelegate {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var childViewFrame: UIView!
    
    var delegate:changeTextfieldTextDelegate?
    
    lazy var fontViewController : FontViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "FontViewController")as! FontViewController
        addChildViewController(childVC: vc)
        vc.delegate = self
        return vc
    }()
    lazy var fontColorViewController : FontColorViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var vc = storyboard.instantiateViewController(withIdentifier: "FontColorViewController")as! FontColorViewController
        addChildViewController(childVC: vc)
        vc.delegate = self
        return vc
    }()
    var val : NSAttributedString?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
       
        
        myView.layer.cornerRadius = CGFloat(10)
        segmentControl.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMinYCorner]
        segmentControl.layer.masksToBounds = true
        myView.layer.masksToBounds = true
       //topLabel.attributedText = labelAttributes

    }
    func updateUI(){
        fontViewController.view.isHidden = !(segmentControl.selectedSegmentIndex == 0)
        fontColorViewController.view.isHidden = segmentControl.selectedSegmentIndex == 0
    }
    @IBAction func segControll(_ sender: UISegmentedControl) {
            updateUI()
}
    func addChildViewController(childVC: UIViewController){
        addChild(childVC)
        childViewFrame.addSubview(childVC.view)
        childVC.view.frame = childViewFrame.bounds
        childVC.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childVC.didMove(toParent: self)
    }
    func updateLabelText(value: String) {
        let labelAttributes: [NSAttributedString.Key: Any] =
            [ NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: value, size: 40)!,
            NSAttributedString.Key.strokeWidth:  -2.0 ]
        
        topLabel.attributedText = NSAttributedString(string: value, attributes: labelAttributes)
        delegate?.updateTextFieldFont(fontName: value)
    }
    func updateLabelFont(color: UIColor) {
        topLabel.textColor = color
        delegate?.updateTextFieldColor(color: color)
    }
   
    @IBAction func dismissAction(_ sender: Any) {
      
        dismiss(animated: true, completion: nil)
    }
}
