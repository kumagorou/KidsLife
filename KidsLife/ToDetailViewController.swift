//
//  EventDetail.swift
//  KidsLife
//
//  Created by k12031kk on 2015/11/28.
//  Copyright © 2015年 ToruNakandakari. All rights reserved.
//

import UIKit
import LocalAuthentication
import SwiftyJSON
import SCLAlertView

extension UIImage{
    
    // Resizeするクラスメソッド.
    func ResizeÜIImage(width : CGFloat, height : CGFloat)-> UIImage!{
        
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSizeMake(width, height))
        
        // コンテキストに自身に設定された画像を描画する.
        self.drawInRect(CGRectMake(0, 0, width, height))
        
        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // コンテキストを閉じる.
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}

class ToDetailViewController: UIViewController {
    
    let successAlert = SCLAlertView()
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    let horizontalMargin: CGFloat = (UIScreen.mainScreen().bounds.size.width) / 20
    var urlString = "http://192.168.100.150/api/event?id="
    var isInLoad = false
    
    let eventLabel = UILabel()
    var eventName = ""
    let capacityLabel = UILabel()
    var capacity = ""
    let payLabel = UILabel()
    var pay = ""
    let dateLabel = UILabel()
    var date = ""
    let placeLabel = UILabel()
    var place = ""
    let tagLabel = UILabel()
    var tag = ""

    var eventImage = UIImageView()
    var scrollView = UIScrollView()
    var joinButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)

        self.urlString = "\(self.urlString)\(appDelegate.jsonData!["id"])"
        self.getEventDetail()

        self.createScrollView()
        self.createEventImage()
        self.createLabels()
        self.createJoinButton()
    }
    
    func getEventDetail() {
        self.isInLoad = true
        let url = NSURL(string: self.urlString)!
        //print(url);
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            
            // リソースの取得が終わると、ここに書いた処理が実行される
            var json = JSON(data: data!)
            //デバック用
            //print(json)
            
            // 各セルに情報を突っ込む
            //適当なJSONファイルが持っている値
            //var index = 0;
            for var i = 0; i < json.count; i++ {
                self.eventName = json[i]["event_name"].stringValue
                self.capacity = json[i]["capacity"].stringValue
                self.pay = json[i]["pay"].stringValue
                self.date = json[i]["date"].stringValue
                self.place = json[i]["place"].stringValue
                self.tag = json[i]["tag"].stringValue
            }
            // ロードが完了したので、falseに
            self.isInLoad = false
        })
        task.resume()
        
        while isInLoad {
            usleep(2)
        }
    }
    
    func createEventImage() {
        let imageViewWidth = UIScreen.mainScreen().bounds.size.width
        let imageViewHeight = (UIScreen.mainScreen().bounds.size.height) / 2

        self.eventImage.frame = CGRectMake(0, 0, imageViewWidth, imageViewHeight)
        print(self.eventImage.frame)
        
        
        if let url = NSURL(string: self.appDelegate.jsonData!["pictureurl"].stringValue) {
            let image = UIImage(data: NSData(contentsOfURL: url)!)
            self.eventImage.image = image
        }
        print(self.eventImage.frame)
        self.view.addSubview(self.eventImage)
    }
    
    func createScrollView() {
        let viewWidth = UIScreen.mainScreen().bounds.size.width
        let viewHeight = UIScreen.mainScreen().bounds.size.height
        self.scrollView.frame = CGRectMake(0, 0, viewWidth, viewHeight)
        self.view.addSubview(self.scrollView)
    }
    
    func createLabels() {
//        let backgroundView = UIImageView(image: UIImage(named: "TitleBackground.png"))
//        
//        backgroundView.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height / 2 - (44 + 15), UIScreen.mainScreen().bounds.size.width, 50)
//        
//        self.scrollView.addSubview(backgroundView)
//        
        let labelSize: CGFloat = 25
//        self.eventLabel.frame = CGRectMake(0, (backgroundView.frame.size.height / 2) - 25, UIScreen.mainScreen().bounds.size.width, 50)
        self.eventLabel.frame = CGRectMake(0, (UIScreen.mainScreen().bounds.size.height / 2) - (44 + 15), UIScreen.mainScreen().bounds.size.width, 50)
        self.eventLabel.layer.cornerRadius = 1.0
//        self.eventLabel.backgroundColor = UIColor.redColor()
        self.eventLabel.font = UIFont(name: "Helvetica", size: 25)
        self.eventLabel.textAlignment = .Center
        self.scrollView.addSubview(self.eventLabel)
//        backgroundView.addSubview(self.eventLabel)
        
        
        self.capacityLabel.frame = CGRectMake(0, self.eventLabel.frame.origin.y + self.horizontalMargin + labelSize * 2, UIScreen.mainScreen().bounds.width, labelSize)
        self.capacityLabel.font = UIFont(name: "Helvetica", size: 20)
        self.capacityLabel.textAlignment = .Center
        self.scrollView.addSubview(self.capacityLabel)
        
        self.payLabel.frame = CGRectMake(0, self.capacityLabel.frame.origin.y + self.horizontalMargin + labelSize, UIScreen.mainScreen().bounds.width, labelSize)
        self.payLabel.font = UIFont(name: "Helvetica", size: 20)
        self.payLabel.textAlignment = .Center
        self.scrollView.addSubview(self.payLabel)
        
        self.dateLabel.frame = CGRectMake(0, self.payLabel.frame.origin.y + self.horizontalMargin + labelSize, UIScreen.mainScreen().bounds.width, labelSize)
        self.dateLabel.font = UIFont(name: "Helvetica", size: 20)
        self.dateLabel.textAlignment = .Center
        self.scrollView.addSubview(self.dateLabel)
        
        self.placeLabel.frame = CGRectMake(0, self.dateLabel.frame.origin.y + self.horizontalMargin + labelSize, UIScreen.mainScreen().bounds.width, labelSize)
        self.placeLabel.font = UIFont(name: "Helvetica", size: 20)
        self.placeLabel.textAlignment = .Center
        self.scrollView.addSubview(self.placeLabel)
        
        self.tagLabel.frame = CGRectMake(0, self.placeLabel.frame.origin.y + self.horizontalMargin + labelSize, UIScreen.mainScreen().bounds.width, labelSize)
        self.tagLabel.font = UIFont(name: "Helvetica", size: 20)
        self.tagLabel.textAlignment = .Center
        self.scrollView.addSubview(self.tagLabel)
        
        
        self.scrollView.contentSize = CGSizeMake(0, self.tagLabel.frame.origin.y + 200)
        
        dispatch_async(dispatch_get_main_queue()) {
            // UIの更新
            self.eventLabel.text = self.eventName
            self.capacityLabel.text = "人数 : \(self.capacity)名"
            self.payLabel.text = "参加費 : \(self.pay)円"
            self.dateLabel.text = "日付 : \(self.date)"
            self.placeLabel.text = "場所 : \(self.place)"
            self.tagLabel.text = "ジャンル : \(self.tag)"
        }
    }
    
    func createJoinButton() {
        self.joinButton.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width / 2) - 75, self.tagLabel.frame.origin.y + self.horizontalMargin * 2 + self.tagLabel.frame.size.height, 150, 70)
        let buttonImage = UIImage(named: "Join.png")
        self.joinButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        
        self.joinButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(self.joinButton)
    }
    
     internal func onClickMyButton(sender: UIButton){
        // 選択したイベントの参加を認証する
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
                        self.successJoinEvent()
                    
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
    
    func successJoinEvent() {
        dispatch_async(dispatch_get_main_queue()) {
            self.successAlert.showSuccess("予約完了", subTitle: "イベントへの予約を受け付けました", closeButtonTitle: "はい", duration: 0)
        }
        print("hoge")
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
