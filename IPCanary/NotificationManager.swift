//
//  NotificationManager.swift
//  IPCanaryKit
//
//  Created by Seth Butler on 12/26/16.
//  Copyright © 2016 SBSoftware. All rights reserved.
//

import Foundation
import UserNotifications

public class NotificationManager: NSObject {
    
    private var notificationIDcntr = 0
    
    var notificationsActive: Bool = false
    
    public override init() {
        super.init()
        self.registerForNotifications()
    }
    
    func registerForNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: { (granted,error) in
            if granted {
                UNUserNotificationCenter.current().delegate = self
                print("NotificationManager: The delegate was set")
            }
            self.notificationsActive = granted
        })
    }
    
    //TODO: - Delete/update previous notifications if new ip change?
    func notifyUserOnce(title: String, subtitle: String, body: String?, waitTime: TimeInterval) {
        if(notificationsActive) {
            
            let notificationCenter = UNUserNotificationCenter.current()
            
//            let category = UNNotificationCategory(identifier: "test", actions: [], intentIdentifiers: [], options: .customDismissAction)
//            notificationCenter.setNotificationCategories([category])
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.subtitle = subtitle
            //guard content.body = body
            content.badge = 1
            content.sound = UNNotificationSound.default()
            
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: waitTime, repeats: false)
            
            notificationIDcntr += 1
            let requestIdentifer = "notification.\(notificationIDcntr)"
            let request = UNNotificationRequest(identifier: requestIdentifer, content: content, trigger: trigger)

            
            notificationCenter.add(request, withCompletionHandler: { error in
                if(error != nil) {
                    print("NotificationManager: The user notification of was not successfully scheduled: \(error)")
                } else {
                    print("NotificationManager: The notification was scheduled")
                }
            })
            
            notificationCenter.getDeliveredNotifications(completionHandler: { notifications in
                for noti in notifications {
                    print("NotificationManager: Date of notification: \(noti.date)")
                }
                print("NotificationManager: Num successful delivered = \(notifications.count)")
            })
            
            notificationCenter.getPendingNotificationRequests(completionHandler: { notificationRequests in
                for notiRequest in notificationRequests {
                    print("NotificationManager: Pending Notification identifier: \(notiRequest.identifier)")
                }
                print("NotificationManager: Num pending notifications = \(notificationRequests.count)")
            })
        }
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("NotificationManager: Foreground notification started")
        completionHandler([.alert, .sound])
    }
    
    /// Handles Notification Actions resulting from user interaction with the notifications
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("NotificationManager: Notification interacted with by user")
        switch response.actionIdentifier {
            
            // NotificationActions is a custom String enum I've defined
            //case NotificationActions.HighFive.rawValue:
        //  print("High Five Delivered!")
        default: completionHandler()
        }
    }
}
