//
//  LocalNotificationManager.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 10/24/21.
//

import Foundation
import SwiftUI

class LocalNotificationManager: ObservableObject {
    var notification = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success && error == nil {
                print("Notification Permission granted")
            } else {
                print("Notifications Denied")
            }
        }
    }
    
    func triggerPermissions() {
        print("notification permission requested")
    }
    
    func sendDailyNotification(title: String, subtitle: String?, body: String, reminderTime: Int, notificationID: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        content.body = body
        
        // Handle the scheulding of notification. This will send it out at the given reminder time daily.
        var dateComponents = DateComponents()
        dateComponents.hour = reminderTime
    
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
