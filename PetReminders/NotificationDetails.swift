//
//  NotificationDetails.swift
//  PetReminders
//
//  Created by Mac Mini on 26/03/2021.
//

import Foundation
import UserNotifications

struct NotificationPayload {
    let title: String
    let subtitle: String?
    let body: String
    let trigger: UNNotificationTrigger
    
    
}
