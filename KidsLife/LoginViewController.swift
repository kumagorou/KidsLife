//
//  LoginViewController.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SCLAlertView

class LoginViewController: UIViewController {
        
    let screenSize = UIScreen.mainScreen().bounds
    let horizontalMargin: CGFloat = (UIScreen.mainScreen().bounds.height / 5) - 20
    
    let nameTextField = UITextField(frame: CGRectMake(0, 0, 200, 30))
    let ageTextField = UITextField(frame: CGRectMake(0, 0, 200, 30))
    let sexIconButton = UIButton()
    let alert = SCLAlertView()
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.configureNameTextField()
        self.configureAgeTextField()
        self.configureSexButton()
        self.createRegisterButton()
        // 数字のみのTextFieldを下げるために必要
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped")
        self.view.addGestureRecognizer(tapGesture)
        
        //　端末情報(UUID)の取得
        let uuid: NSString = NSUUID().UUIDString
        defaults.setObject(uuid, forKey: "UUID")
        
        print(defaults.objectForKey("UUID") as! String)
        
    }
    
    
    func configureNameTextField() {
        nameTextField.placeholder = "なまえ"
        nameTextField.delegate = self
        nameTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        let x = (self.screenSize.width / 2) - (nameTextField.frame.size.width / 2)
        let y = self.horizontalMargin
        let pos = CGPointMake(x, y)
        nameTextField.frame.origin = pos

        self.view.addSubview(nameTextField)
    }
    
    func configureAgeTextField() {
        ageTextField.placeholder = "なんさい"
        ageTextField.delegate = self
        ageTextField.borderStyle = UITextBorderStyle.RoundedRect
        ageTextField.keyboardType = .NumberPad // 数字のみ入力可
        
        let x = (self.screenSize.width / 2) - (ageTextField.frame.size.width / 2)
        let y = (self.horizontalMargin * 2) + 30 // nameTextFieldのheight分下げる
        let pos = CGPointMake(x, y)
        ageTextField.frame.origin = pos
        
        self.view.addSubview(ageTextField)
    }
    
    func configureSexButton() {
        let buttonSize: CGFloat = 100
        let buttonX = (self.screenSize.width / 2 ) - (buttonSize / 2)
        let buttonY = self.horizontalMargin * 3 + 30 // ageTextFieldのheight分下げる
        let buttonRect = CGRectMake(buttonX, buttonY, buttonSize, buttonSize)
        
        self.sexIconButton.frame = buttonRect
        self.sexIconButton.setTitle("おとこのこ", forState: .Normal)
        self.sexIconButton.backgroundColor = UIColor.blueColor()
        
        // ボタンを丸くする
        self.sexIconButton.layer.masksToBounds = true
        self.sexIconButton.layer.cornerRadius = buttonSize / 2
        self.sexIconButton.layer.borderWidth = 1.0
        
        // 押した時にボタンのタイトルを変更する
        self.sexIconButton.addTarget(self, action: "changeSex:", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.sexIconButton)
    }
    
    func createRegisterButton() {
        // 登録ボタンの座標を決める
        let buttonWidth :CGFloat = 200
        let buttonHeight: CGFloat = 50
        let buttonX = (self.screenSize.width / 2 ) - (buttonWidth / 2)
        let buttonY = self.horizontalMargin * 4 + 100 // sexButtonのheight分下げる
        let buttonRect = CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)
        
        let button = UIButton(frame: buttonRect)
        button.setTitle("登録", forState: .Normal)
        
        // ボタンを丸くする
        button.layer.masksToBounds = true
        button.layer.cornerRadius = buttonHeight / 2
        button.layer.borderWidth = 1.0
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: "moveTabBarViewController", forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    
    func changeSex(sender: UIButton) {
        if (sender.titleLabel?.text == "おとこのこ") {
            sender.setTitle("おんなのこ", forState: .Normal)
            sender.backgroundColor = UIColor.redColor()
            return
        }
        sender.setTitle("おとこのこ", forState: .Normal)
        sender.backgroundColor = UIColor.blueColor()
    }
    
    func moveTabBarViewController() {
        // 登録できない場合(TextFieldの値が空白とかnil)
        if (!self.canRegister()) {
            return
        }
        
        // データがちゃんと入力されている場合はNSUserDefaultsに保存する
        self.register()
        
        // tabBarをAppDelegateがgetする
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let myTabBarController = delegate.myTabBarController
        self.presentViewController(myTabBarController, animated: true, completion: nil)
    }
    
    func register() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(nameTextField.text, forKey: "name")
        defaults.setObject(ageTextField.text, forKey: "age")
        defaults.setObject(self.sexIconButton.titleLabel?.text, forKey: "sex")
    }
    
    func tapped() {
        self.view.endEditing(true) // 表示されているキーボードを閉じる
    }
    
    func canRegister() -> Bool {
        // TextFieldの中身を調べる
        if (self.nameTextField.text == "" || self.nameTextField.text == nil) {
            // アラートを表示する

            alert.showError("まちがい", subTitle: "名前が正しく入力されていません", closeButtonTitle: "はい", duration: 0)
            return false
        }
        if (self.ageTextField.text == "" || self.ageTextField.text == nil) {
            alert.showError("まちがい", subTitle: "年齢が正しく入力されていません", closeButtonTitle: "はい", duration: 0)
            return false
        }
        return true
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder() // return時にキーボードを閉じる
        return true
    }
}