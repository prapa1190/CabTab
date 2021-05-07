//
//  AppDelegate.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		customizeUI()
		LocationHelper.shared.requestPermission()
		GMSServices.provideAPIKey("AIzaSyDHA8DYEylakzQaUZmY6wUrGlildoOqX-w")
		return true
	}

	// MARK: UISceneSession Lifecycle

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	@available(iOS 13.0, *)
	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}

	func customizeUI() {
		let appearance = UINavigationBar.appearance()
		if #available(iOS 13.0, *) {
			appearance.barTintColor = UIColor.systemBackground
			appearance.backgroundColor = UIColor.systemBackground
			appearance.tintColor = .label
			appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.label]
		} else {
			// Fallback on earlier versions
			appearance.barTintColor = .white
			appearance.tintColor = .black
			appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
		}

		appearance.shadowImage = UIImage()
//		appearance.isTranslucent = false
	}
}

