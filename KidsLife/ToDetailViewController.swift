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
    let alertGetMedal = SCLAlertView()
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
    var state = "" // 1:notJoin 2:Joining

    var eventImage = UIImageView()
    var scrollView = UIScrollView()
    var joinButton = UIButton()
    var medalGetButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)

        self.urlString = "\(self.urlString)\(appDelegate.jsonData!["id"])"
        self.getEventDetail()

        self.createScrollView()
        self.createEventImage()
        self.createLabels()
        
        // 予約ボタンを表示
        if (self.state == "1") {
            self.createJoinButton()
            return
        }
        
        self.createMedalGetButton()
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
                self.state = json[i]["state"].stringValue
            }
            // ロードが完了したので、falseに
            self.isInLoad = false
        })
        task.resume()
        
        while isInLoad {
            usleep(5)
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
        let labelSize: CGFloat = 25
        self.eventLabel.frame = CGRectMake(0, (UIScreen.mainScreen().bounds.size.height / 2) - (44 + 15), UIScreen.mainScreen().bounds.size.width, 50)
        self.eventLabel.layer.cornerRadius = 1.0
        self.eventLabel.font = UIFont(name: "Helvetica", size: 25)
        self.eventLabel.textAlignment = .Center
        self.scrollView.addSubview(self.eventLabel)
        
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
        self.joinButton.titleLabel?.alpha = 0
        self.joinButton.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width / 2) - 75, self.tagLabel.frame.origin.y + self.horizontalMargin * 2 + self.tagLabel.frame.size.height, 150, 70)
        self.joinButton.setTitle("join", forState: .Normal)
        let buttonImage = UIImage(named: "Join.png")
        self.joinButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        
        self.joinButton.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(self.joinButton)
    }
    
    func createMedalGetButton() {
        self.medalGetButton.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width / 2) - 75, self.tagLabel.frame.origin.y + self.horizontalMargin * 2 + self.tagLabel.frame.size.height, 150, 70)
        let buttonImage = UIImage(named: "medalget.png")
        self.medalGetButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        
        self.medalGetButton.addTarget(self, action: "getMedal", forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(self.medalGetButton)
    }
    
    func getMedal() {
        // 選択したイベントの参加を認証する
        let context = LAContext();
        var error :NSError?
        // Touch ID が利用できるデバイスか確認する
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 利用できる場合は指紋認証を要求する
            context.evaluatePolicy(
                LAPolicy.DeviceOwnerAuthenticationWithBiometrics,
                localizedReason:"イベントの感想を親御さんに伝えてきてね",
                reply: {
                    success, error in
                    if (success) {
                        // アラート表示
                        self.getMedalShowAlert()
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
    
    func getMedalShowAlert() {
        
        alertGetMedal.showCloseButton = false
        alertGetMedal.addButton("やったー") {
        self.appDelegate.greenMedalFlag = true
        }
        alertGetMedal.showSuccess("メダルゲット！", subTitle: "", closeButtonTitle: "hoge", duration: 0)
    }
    
     internal func onClickMyButton(sender: UIButton){
        
        // 参加を取り消ししようとしている場合
        if (self.joinButton.titleLabel?.text != "join") {
            self.cancelEvent()
            return
        }
        
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
            self.successAlert.showCloseButton = false
            self.successAlert.addButton("はい") {
                self.serverPost(2)
                self.changeRegisterButton()
            }
            self.successAlert.showSuccess("予約完了", subTitle: "イベントへの予約を受け付けました", closeButtonTitle: "はい", duration: 0)
        }
    }
    
    func cancelEvent() {
        self.successAlert.showCloseButton = true
        self.successAlert.addButton("はい") {
            self.serverPost(1)
            self.changeRegisterButton()
        }
        self.successAlert.showSuccess("予約キャンセル", subTitle: "イベントをキャンセルしますか？", closeButtonTitle: "いいえ", duration: 0)
    }

    func serverPost(index: Int) {
        let eventID = appDelegate.jsonData!["id"].stringValue
        // cancel:1  join:2
        let urlString = "http://192.168.100.150/api/event?event=\(eventID)&state=\(index)"
        let request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        request.HTTPMethod = "GET"
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            if (error == nil) {
                let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(result)
                self.showNotification(index)
            } else {
                print(error)
            }
        })
        task.resume()
    }
    
    func showNotification(index: Int) {
        let myNotification = UILocalNotification()
        myNotification.userInfo = ["notification\(appDelegate.jsonData!["id"])" : "cancelKey"]
        // cancel:1 join:2
        
        if (index == 1) {
            // キャンセル処理
            // Notificationの生成する.
            if let notifications = UIApplication.sharedApplication().scheduledLocalNotifications {
                for notification in notifications {
                    if let value = notification.userInfo!["cancelKey"] as? String {
                        if (value == "notification1") {
                            UIApplication.sharedApplication().cancelLocalNotification(notification)
                        }
                    }
                }
            }

        } else {
            myNotification.alertBody = "イベントのお時間ですよ〜"
            myNotification.soundName = UILocalNotificationDefaultSoundName
            myNotification.timeZone = NSTimeZone.defaultTimeZone()
            myNotification.fireDate = NSDate(timeIntervalSinceNow: 10) // 今はテストで参加確定10秒後通知
            UIApplication.sharedApplication().scheduleLocalNotification(myNotification)
        }
    }
    
    func changeRegisterButton() {
        // 押されたのが参加取消の場合
        if (self.joinButton.titleLabel?.text != "join") {
            self.joinButton.setTitle("join", forState: .Normal)
            self.joinButton.setBackgroundImage(UIImage(named: "Join.png"), forState: .Normal)
            return
        }
        self.joinButton.setTitle("willJoin", forState: .Normal)
        self.joinButton.setBackgroundImage(UIImage(named: "WillJoin.png"), forState: .Normal)
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
