//
//  EventSearchViewController.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventSearchViewController: UITableViewController{

    
    // セクションの数
    let sectionNum = 1
    // 1セクションあたりのセルの行数
    let cellNum = 5
    let urlString = "http://192.168.100.150/Eventdata.json" //適当なjsonファイルへのパス
    // セルの中身
    var cellItems = NSMutableArray()
    // ロード中かどうか
    var isInLoad = false
    // 選択されたセルの列番号
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // json取得->tableに突っ込む
        makeTableData()
        self.view.backgroundColor = UIColor.whiteColor()


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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // json取得->tableに突っ込む
    func makeTableData() {
        self.isInLoad = true
        var url = NSURL(string: self.urlString)!
        var task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            // リソースの取得が終わると、ここに書いた処理が実行される
            var json = JSON(data: data)
            
            println(json["list"])
            // 各セルに情報を突っ込む
            //適当なJSONファイルが持っている値
            for var i = 0; i < self.cellNum; i++ {
                var eventname = json["list"][i]["eventname"]
                var date = json["list"][i]["date"]
                var place = json["list"][i]["place"]
                var tag = json["list"][i]["tag"]
                var pictureurl =  json["list"][i]["pictureurl"]
                var info = "\(eventname), \(date), \(date), \(place),\(tag),\(pictureurl)"
                self.cellItems[i] = info
                println(eventname)
            }
            // ロードが完了したので、falseに
            self.isInLoad = false
        })
        task.resume()
        
        while isInLoad {
            usleep(10)
        }
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionNum
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return titleName.count
        return self.cellNum
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("list", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.cellItems[indexPath.row] as? String
        return cell
    }
    override func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("detail", sender: nil)
    }
    
    
    /*
    //ここは要検証
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var CellIdentifier: String = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)!
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        cell.textLabel!.text = "rakuishi07"
        var imageURL: String = "http://rakuishi.com/wp-content/themes/rakuishi/image/rakuishi.png"
        var image: UIImage = UIImage.imageWithData(NSData.dataWithContentsOfURL(NSURL(string: imageURL))!)
        cell.imageView!.image = image
        return cell
    }
    */

}
