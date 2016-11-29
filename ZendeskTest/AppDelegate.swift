//
//  AppDelegate.swift
//  ZendeskTest
//
//  Created by Marc Dermejian on 26/11/2016.
//  Copyright © 2016 Marc Dermejian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// set the shared cache for all URLRequests
		// ideally this should be handled by a cache manager
		let urlCache = URLCache(memoryCapacity: Config.cacheMemoryCapacity, diskCapacity: Config.cacheDiskCapacity, diskPath: nil)
		URLCache.shared = urlCache
		
		return true
	}

}

