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
    var scrollView = MedalTouchScrollView()
    var selectNumber: Int?
    var getMedal = GetMedal()
    var medalImageArray = [UIImage]()
    
    var medalImage: [UIImage] = []
    var medalText: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = true
        
        //長押しを検知
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: "longPressGesture:")
        //何秒押したら長押しと判断するのか
        longPressGesture.minimumPressDuration = 0.5
        longPressGesture.allowableMovement = 150
        self.view.addGestureRecognizer(longPressGesture)
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
        
        let medalImageArray = getMedal.getImageData()
        medalImage = medalImageArray.image
        medalText = medalImageArray.text
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (delegate.greenMedalFlag) {
            medalImage.append(UIImage(named: "GreenMedal.png")!)
            medalText.append("秘密基地で楽しんだメダル")
        }
        for i in 0...10{
            plate = UIImageView(frame: CGRectMake(0, CGFloat(155 * i), UIScreen.mainScreen().bounds.size.width,UIScreen.mainScreen().bounds.size.height / 13))
            let plateImage = UIImage(named: "Bar.png")
            plate.image = plateImage
            scrollView.addSubview(plate)
            for i in 0..<medalImage.count{
                medal = UIImageView(frame: CGRectMake( 25 + CGFloat(120 * (i % 3)), 21 + CGFloat(155 * Int(i / 3)), 80, 150))
                medal.image = medalImage[i]
                medal.userInteractionEnabled = true
                medal.layer.masksToBounds = true
                medal.tag = i + 1
                scrollView.addSubview(medal)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func modalChanged(touchNumber: Int) {
        if(touchNumber != -1){
            selectNumber = touchNumber
            print(touchNumber)
        }
    }
    internal func longPressGesture(sender: UILongPressGestureRecognizer){
        // 指が離れたことを検知
        if let number = selectNumber{
            
            
            let alertController = UIAlertController(title: medalText[number], message: "お気に入りにしますか？", preferredStyle: .Alert)
            let otherAction = UIAlertAction(title: "OK", style: .Default){
                action in print("push OK!")
                print(number)
                self.getMedal.sendFavoriteMedal(number + 1)
                
                let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let tabBarVC = delegate.myTabBarController
                let navigationVCS = tabBarVC.viewControllers // 複数のnavigationControllerを取得
                print("VCs = \(navigationVCS)")
                // 1つのnavigationControllerを取得
                if let navigationVC = tabBarVC.viewControllers![0] as? UINavigationController {
                    // その中のMyPageViewControllerを取得してお気に入りメダルを更新する
                    if let myPageVC = navigationVC.viewControllers[0] as? MyPageViewController {
                        myPageVC.updateImage(self.medalImage[number])
                    }
                }
                
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel){
                action in print("Puch Cancel")
            }
            alertController.addAction(otherAction)
            alertController.addAction(cancelAction)
            presentViewController(alertController, animated: true, completion: nil)
        }

        
        
//        if(sender.state == UIGestureRecognizerState.Ended){}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
