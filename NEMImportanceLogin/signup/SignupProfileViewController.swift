//
//  SignupProfileViewController.swift
//  NEMImportanceLogin
//
//  Created by 水野徹 on 2018/02/11.
//  Copyright © 2018年 Toru Mizuno. All rights reserved.
//

import UIKit
import NCMB

class SignupProfileViewController: UIViewController {
    
    //SinupPasswordViewControllerからデータ転移してくるデータを入れる変数を定義
    var email: String!
    var password: String!
    var alert: UIAlertController?
    var importance: Double!
    
    //親子関係でない画面転移で使うAppDelegateのインスタンス
    var appDelegate: AppDelegate!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!//ユーザーネーム入力欄をコネクト
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //親子関係でない画面転移
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.importance = self.appDelegate.importance
        
        //ユーザーネーム入力欄用に最初からキーボードが打てる状態にする
        usernameTextField.becomeFirstResponder()
        
        //textFieldDidChangeを適用するUITextFieldを決めておく
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SignupProfileViewController.textFieldDidChange(_:)),
                                               name: NSNotification.Name.UITextFieldTextDidChange,
                                               object: usernameTextField)
        
    }
    
    //サインアップボタンをコネクト、サインアップボタンを押した時
    @IBAction func signUpButtonClicked() {
        
        //ユーザーネーム入力欄の文字数が3文字以下の場合
        if usernameTextField.text!.count < 3 {
            
            //重要度の判定
            //所定の値より少なかった場合
        } else if self.importance < 0.001 {
            
            
        } else {
            
            //画面を閉じた時はじめにキーボードを閉じて画面を閉じる
            usernameTextField.resignFirstResponder()
            
            self.signUpButton.isEnabled = false
            
            let alert = UIAlertController(title: "処理中",
                                          message: "",
                                          preferredStyle: .alert)
            
            self.present(alert, animated: true, completion: nil)
            self.alert = alert
            
            let newNCMBUser = NCMBUser()
            newNCMBUser.userName = self.usernameTextField.text!
            newNCMBUser.password = self.password
            newNCMBUser.mailAddress = self.email
            //サインアップする。(NCMBUserにNCMBUser情報を保存する)
            newNCMBUser.signUpInBackground({ (error) -> Void in
                //エラーが出なかった場合
                if error == nil {
                    
                    self.alert?.dismiss(animated: true, completion: nil)
                    self.alert = nil
                    
                    //navigationcontrollerを使わずに画面転移をした時に一つ前のページ(これだと最初のtabviewcontroller、FirstViewController)に戻れる
                    self.dismiss(animated: true, completion: nil)
                    
                    
                } else {
                    //エラーを表示する
                    print("サインアップする時のエラーは\(String(describing: error?.localizedDescription))")
                    print("サインアップする時のエラーは\(String(describing: error))")
                    
                    let errorStr : String = "\(error!.localizedDescription)"//エラーからエラー文字のみ抽出
                    print("サインアップする時のStringエラーは\(errorStr)")
                    switch errorStr {
                    case "Bad Request.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("不正なリクエスト", message: "")
                        self.signUpButton.isEnabled = true
                    case "JSON is invalid format.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("JSON形式不正", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} is invalid.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("型が不正", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} is empty.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("必須項目で未入力", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} is invalid format.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("フォーマットが不正", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} is not a valid value.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("有効な値でない", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} does not exist.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("存在しない値", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} is invalid format[lineNo:{1}].":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("インポートエラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "Either {0} or {1}.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("相関関係でエラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} size must be between {1} and {2}.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("指定桁数を超えている", message: "")
                        self.signUpButton.isEnabled = true
                    case "Authentication error by header incorrect.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("Header不正による認証エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "Authentication error with ID/PASS incorrect.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("ID/Pass認証エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "OAuth {0} authentication error.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("OAuth認証エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "No settlement for a free plan.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("決済情報なしで有料プラン申込みによるエラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "No access with ACL.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("ACLによるアクセス権なし", message: "")
                        self.signUpButton.isEnabled = true
                    case "Unauthorized operations for {0}.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("コラボレータ/管理者（サポート）権限なし", message: "")
                        self.signUpButton.isEnabled = true
                    case "Operation that are prohibited.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("禁止されているオペレーション", message: "")
                        self.signUpButton.isEnabled = true
                    case "One-Time-Token expired.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("ワンタイムキー有効期限切れ", message: "")
                        self.signUpButton.isEnabled = true
                    case "Invalid GeoPoint value.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("GeoPoint型フィールドに対してGeoPoint型以外の値を登録／更新\n" +
                            "GeoPoint型以外のフィールドに対してGeoPoint型の値を登録／更新", message: "")
                        self.signUpButton.isEnabled = true
                    case "No data available.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("該当データなし", message: "")
                        self.signUpButton.isEnabled = true
                    case "None service.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("該当サービスなし", message: "")
                        self.signUpButton.isEnabled = true
                    case "None field.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("該当フィールドなし", message: "")
                        self.signUpButton.isEnabled = true
                    case "None device token.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("該当デバイストークンなし", message: "")
                        self.signUpButton.isEnabled = true
                    case "No such application.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("該当アプリケーションなし", message: "")
                        self.signUpButton.isEnabled = true
                    case "No such user.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("該当ユーザなし", message: "")
                        self.signUpButton.isEnabled = true
                    case "Method not allowed.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("リクエストURI/メソッドが不許可", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} is duplication.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("重複エラー。", message: "")
                        self.signUpButton.isEnabled = true
                    case "File size Limit error.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("1ファイルあたりのサイズ上限エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "Request entity too large.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("MongoDB1ドキュメントあたりのサイズ上限エラー（16MB）", message: "")
                        self.signUpButton.isEnabled = true
                    case "Requests thread Limit error.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("複数オブジェクト一括操作の上限エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "Unsupported media type.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("サポート対象外のContent-Typeを指定", message: "")
                        self.signUpButton.isEnabled = true
                    case "{0} have passed their limit.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("使用制限（APIコール数、PUSH通知数、ストレージ容量）超過", message: "")
                        self.signUpButton.isEnabled = true
                    case "System error.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("", message: "")
                        self.signUpButton.isEnabled = true
                    case "Storage error.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("ストレージエラー。NIFTY Cloud ストレージでエラーが発生した場合のエラー。", message: "")
                        self.signUpButton.isEnabled = true
                    case "Mail failure.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("メール送信エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "DB error[code:{0}].":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("DBエラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "mailAddress and password must not be entered.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("MailAddress/Pass認証エラー", message: "")
                        self.signUpButton.isEnabled = true
                    case "The Internet connection appears to be offline.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("オフラインです", message: "ネット環境でお使いください")
                        self.signUpButton.isEnabled = true
                    case "mailAddress is invalid format.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("メールアドレスが不正です", message: "")
                        self.signUpButton.isEnabled = true
                    case "userName is duplication.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("ユーザー名が不正です", message: "他のユーザー名でお試しください。")
                        self.signUpButton.isEnabled = true
                    case "mailAddress is duplication.":
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("このメールアドレスは登録されています", message: "")
                        self.signUpButton.isEnabled = true
                        
                    default:// break
                        self.alert?.dismiss(animated: true, completion: nil)
                        self.alert = nil
                        self.errorAlertMessage("何らかの理由でサインアップを行うことができません", message: "再度メールアドレスからやり直してみてください。")
                        self.signUpButton.isEnabled = true
                    }
                    
                }
            })
            
        }
    }
    
    
    
    
    //バックボタンをコネクト、バックボタンを押した時
    @IBAction func backButtonClicked() {
        //navigationController通りに前のページに戻る
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    //登録したオブザーバは必ず解除しよう。
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //テキストフィールドに変化があったら呼ばれるメソッド。
    @objc func textFieldDidChange(_ notification: Notification) {
        let textField = notification.object as! UITextField
        
        if let text = textField.text {
            
            if textField.text == self.password {
                
                //20文字しか入れない
                if text.count > 15 {
                    textField.text = text.substring(to: text.index(text.startIndex, offsetBy: 15))//index(text.startIndex, offsetBy: 15))
                }
                
            }
            
        }
    }
    
    
    //アラートを作る関数
    func errorAlertMessage(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            print("OK")
        })
        
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

