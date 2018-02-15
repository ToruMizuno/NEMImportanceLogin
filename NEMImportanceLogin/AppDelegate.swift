//
//  AppDelegate.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.

//テスト用
//NC4C6PSUW5CLTDT5SXAGJDQJGZNESKFK5MCN77OG//犯人
//mmmmmmmm@gmail.com
//mmmmmmmm

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var importance: Double!
    
    //********** NCMB APIキーの設定 **********
    let applicationkey = "5a3865a1bb6cd27692d499bc6b4cbde7d38a662dd3e48eb8291a47bfabcfb3b4"//新しいアプリケーションキー
    let clientkey = "d5a57a576f3c3c7c1e01e4e69fa95b12c81149088c099f5e0f6932156e3e4ace"//新しいクライアントキー


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /////////////////////////////NCMBに接続できるかのテストコード(シミュレーターやアプリを起動しただけで保存される)
        
        //Initialize NCMB
        NCMB.setApplicationKey(applicationkey, clientKey: clientkey)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

