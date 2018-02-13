//
//  LoginEmailViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.
//

import UIKit

class LoginEmailViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate var username: String!//ユーザーネームを入れたり出したりできるように変数を宣言
    
    @IBOutlet weak var usernameTextField: UITextField!//ユーザーネーム入力欄をコネクト
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        //ユーザーネーム入力欄用に最初からキーボードが打てる状態にする
        usernameTextField.becomeFirstResponder()
        
        //textFieldDidChangeを適用するUITextFieldを決めておく
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(LoginEmailViewController.textFieldDidChange(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: usernameTextField)
    }
    
    
    //ネクストボタンをコネクト。ネクストボタンを押した時
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        //ユーザーネーム入力欄の入力文字を格納
        username = usernameTextField.text!
        //データ転移する(下のfuncでデータ転移を設定する)
        performSegue(withIdentifier: "ShowLoginPassword", sender: nil)
    }
    
    
    //バックボタンをコネクト。バックボタンを押した時
    @IBAction func backButtonClicked(_ sender: UIButton) {
        //navigationController通りに前の画面に戻る
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    //データ転移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のidentifierがShowLoginPasswordだった場合
        if segue.identifier == "ShowLoginPassword" {
            //次の画面がLoginPasswordViewControllerなのでLoginPasswordViewControllerの
            let loginPasswordVC = segue.destination as! LoginPasswordViewController
            //このファイルのemail変数の値をLoginPasswordViewControllerのusername変数に入れる
            loginPasswordVC.username = username
        }
    }
    
    
    
    /*
     //半角数字
     func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
     return string.isEmpty || string.rangeOfString("^[0-9]+$", options: .RegularExpressionSearch, range: nil, locale: nil) != nil
     }
     */
    
    //改行ボタンが押された際に呼ばれる.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    //登録したオブザーバは必ず解除しよう。
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //テキストフィールドに変化があったら呼ばれるメソッド。
    @objc func textFieldDidChange(_ notification: Notification) {
        let textField = notification.object as! UITextField
        
        if let text = textField.text {
            
            if textField == self.usernameTextField {
                
                //20文字しか入れない
                if text.count > 40 {
                    textField.text = text.substring(to: text.index(text.startIndex, offsetBy: 40))
                }
                
            }
            
        }
    }
    
    
    
    
    
    
}

