//
//  CollectionViewController.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, MedalImageTouchScrollViewDelegate{
    
    private var backGround: UIImageView!
    private var plate: UIImageView!
    private var medal: UIImageView!
    private var medalArray: [UIImageView] = []
    var scrollView = MedalTouchScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.medalDelegate = self
        backGround = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        let backGroundImage = UIImage(named: "Background-1.png")
        backGround.image = backGroundImage
        self.view.addSubview(backGround)
        
        
        scrollView.frame = CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, (UIScreen.mainScreen().bounds.size.height - 64))
        scrollView.contentSize = CGSizeMake(0, UIScreen.mainScreen().bounds.size.height + 1000)
        scrollView.pagingEnabled = false
        scrollView.userInteractionEnabled = true
        self.view.addSubview(scrollView)
        
        

        print(UIScreen.mainScreen().bounds.size.height / 13)
        for i in 0...10{
            plate = UIImageView(frame: CGRectMake(0, CGFloat(155 * i), UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height / 13))
            let plateImage = UIImage(named: "Bar.png")
            plate.image = plateImage
            scrollView.addSubview(plate)
            for i in 0...29{
                medalArray.insert(UIImageView(), atIndex: i)
                medalArray[i] = UIImageView(frame: CGRectMake( 25 + CGFloat(120 * (i % 3)), 21 + CGFloat(155 * Int(i / 3)), 80, 150))
                medalArray[i].userInteractionEnabled = true
                medalArray[i].layer.masksToBounds = true
                medalArray[i].tag = i + 1
                medalArray[i].image = UIImage(named: "Medal_3.png")
                scrollView.addSubview(medalArray[i])
                
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func modalChanged(touchNumber: Int) {
        print(touchNumber)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
