//
//  SignupEmailViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.
//

import UIKit

class SignupEmailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!//メール入力欄をコネクト
    
    fileprivate var email: String!//メールアドレスを入れたり出したりできるように変数を宣言
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        //メール入力欄用に最初からキーボードが打てる状態にする
        emailTextField.becomeFirstResponder()
        
        //textFieldDidChangeを適用するUITextFieldを決めておく
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignupEmailViewController.textFieldDidChange(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: emailTextField)
    }
    
    
    //ネクストボタンをコネクト。ネクストボタンを押した時
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        /////////メール入力欄に何も入力されていない(空、nil)時。または、6文字(length文字数)よりも少ない時
        if emailTextField.text!.isEmpty || emailTextField.text!.count < 6 {
            
            //それ以外の時
        } else {
            //メール入力欄のテキストの先頭と末尾にあるスペースを削除して格納
            email = emailTextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            //メールアドレスを小文字にする
            email = email.lowercased()
            //データ転移する(下のfuncでデータ転移を設定する)
            performSegue(withIdentifier: "ShowSignupPassword", sender: nil)
        }
    }
    
    
    //バックボタンをコネクト、バックボタンを押した時
    @IBAction func backButtonClicked(_ sender: UIButton) {
        
        //navigationController通りに前のページに戻る
        _ = self.navigationController?.popViewController(animated: true)
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
            
            if textField == self.emailTextField {
                
                //20文字しか入れない
                if text.count > 40 {
                    textField.text = text.substring(to: text.index(text.startIndex, offsetBy: 40))
                }
                
            }
            
        }
    }
    
    
    // MARK: - Navigation
    
    //データ転移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のidentifierがShowSignupPasswordだった場合
        if segue.identifier == "ShowSignupPassword" {
            //次の画面がSignupPasswordViewControllerなのでSignupPasswordViewControllerの
            let signupPasswordVC = segue.destination as! SignupPasswordViewController
            //このファイルのemail変数の値をSignupPasswordViewControllerのemail変数に入れる
            signupPasswordVC.email = email
        }
    }
    
}
