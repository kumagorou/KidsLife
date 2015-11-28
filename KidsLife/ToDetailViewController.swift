//
//  EventDetail.swift
//  KidsLife
//
//  Created by k12031kk on 2015/11/28.
//  Copyright © 2015年 ToruNakandakari. All rights reserved.
//

import UIKit

class ToDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        print("hoge = \(appDelegate.blendName!)")
        // Do any additional setup after loading the view.
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
