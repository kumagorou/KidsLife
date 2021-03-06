//
//  AppDelegate.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var greenMedalFlag = false

    var blendName: String?
    var jsonData: JSON?
    
    var window: UIWindow?
    
    let myPageVC = MyPageViewController()
    let eventSearchVC = EventSearchViewController(nibName: nil, bundle: nil)
    //let scheduleVC = ScheduleViewController()
    let collectionVC = CollectionViewController()
    
    

    let myTabBarController = UITabBarController()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let nav1 = UINavigationController(rootViewController: myPageVC)
        let nav2 = UINavigationController(rootViewController: eventSearchVC)
        //let nav3 = UINavigationController(rootViewController: scheduleVC)
        let nav3 = UINavigationController(rootViewController: collectionVC)
        
        let vcArrays = NSArray(objects: nav1, nav2, nav3)
        self.myTabBarController.setViewControllers(vcArrays as? [UIViewController], animated:
            false)
        self.configureTabBar()

        // 既に登録されている場合
        if (NSUserDefaults.standardUserDefaults().objectForKey("name") != nil) {
            // rootViewControllerをtabBarControllerにする
            self.window?.rootViewController = self.myTabBarController
            return true
        }
        
        // アラート表示の許可をもらう.
        let setting = UIUserNotificationSettings(forTypes: [.Sound, .Alert], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(setting)
        
        return true
    }
    
    // tabBarの準備
    func configureTabBar() {
        self.myPageVC.tabBarItem = UITabBarItem(title: "マイページ",image: UIImage(named: "MyAccountIcon.png"), tag: 1)
        self.eventSearchVC.tabBarItem = UITabBarItem(title: "イベント",image: UIImage(named: "EventIcon.png"), tag: 2)
        //self.scheduleVC.tabBarItem = UITabBarItem(tabBarSystemItem: .Featured, tag: 3)
        self.collectionVC.tabBarItem = UITabBarItem(title: "コレクション",image: UIImage(named:"MedalIcon.png"), tag: 3)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // foregroundにいたとき        
        
        // アプリ起動中(フォアグラウンド)に通知が届いた場合
        if(application.applicationState == UIApplicationState.Active) {
            // ここに処理を書く
            print("foreground")
        }
        
//        // アプリがバックグラウンドにある状態で通知が届いた場合
        if(application.applicationState == UIApplicationState.Inactive) {
            // ここに処理を書く
            print("background")
        }
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        // backgroundから復帰した時
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

