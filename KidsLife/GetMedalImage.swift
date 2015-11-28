//
//  GetMedalImage.swift
//  KidsLife
//
//  Created by X-men on 2015/11/29.
//  Copyright © 2015年 ToruNakandakari. All rights reserved.
//

import UIKit
import SwiftyJSON

class GetMedal{
    
    let urlString = "http://192.168.100.150/api/medal"
    
    //アクセス中かどうか
    var isInLoad = false
    
    var imageArray: [UIImage] = []
    
    func getImageData() -> [UIImage]{
        self.isInLoad = true
        let url = NSURL(string: self.urlString)!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            var json: JSON = JSON(data: data!)
            
            for i in 0..<json.count{
                let imageURL = json[i]["image"]
                let medalImage = NSURL(string: "\(imageURL)")
                let getImage :NSData = try!NSData(contentsOfURL: medalImage!,options: NSDataReadingOptions.DataReadingMappedIfSafe);
                let img = UIImage(data: getImage)
                
                self.imageArray.insert(UIImage(), atIndex: i)
                self.imageArray[i] = img!
                
            }
            //ロードの終了
            self.isInLoad = false
        })
        task.resume()
        
        while isInLoad{
            usleep(10)
        }
        return imageArray
    }
    func sendFavoriteMedal(number: Int){
        let urlString = "http://192.168.100.150/api/medal?favorite_id=\(number)&user_id=1"
        var request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        
        request.HTTPMethod = "GET"
        
        var task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { data, response, error in
            if (error == nil) {
                var result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(result)
            } else {
                print(error)
            }
        })
        task.resume()
        
    }

}
