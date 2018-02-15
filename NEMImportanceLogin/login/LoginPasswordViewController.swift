//
//  LoginPasswordViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.

import UIKit
import NCMB

class LoginPasswordViewController: UIViewController, UITextFieldDelegate {
    
    var username: String!//LoginEmailViewControllerからデータ転移してきたusername
    fileprivate var password: String!//パスワードを入れたり出したりできるように変数を宣言
    var alert: UIAlertController?
    var importance: Double!
    
    //親子関係でない画面転移で使うAppDelegateのインスタンス
    var appDelegate: AppDelegate!
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!//パスワード入力欄をコネクト
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //親子関係でない画面転移
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.importance = self.appDelegate.importance
        
        passwordTextField.delegate = self
        //パスワード入力欄用に最初からキーボードが打てる状態にする
        passwordTextField.becomeFirstResponder()
        
        //textFieldDidChangeを適用するUITextFieldを決めておく
        NotificationCenter.default.addObserver(self, selector: #selector(LoginPasswordViewController.textFieldDidChange(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: passwordTextField)
    }
    
    
    //ログインボタンをコネクト、ログインボタンを押した時
    @IBAction func logInClicked(_ sender: UIButton) {
        
        //重要度の判定
        //所定の値より少なかった場合
        if self.importance < 0.0002 {
            
            print("importanceが少なかった")
            //所定の値より多かった場合
        } else {
            
            //画面を閉じた時はじめにキーボードを閉じて画面を閉じる
            passwordTextField.resignFirstResponder()
            
            self.loginButton.isEnabled = false
            
            //パスワード入力欄の入力文字を格納
            password = passwordTextField.text!
            
            //ユーザーネームでログインするパターン
            NCMBUser.logInWithUsername(inBackground: username, password: password) { (user, error) -> Void in
                //アクセスしてエラーがない時
                if error == nil {
                    
                    //navigationcontrollerを使わずに画面転移をした時に一つ前のページ(これだと最初のviewcontroller)に戻れる
                    self.dismiss(animated: true, completion: nil)
                    
                    //エラーの時
                } else {
                    print("ログインする時のエラーは\(String(describing: error?.localizedDescription))")
                    print("ログインする時のエラーは\(String(describing: error))")
                    
                    let errorStr : String = "\(error!.localizedDescription)"//エラーからエラー文字のみ抽出
                    
                    print("ログインする時のStringエラーは\(errorStr)")
                    
                    
                    switch errorStr {
                        
                        
                    case "Bad Request.": self.errorAlertMessage("不正なリクエスト", message: "")
                    case "JSON is invalid format.": self.errorAlertMessage("JSON形式不正", message: "")
                    case "{0} is invalid.": self.errorAlertMessage("型が不正", message: "")
                    case "{0} is empty.": self.errorAlertMessage("必須項目で未入力", message: "")
                    case "{0} is invalid format.": self.errorAlertMessage("フォーマットが不正", message: "")
                    case "{0} is not a valid value.": self.errorAlertMessage("有効な値でない", message: "")
                    case "{0} does not exist.": self.errorAlertMessage("存在しない値", message: "")
                    case "{0} is invalid format[lineNo:{1}].": self.errorAlertMessage("インポートエラー", message: "")
                    case "Either {0} or {1}.": self.errorAlertMessage("相関関係でエラー", message: "")
                    case "{0} size must be between {1} and {2}.": self.errorAlertMessage("指定桁数を超えている", message: "")
                    case "Authentication error by header incorrect.": self.errorAlertMessage("Header不正による認証エラー", message: "")
                    case "Authentication error with ID/PASS incorrect.": self.errorAlertMessage("ID/Pass認証エラー", message: "")
                    case "OAuth {0} authentication error.": self.errorAlertMessage("OAuth認証エラー", message: "")
                    case "No settlement for a free plan.": self.errorAlertMessage("決済情報なしで有料プラン申込みによるエラー", message: "")
                    case "No access with ACL.": self.errorAlertMessage("ACLによるアクセス権なし", message: "")
                    case "Unauthorized operations for {0}.": self.errorAlertMessage("コラボレータ/管理者（サポート）権限なし", message: "")
                    case "Operation that are prohibited.": self.errorAlertMessage("禁止されているオペレーション", message: "")
                    case "One-Time-Token expired.": self.errorAlertMessage("ワンタイムキー有効期限切れ", message: "")
                    case "Invalid GeoPoint value.": self.errorAlertMessage("GeoPoint型フィールドに対してGeoPoint型以外の値を登録／更新\n" +
                        "GeoPoint型以外のフィールドに対してGeoPoint型の値を登録／更新", message: "")
                    case "No data available.": self.errorAlertMessage("該当データなし", message: "")
                    case "None service.": self.errorAlertMessage("該当サービスなし", message: "")
                    case "None field.": self.errorAlertMessage("該当フィールドなし", message: "")
                    case "None device token.": self.errorAlertMessage("該当デバイストークンなし", message: "")
                    case "No such application.": self.errorAlertMessage("該当アプリケーションなし", message: "")
                    case "No such user.": self.errorAlertMessage("該当ユーザなし", message: "")
                    case "Method not allowed.": self.errorAlertMessage("リクエストURI/メソッドが不許可", message: "")
                    case "{0} is duplication.": self.errorAlertMessage("重複エラー。", message: "")
                    case "File size Limit error.": self.errorAlertMessage("1ファイルあたりのサイズ上限エラー", message: "")
                    case "Request entity too large.": self.errorAlertMessage("MongoDB1ドキュメントあたりのサイズ上限エラー（16MB）", message: "")
                    case "Requests thread Limit error.": self.errorAlertMessage("複数オブジェクト一括操作の上限エラー", message: "")
                    case "Unsupported media type.": self.errorAlertMessage("サポート対象外のContent-Typeを指定", message: "")
                    case "{0} have passed their limit.": self.errorAlertMessage("使用制限（APIコール数、PUSH通知数、ストレージ容量）超過", message: "")
                    case "System error.": self.errorAlertMessage("", message: "")
                    case "Storage error.": self.errorAlertMessage("ストレージエラー。NIFTY Cloud ストレージでエラーが発生した場合のエラー。", message: "")
                    case "Mail failure.": self.errorAlertMessage("メール送信エラー", message: "")
                    case "DB error[code:{0}].": self.errorAlertMessage("DBエラー", message: "")
                    case "mailAddress and password must not be entered.": self.errorAlertMessage("MailAddress/Pass認証エラー", message: "")
                    case "The Internet connection appears to be offline.": self.errorAlertMessage("オフラインです", message: "ネット環境でお使いください")
                    default: break
                    }
                    
                }
                
            }
            
        }

    }
    
    
    
    
    func errorAlertMessage(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            print("OK")
        })
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //バックボタンをコネクト、バックボタンを押した時
    @IBAction func backButtonClicked(_ sender: AnyObject) {
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
    
}

