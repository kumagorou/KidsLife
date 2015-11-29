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
    
    let imageButtonSize: CGFloat = (276 / 2) // 画像のサイズ
    
    var profileView = UIView()
    
    let favoriteMedalImageView = UIImageView()
    var myMedalImage = UIImage(named: "FavoriteMedal.png")
    let medalImageViewWidth: CGFloat = (168 / 2)
    let medalImageViewHeight: CGFloat = (313 / 2)

    
    var profileViewWidth: CGFloat = 0
    var profileViewHeight: CGFloat = 0
    
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
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
        
        let sex = defaults.objectForKey("sex") as? String ?? "おとこのこ"
        if (sex == "おとこのこ") {
            self.backgroundButton.backgroundColor = UIColor(red: 143 / 255, green: 185 / 255, blue: 227 / 255, alpha: 1)
        } else {
            self.backgroundButton.backgroundColor = UIColor(red: 255 / 255, green: 185 / 255, blue: 227 / 255, alpha: 1)
        }
        self.view.addSubview(self.backgroundButton)
    }
    
    func configureProfileView() {
        print(__FUNCTION__)
        self.profileView = UIView(frame: CGRectMake(0, self.backgroundHeight, self.profileViewWidth, self.profileViewHeight))
        self.view.addSubview(self.profileView)
    }
    
    func configureImageButton() {
        // アイコンボタン
        let buttonX = (self.backgroundButton.frame.size.width / 2) - (self.imageButtonSize / 2)
        let buttonY = (self.backgroundButton.frame.size.height - (self.imageButtonSize / 2))
        let buttonRect = CGRectMake(buttonX, buttonY, self.imageButtonSize, self.imageButtonSize)

        let button = UIButton(frame: buttonRect)
        button.setBackgroundImage(UIImage(named: "Yotsu.png"), forState: .Normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = (self.imageButtonSize / 2)
        button.addTarget(self, action: "updateImage", forControlEvents: .TouchUpInside)
        self.backgroundButton.addSubview(button)
        
        // アイコンボタンの下のメダルのやつ
        let imageViewX = (self.screenSize.width / 2) - (self.medalImageViewWidth / 2)
        let imageViewY = (button.frame.size.height / 2) - 20
        self.favoriteMedalImageView.frame = CGRectMake(imageViewX, imageViewY, self.medalImageViewWidth, self.medalImageViewHeight)
        self.favoriteMedalImageView.image = self.myMedalImage
        print(self.favoriteMedalImageView.frame)
        self.profileView.addSubview(self.favoriteMedalImageView)
        
        // そのメダルの下に生えのラベルを表示する
        let margin: CGFloat = 20
        let labelX = margin
        let labelY = (imageViewY + self.medalImageViewHeight + margin)
        let labelWidth = self.screenSize.width - (margin * 2)
        let labelHeight = margin
        let nameLabel = UILabel(frame: CGRectMake(labelX, labelY, labelWidth, labelHeight))
        nameLabel.text = NSUserDefaults.standardUserDefaults().objectForKey("name") as? String ?? "No Name"
        nameLabel.textAlignment = .Center
        nameLabel.font = UIFont(name: "Helvetica", size: 25)
        self.profileView.addSubview(nameLabel)
    }
    
    func updateImage(image: UIImage) {
        self.myMedalImage = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }    

}
