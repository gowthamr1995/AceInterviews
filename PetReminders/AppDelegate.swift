//
//  AppDelegate.swift
//  PetReminders
//
//  Created by Mac Mini on 24/03/2021.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    let notificationCenter = UNUserNotificationCenter.current()
    let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
    

    fileprivate func displaySettingsAlert() {
        let alert = UIAlertController(title: "Please", message: "Gramt acces", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let setting = UIAlertAction(title: "Settings", style: .default) { (settings) in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [: ]) { (open) in
                    if open{
                        print("Settings opened for you")
                    }
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(setting)
        DispatchQueue.main.async {
            UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func requestNotificationPermission(){
        notificationCenter.requestAuthorization(options: notificationOptions) { (granted, error) in
            if granted{
                print("Notification permission granted")
            }
            else{
                print("Notification permission not granted, showing Settings shortcut")
                self.displaySettingsAlert()

            }

        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requestNotificationPermission()
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([UNNotificationPresentationOptions.banner,
                           UNNotificationPresentationOptions.sound,
                           UNNotificationPresentationOptions.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        completionHandler()
    }
    
}
