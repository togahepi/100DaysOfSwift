//
//  ViewController.swift
//  Project21
//
//  Created by user197801 on 6/25/21.
//

import UIKit
import UserNotifications
import WebKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    var website = "hackingwithswift.com"
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://" + website)!
        webView.load(URLRequest(url: url))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedual", style: .plain, target: self, action: #selector(schedualLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            if granted {
                print("Yay!!!")
            } else {
                print("Oh no....")
            }
        }
    }
    
    @objc func schedualLocal() {
        registerCategories()
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Coming to learn Swift for everyday"
        content.body = "This is a marathon so keep coming to learn day by day! ;)"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Take me to lesson", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data receive: \(customData)")
            
            switch response.actionIdentifier {
            
            case UNNotificationDefaultActionIdentifier:
                let ac = UIAlertController(title: "Welcome back folks!", message: "Let learn Swift and SwiftUI today!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok! Go, go!", style: .cancel))
                present(ac, animated: true)
            case "show":
                let ac = UIAlertController(title: "You're hungry for Swift knowledge, aren't you?", message: "Let make awesome app with Swift!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yes! Bam, bam bam!", style: .cancel))
                present(ac, animated: true)
            default:
                break
            }
            completionHandler()
        }
    }
}

