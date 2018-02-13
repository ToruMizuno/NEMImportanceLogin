//
//  SignupPasswordViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.
//

import UIKit

class SignupPasswordViewController: UIViewController, UITextFieldDelegate {
    
    var email: String!//SignupEmailViewControllerからデータ転移してきたemail
    fileprivate var password: String!//パスワードを入れたり出したりできるように変数を宣言
    
    //パスワード入力欄をコネクト
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        //パスワード入力欄に最初からキーボードが打てる状態にする
        passwordTextField.becomeFirstResponder()
        
        //textFieldDidChangeを適用するUITextFieldを決めておく
        NotificationCenter.default.addObserver(self, selector: #selector(SignupPasswordViewController.textFieldDidChange(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: passwordTextField)
        
    }
    
    
    //ネクストボタンをコネクト、ネクストボタンを押した時
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        ///////パスワード入力欄に何も入力されていない(空、nil)時。または、6文字(length文字数)よりも少ない時
        if passwordTextField.text!.isEmpty || passwordTextField.text!.count < 6 {
            
            //それ以外の時
        } else {
            //パスワード入力欄のテキストの先頭と末尾にあるスペースを削除して格納
            password = passwordTextField.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            //パスワードを小文字にする
            password = password.lowercased()
            //データ転移する(下のfuncでデータ転移を設定する)
            performSegue(withIdentifier: "ShowSignupProfile", sender: nil)
        }
    }
    
    
    //バックボタンをコネクト、バックボタンを押した時
    @IBAction func backButtonClicked(_ sender: UIButton) {
        //navigationController通りに前のページに戻る
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    //半角数字
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.isEmpty || string.range(of: "^[0-9a-zA-Z]+$", options: .regularExpression, range: nil, locale: nil) != nil
    }
    
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
            
            if textField == self.passwordTextField {
                
                //20文字しか入れない
                if text.count > 20 {
                    textField.text = text.substring(to: text.index(text.startIndex, offsetBy: 20))
                }
                
            }
            
        }
    }
    
    
    
    // MARK: - Navigation
    
    //データ転移
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のidentifierがShowSignupProfileだった場合
        if segue.identifier == "ShowSignupProfile" {
            //次の画面がSignupProfileViewControllerなのでSignupProfileViewControllerの
            let signupProfileVC = segue.destination as! SignupProfileViewController
            //このファイルのpassword変数の値をSignupProfileViewControllerのpassword変数に入れる
            signupProfileVC.password = password
            //このファイルのemail変数の値をSignupProfileViewControllerのemail変数に入れる
            signupProfileVC.email = email
        }
    }
    
    
}
