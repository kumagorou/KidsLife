//
//  MyPageViewController.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let screenSize = UIScreen.mainScreen().bounds.size
    var backgroundWidth: CGFloat = 0
    let backgroundHeight: CGFloat = (465 / 2)
    
    let backgroundButton = UIButton()
    
//    let myImageButtonSize = 100
    let imageButtonSize: CGFloat = (245 / 2) // 画像のサイズ

    
    var profileViewWidth: CGFloat = 0
    var profileViewHeight: CGFloat = 0
    
    let defaults = NSUserDefaults.standardUserDefaults()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        self.backgroundWidth = self.screenSize.width
        self.profileViewWidth = self.screenSize.width
        self.profileViewHeight = (self.screenSize.height - self.backgroundHeight)
        
        self.configureProfileView()
        self.configureBackgroundView()
        self.configureImageButton()
    }
    
    func configureBackgroundView() {
        print(__FUNCTION__)
        self.backgroundButton.frame = CGRectMake(0, 0, self.backgroundWidth, self.backgroundHeight)
        
        if (defaults.objectForKey("sex") as! String == "おとこのこ") {
            self.backgroundButton.backgroundColor = UIColor(red: 143 / 255, green: 185 / 255, blue: 227 / 255, alpha: 1)
        } else {
            self.backgroundButton.backgroundColor = UIColor(red: 255 / 255, green: 185 / 255, blue: 227 / 255, alpha: 1)
        }
        self.view.addSubview(self.backgroundButton)
    }
    
    func configureProfileView() {
        print(__FUNCTION__)
        let view = UIView(frame: CGRectMake(0, self.backgroundHeight, self.profileViewWidth, self.profileViewHeight))
        self.view.addSubview(view)
    }
    
    func configureImageButton() {
        let buttonX = (self.backgroundButton.frame.size.width / 2) - (self.imageButtonSize / 2)
        let buttonY = (self.backgroundButton.frame.size.height - (self.imageButtonSize / 2))
        

        
        let buttonRect = CGRectMake(buttonX, buttonY, self.imageButtonSize, self.imageButtonSize)

        let button = UIButton(frame: buttonRect)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = (self.imageButtonSize / 2)
        button.layer.borderWidth = 1.0
        button.addTarget(self, action: "updateImage", forControlEvents: .TouchUpInside)
        self.backgroundButton.addSubview(button)
    }
    
    func updateImage() {
        print(__FUNCTION__)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }    

}
