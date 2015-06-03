//
//  AppDelegate.swift
//  Hangover
//
//  Created by Peter Sobot on 5/24/15.
//  Copyright (c) 2015 Peter Sobot. All rights reserved.
//

import Cocoa
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
//        auth_with_code { (access_token: String, refresh_token: String) in
//            println("access: \(access_token), refresh: \(refresh_token)")
//        }

        withAuthenticatedManager { (manager: Alamofire.Manager) in
            Channel(manager: manager).listen()
            Client(manager: manager).connect()
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

