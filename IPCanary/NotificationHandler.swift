//
//  NotificationHandler.swift
//  IPCanary
//
//  Created by Seth Butler on 12/26/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationHandler: UNUserNotificationCenterDelegate {
    
    private var notificationIDcntr = 0
    
    var notificationsActive: Bool = false
    
    //TODO: - Delete/updat previous notifications if new ip change?
    func notifyUserOnce(title: String, subtitle: String, body: String?, waitTime: Int) {
        if(notificationsActive) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(waitTime), repeats: false)
            
            notificationIDcntr += 1
            let requestIdentifer = "notification.\(notificationIDcntr)"
            let request = UNNotificationRequest(identifier: requestIdentifer, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if(error != nil) {
                    print("The user notification of was not successfully scheduled")
                } else {
                    print("The notification was scheduled")
                }
            })
            
            UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { notifications in
                for noti in notifications {
                    print("Date of notification: \(noti.date)")
                }
            })
            
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { notificationRequests in
                for notiRequest in notificationRequests {
                    print("Pending Notification identifier: \(notiRequest.identifier)")
                }
            })
        }
    }
}
