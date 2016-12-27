//
//  NotificationManager.swift
//  IPCanary
//
//  Created by Seth Butler on 12/26/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager: NSObject {
    
    private var notificationIDcntr = 0
    
    var notificationsActive: Bool = false
    
    override init() {
        super.init()
        self.registerForNotifications()
    }
    
    func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted,error) in
            if granted {
                //self.setupAndGenerateLocalNotification()
                UNUserNotificationCenter.current().delegate = self
                print("NotificationManager: The delegate was set")
            }
            self.notificationsActive = granted
        })
    }
    
    //TODO: - Delete/update previous notifications if new ip change?
    func notifyUserOnce(title: String, subtitle: String, body: String?, waitTime: Int) {
        if(notificationsActive) {
            
            // 1
            //let highFiveAction = UNNotificationAction(identifier: "Testid", title: "High Five", options: [])
            
            let category = UNNotificationCategory(identifier: "test", actions: [], intentIdentifiers: [], options: .customDismissAction)
            UNUserNotificationCenter.current().setNotificationCategories([category])
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(waitTime), repeats: false)
            
            notificationIDcntr += 1
            let requestIdentifer = "notification.\(notificationIDcntr)"
            let request = UNNotificationRequest(identifier: requestIdentifer, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if(error != nil) {
                    print("NotificationManager: The user notification of was not successfully scheduled: \(error)")
                } else {
                    print("NotificationManager: The notification was scheduled")
                }
            })
            
            UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { notifications in
                for noti in notifications {
                    print("NotificationManager: Date of notification: \(noti.date)")
                }
                print("NotificationManager: Num successful delivered = \(notifications.count)")
            })
            
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { notificationRequests in
                for notiRequest in notificationRequests {
                    print("NotificationManager: Pending Notification identifier: \(notiRequest.identifier)")
                }
                print("NotificationManager: Num pending notifications = \(notificationRequests.count)")
            })
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("NotificationManager: Foreground notification started")
        completionHandler([.alert, .sound])
    }
    
    /// Handles Notification Actions resulting from user interaction with the notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
            
            // NotificationActions is a custom String enum I've defined
            //case NotificationActions.HighFive.rawValue:
        //  print("High Five Delivered!")
        default: completionHandler()
        }
    }
}
