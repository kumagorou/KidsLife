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
    
    private var myButton: UIButton!
    //pictureURLを代入する変数
    private var picture_name:NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //print("hoge = \(appDelegate.blendName!)")
        
        //print("json = \(appDelegate.jsonData")
        print (appDelegate.jsonData!["id"])
        // Labelを作成.
        let myLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        
        // ラベルの背景をオレンジ色にする.
        myLabel.backgroundColor = UIColor.orangeColor()
        
        // 枠を丸くする.
        myLabel.layer.masksToBounds = true
        
        // コーナーの半径.
        myLabel.layer.cornerRadius = 20.0
        
        // Labelに文字を代入.
        let event_name = appDelegate.jsonData!["event_name"].stringValue
        myLabel.text = event_name
        
        // 文字の色を白にする.
        myLabel.textColor = UIColor.whiteColor()
        
        // 文字の影の色をグレーにする.
        myLabel.shadowColor = UIColor.grayColor()
        
        // Textを中央寄せにする.
        myLabel.textAlignment = NSTextAlignment.Center
        
        // 配置する座標を設定する.
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: view.bounds.height/2.2)
        
        //let url = NSURL(string: self.urlString)!
        // UIImageに文字を代入.
        picture_name = NSURL(string : appDelegate.jsonData!["pictureurl"].stringValue)
        //NSURLに変更
        //self.url = NSURL(string: picture_name.stringValue)
        
        //ImageData型に変更
        let Imagedata = NSData(contentsOfURL: picture_name)
        //Imageを表示
        let myImage = UIImage(data: (Imagedata)!)!
        
        // リサイズ後のUIImageを用意.
        let resize = myImage.ResizeÜIImage(self.view.frame.midX, height: self.view.frame.midY/2)
        
        // UIImageViewにリサイズ後のUIImageを設定.
        let myImageView = UIImageView(image: resize)
        
        myImageView.layer.position = CGPointMake(self.view.frame.midX, self.view.frame.midY/2)
        
        self.view.addSubview(myImageView)
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyanColor()
        
        // ViewにLabelを追加.
        self.view.addSubview(myLabel)

        myButton = UIButton()
        
        myButton.frame = CGRectMake(0, 0, 200, 80)
        let buttonImage:UIImage = UIImage(named: "medalget.png")!;
        myButton.setBackgroundImage(buttonImage, forState: UIControlState.Normal);
        myButton.layer.position = CGPoint(x: self.view.frame.width/2, y:self.view.frame.height / 1.2)
        //myButton.backgroundColor = UIColor.redColor()
        
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
