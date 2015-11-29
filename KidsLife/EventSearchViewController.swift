//
//  EventSearchViewController.swift
//  KidsLife
//
//  Created by ToruNakandakari on H27/11/28.
//  Copyright © 平成27年 ToruNakandakari. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    // セクションの数
    let sectionNum = 1
    // 1セクションあたりのセルの行数
    let cellNum = 5
    let urlString = "http://192.168.100.150/api/event" //適当なjsonファイルへのパス
    // セルの中身
    var MyTableItems = NSMutableArray()
    var myTableJSON = [JSON]()
    // ロード中かどうか
    var isInLoad = false
    // 選択されたセルの列番号
    var selectedRow: Int?
    
    private var myTableView: UITableView!
    
    //pictureURLを代入する変数
    private var imageURL:NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // json取得->tableに突っ込む
        makeTableData()
        self.view.backgroundColor = UIColor.whiteColor()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        //セルの高さを変更
        myTableView.rowHeight = 100.0;
        
        // Cell名の登録をおこなう.
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
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
    
    // json取得->tableに突っ込む
    func makeTableData() {
        self.isInLoad = true
        let url = NSURL(string: self.urlString)!
        //print(url);
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error in
            
            // リソースの取得が終わると、ここに書いた処理が実行される
            var json : JSON = JSON(data: data!)
            //デバック用
             //print(json)
            
            // 各セルに情報を突っ込む
            //適当なJSONファイルが持っている値
            //var index = 0;
            for var i = 0; i < json.count; i++ {
                //デバック用
                //print(json.count)
                //let event_id = json[i]["event_id"]
                let eventname = json[i]["event_name"]
                let date = json[i]["date"]
                let place = json[i]["place"]
                let tag = json[i]["tag"]
                let pictureurl =  json[i]["pictureurl"]
                //イベントの画像URLを代入
                self.imageURL = NSURL(string: pictureurl.stringValue)
                let info = "\(eventname)\n\(date)\n\(place)\n\(tag)"
                self.MyTableItems[i] = info
                self.myTableJSON.append(json[i])
            }
            // ロードが完了したので、falseに
            self.isInLoad = false
        })
        task.resume()
        
        while isInLoad {
            usleep(10)
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionNum
    }
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        print("Num: \(indexPath.row)")
        print("Value: \(MyTableItems[indexPath.row])")
        let appDegegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //appDegegate.blendName! = Int(cellNum)
        appDegegate.jsonData = self.myTableJSON[indexPath.row]
        let detailViewController = ToDetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    
    /*
    Cellの総数を返すデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyTableItems.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    (実装必須)
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        cell.textLabel?.numberOfLines = 4
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(MyTableItems[indexPath.row])"
        
        //ImageData型に変更
        let Imagedata = NSData(contentsOfURL: imageURL)
        //Imageを表示
        let image: UIImage = UIImage(data: Imagedata!)!
        
        cell.imageView!.image = image
        
        return cell
    }
 

}
