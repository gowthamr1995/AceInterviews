//
//  NotificationsManager.swift
//  PetReminders
//
//  Created by Mac Mini on 25/03/2021.
//

import Foundation
import UserNotifications
import UIKit

class NotificationsManager: UIView, UNUserNotificationCenterDelegate{
    
    static var notificationCenter = UNUserNotificationCenter.current()
    
    static func postNotification(notificationPayload: NotificationPayload){
        
        let content = UNMutableNotificationContent()
        content.title = notificationPayload.title
        content.subtitle = notificationPayload.subtitle ?? ""
        content.body = notificationPayload.body
                
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: notificationPayload.trigger)
//        notificationCenter.removeAllPendingNotificationRequests();
        notificationCenter.add(request) { (err) in
            if let err = err{
                print(err.localizedDescription)
            }
        }
    }
            
}
