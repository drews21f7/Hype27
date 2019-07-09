//
//  AppDelegate.swift
//  Hype27
//
//  Created by Drew Seeholzer on 7/9/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit
import UserNotifications
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (userDidAllow, error) in
            if let error = error {
                print(" There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
            }
            
            if userDidAllow == true {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            
        }
        // Override point for customization after application launch.
        
        // Testing
//        let testHype = "lets see if this works22"
//        let hypeC = HypeController()
//        hypeC.saveHype(with: testHype) { (success) in
//            if success {
//                print ("It worked")
//            }
//        }
//        hypeC.fetchDemHypes { (success) in
//            for hype in hypeC.hypes {
//                print(hype.hypeText)
//            }
//        }
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        HypeController.sharedInstance.subscribeToRemoteNotifications { (error) in
            if let error = error {
                print(" There was an error in \(#function) ; \(error) ; \(error.localizedDescription)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error registering APNS : \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        HypeController.sharedInstance.fetchDemHypes { (success) in
            if success {
                // TODO: - Notification?
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
    }
}

