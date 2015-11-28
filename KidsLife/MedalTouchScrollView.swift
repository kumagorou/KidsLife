//
//  MedalTouchScrollView.swift
//  KidsLife
//
//  Created by X-men on 2015/11/28.
//  Copyright © 2015年 ToruNakandakari. All rights reservedimi


import UIKit

class MedalTouchScrollView: UIScrollView {
    
    var medalDelegate: MedalImageTouchScrollViewDelegate!
    
    //タッチしたときの処理
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchbegan")
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            self.medalDelegate.modalChanged(Int(t.view!.tag - 1))
        }
    }
    
    //タッチして動かしたときの処理
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchmoved")
    }
    
    //タッチして離したときの処理
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchended")
        super.touchesEnded(touches as Set<UITouch>, withEvent: event)
        
        //どのタグのObjectがとれたか
        for touch: AnyObject in touches {
            var t: UITouch = touch as! UITouch
            self.medalDelegate.modalChanged(Int(t.view!.tag - 1))
        }
        
    }

}