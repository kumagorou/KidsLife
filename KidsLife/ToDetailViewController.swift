//
//  EventDetail.swift
//  KidsLife
//
//  Created by k12031kk on 2015/11/28.
//  Copyright © 2015年 ToruNakandakari. All rights reserved.
//

import UIKit
import LocalAuthentication

class ToDetailViewController: UIViewController {
    
    private var myButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print("hoge = \(appDelegate.blendName!)")
        
        myButton = UIButton()
        
        myButton.frame = CGRectMake(0, 0, 200, 40)
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:200)
        myButton.backgroundColor = UIColor.redColor()
        
        myButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        // ボタンをViewに追加する.
        self.view.addSubview(myButton)
    }
    
     internal func onClickMyButton(sender: UIButton){
        let context = LAContext();
        var error :NSError?
        // Touch ID が利用できるデバイスか確認する
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 利用できる場合は指紋認証を要求する
            context.evaluatePolicy(
                LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason:"指紋認証を親御さんにお願いしてね！",
                reply: {
                    success, error in
                    if (success) {
                        // 指紋認証成功
                        NSLog("Success")
                        
                    
                    } else {
                        // 指紋認証失敗
                        NSLog("Error")
                    }
            })
        } else {
            // Touch ID が利用できない場合
            NSLog("An Error Occurred: \(error)")
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    

}
