//
//  MedalTouchScrollView.swift
//  KidsLife
//
//  Created by X-men on 2015/11/28.
//  Copyright © 2015年 ToruNakandakari. All rights reservedimi


import UIKit

class MedalTouchScrollView: UIScrollView {
    
    var medalDelegate: MedalImageTouchScrollViewDelegate!
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Medal Touched")
        
        super.touchesEnded(touches as Set<UITouch>, withEvent: event)
        
        for touch: AnyObject in touches {
            let t: UITouch = touch as! UITouch
            self.medalDelegate.modalChanged(Int(t.view!.tag - 1))
        }
    }
}