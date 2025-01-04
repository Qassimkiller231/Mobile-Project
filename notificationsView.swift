//
//  notificationsView.swift
//  testfinalfinal
//
//  Created by Ebrahim Aqeel Matrook Alderazi on 13/12/2024.
//

import UIKit
import UserNotifications

class notificationsView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkForpermission()
        
        // Do any additional setup after loading the view.
    }

    func checkForpermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{ settings in
            switch settings.authorizationStatus {
        case .authorized:
            self.dispatchNotification()
        case .denied:
            return
        case .notDetermined:
            notificationCenter.requestAuthorization(options: [.alert, .sound]){ didAllow, error in if didAllow{
                self.dispatchNotification()
                
            }
          }
            default:
                return
        }
      }
    }
    
    func  dispatchNotification(){
    let identifier = "my-notification"
     let title = "Next Step"
     let body = " New Job posting !"
     let hour = 10
     let minute = 45
     let isDaily = true
     
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calander = Calendar.current
        var dateComponents = DateComponents(calendar: calander, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
}


