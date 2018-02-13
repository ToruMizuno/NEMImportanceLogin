//
//  ViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NCMB

class ViewController: UIViewController {
    
    @IBOutlet weak var address: UITextField!
    
    //親子関係でない画面転移で使うAppDelegateのインスタンス
    var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //重要度を取得するためにアカウント情報を取ってくる
    @IBAction func accountGet(_ sender: Any) {
        
        //ノードの基本情報を取得する
        /*
        Alamofire.request("http://176.9.68.110:7890/node/info").responseJSON { response in
            
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            //エラーがなかった場合
            if response.error == nil {
                
                //responseから情報を抜き出す
                let json:JSON = JSON(response.result.value ?? kill)
                
                //パラメーターを抜き出す
                let importance: Double = json["importance"].doubleValue
                print("importance: \(String(describing: importance))")
                
            }
            
        }
        */
        //入力欄が入力されていなかった場合
        if (self.address.text?.isEmpty)! {
            
            //何かアラートなどで警告
            
        } else {
            
            let address = self.address.text//アカウントのアドレス
            //パラメーターを辞書で入れていく//左辺がカラム名、右辺が値
            var params: [String: Any] = [:]//左辺が文字列でカラム指定、右辺がどの値でも送れるようにAny
            params["address"] = address//アドレス"NC4C6PSUW5CLTDT5SXAGJDQJGZNESKFK5MCN77OG"//
            
            let node = "176.9.68.110"//基本ノード
            //let importancesurl = "http://\(node)/account/importances"//重要度の取得
            let accountGeturl = "http://\(node):7890/account/get"//アカウントデータを取ってくる。重要度とか色々取ってくるよ//パラメータaddress
            Alamofire.request(accountGeturl, method: .get, parameters: params).responseJSON { response in
                
                print("Request: \(String(describing: response.request))")
                print("Response: \(String(describing: response.response))")
                print("Error: \(String(describing: response.error))")
                
                //エラーがなかった場合
                if response.error == nil {
                    
                    //responseから情報を抜き出す
                    let json:JSON = JSON(response.result.value ?? kill)
                    print("json: \(String(describing: json))")
                    
                    
                    //パラメーターを抜き出す
                    //先ずは階層構造的にaccountから取り出す
                    let dictionaryValue: Dictionary = json["account"].dictionaryValue
                    print("dictionaryValue: \(String(describing: dictionaryValue))")
                    //accountの中のimportanceのみを取り出す
                    let importance: Double = (dictionaryValue["importance"]?.doubleValue)!
                    print("importance: \(String(describing: importance))")
                    
                    //親子関係でない画面転移
                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                    self.appDelegate.importance = importance
                }
                
            }
            
        }

    }
    
    
    
    
    
    //重要度を取得するためにアカウント情報を取ってくる
    @IBAction func accountGet2(_ sender: Any) {
        
        //入力欄が入力されていなかった場合
        if (self.address.text?.isEmpty)! {
            
            //何かアラートなどで警告
            
        } else {
            
            let address = self.address.text//アカウントのアドレス
            //パラメーターを辞書で入れていく//左辺がカラム名、右辺が値
            var params: [String: Any] = [:]//左辺が文字列でカラム指定、右辺がどの値でも送れるようにAny
            params["address"] = address//アドレス"NC4C6PSUW5CLTDT5SXAGJDQJGZNESKFK5MCN77OG"//
            
            let node = "176.9.68.110"//基本ノード
            //let importancesurl = "http://\(node)/account/importances"//重要度の取得
            let accountGeturl = "http://\(node):7890/account/get"//アカウントデータを取ってくる。重要度とか色々取ってくるよ//パラメータaddress
            Alamofire.request(accountGeturl, method: .get, parameters: params).responseJSON { response in
                
                print("Request: \(String(describing: response.request))")
                print("Response: \(String(describing: response.response))")
                print("Error: \(String(describing: response.error))")
                
                //エラーがなかった場合
                if response.error == nil {
                    
                    //responseから情報を抜き出す
                    let json:JSON = JSON(response.result.value ?? kill)
                    print("json: \(String(describing: json))")
                    
                    //パラメーターを抜き出す
                    //先ずは階層構造的にaccountから取り出す
                    let dictionaryValue: Dictionary = json["account"].dictionaryValue
                    print("dictionaryValue: \(String(describing: dictionaryValue))")
                    //accountの中のimportanceのみを取り出す
                    let importance: Double = (dictionaryValue["importance"]?.doubleValue)!
                    print("importance: \(String(describing: importance))")
                    
                    //親子関係でない画面転移
                    self.appDelegate = UIApplication.shared.delegate as! AppDelegate
                    self.appDelegate.importance = importance
                }
                
            }
            
        }

    }
 


}
