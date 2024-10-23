//
//  LocalNotificationView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 23/10/2024.
//

import SwiftUI
import UserNotifications
import CoreLocation

class LocalNotificationManager {
    static let instance = LocalNotificationManager()
    
    func requestPermission() -> Void {
        let options : UNAuthorizationOptions = [.alert,  .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("notificatin ERROR: \(error)")
            }else {
                print("success")
            }
        }
        
    }
    
    func scheduleNotification() -> Void {
        let content = UNMutableNotificationContent()
        content.title = "this is my first notification"
        content.subtitle = "that was so easyy"
        content.sound = .default
        content.badge = 1
        
        // trigger types
        
        // time
            // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //calendar
//            var dateComponent = DateComponents()
//            dateComponent.hour = 16
//            dateComponent.minute = 25
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
//        location
        let center = CLLocationCoordinate2D(latitude: 37.335400, longitude: -122.009201)
        let region = CLCircularRegion(center: center, radius: 100, identifier: "Headquarters")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationView: View {
    var body: some View {
        VStack(spacing: 20){
            Button("request permission") {
                LocalNotificationManager.instance.requestPermission()
            }
            Button("schedule Notification") {
                LocalNotificationManager.instance.scheduleNotification()
            }
            Button("cancel Notification") {
                LocalNotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}

#Preview {
    LocalNotificationView()
}
