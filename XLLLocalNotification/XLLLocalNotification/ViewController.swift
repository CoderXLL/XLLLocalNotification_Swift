//
//  ViewController.swift
//  XLLLocalNotification
//
//  Created by 肖乐 on 2018/1/10.
//  Copyright © 2018年 IMMoveMobile. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func pushBtnClick(_ sender: Any) {
        
        if #available(iOS 10.0, *) {
            
            // 1.设置触发条件
            let timeTrigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.5, repeats: false)
            // 2.创建通知内容
            let content = UNMutableNotificationContent.init()
            content.body = "我是小明"
            content.badge = NSNumber(value:(UIApplication.shared.applicationIconBadgeNumber + 1))
            content.sound = UNNotificationSound.default()
            let detail = "其实他是假小明"
            let userInfo:Dictionary<String,String>=["detail":detail]
            content.userInfo = userInfo
            // 3.通知标识
            let requestIdentifier = NSString.init(format: "%lf", NSDate().timeIntervalSince1970)
            // 4.创建通知请求，将1，2，3添加到请求中
            let request = UNNotificationRequest(identifier: requestIdentifier as String, content: content, trigger: timeTrigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                
                if error == nil {
                    print("推送成功")
                }
            })
            
        } else {
            
            let notification = UILocalNotification.init()
            notification.alertBody = "我是小明"
            notification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
            notification.soundName = UILocalNotificationDefaultSoundName
            let detail = "其实他是假小明"
            let userInfo:Dictionary<String,String>=["detail":detail]
            notification.userInfo = userInfo
            DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now()+5.0) {
                
                UIApplication.shared.presentLocalNotificationNow(notification)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

