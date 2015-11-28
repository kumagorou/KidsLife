//
//  LoginViewController.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let myPageVC = MyPageViewController()
    let eventSearchVC = EventSearchViewController()
    let scheduleVC = ScheduleViewController()
    let collectionVC = CollectionViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()

        // これがないと最初にタブバーの文字が表示されない
        self.myPageVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Featured, tag: 1)
        self.eventSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Featured, tag: 2)
        self.scheduleVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Featured, tag: 3)
        self.collectionVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Featured, tag: 4)

        let button = UIButton(frame: CGRectMake(100, 100, 100, 100))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "moveTabBarViewController", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func moveTabBarViewController() {
        let myTabBarController = UITabBarController()
        let vcArrays = NSArray(objects: myPageVC, eventSearchVC, scheduleVC, collectionVC)
        myTabBarController.setViewControllers(vcArrays as? [UIViewController], animated: false)
        self.presentViewController(myTabBarController, animated: true, completion: nil)
    }

}
