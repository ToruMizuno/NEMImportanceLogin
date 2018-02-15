//
//  StartViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/13.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.
//

import UIKit
import NCMB

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //ログインしているかを確認
        if NCMBUser.current() == nil {
            self.showLogin()
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //ログインしているか確かめる関数
    fileprivate func showLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeNavigationViewController") as! UINavigationController
        self.present(welcomeViewController, animated: true, completion: nil)
    }
    
    
    //ログアウトボタンをコネクトする、ログアウトボタンを押した時
    @IBAction func logoutButton_Clikced(_ sender: AnyObject) {
        
        //ログアウト
        NCMBUser.logOut()
        //ログインしているか確かめる関数
        self.showLogin()
        
    }

}
