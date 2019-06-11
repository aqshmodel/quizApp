//
//  quizViewController.swift
//  MarubatuApp
//
//  Created by Takahiro Tsukada on 2019/06/11.
//  Copyright © 2019 Takahiro Tsukada. All rights reserved.
//

import UIKit

class quizViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var quizField: UITextField!
    
    @IBOutlet weak var anserButton: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizField.delegate = self  //テキストフィールドのdelegate
    }
    
    // Topに戻るボタンの動作
    @IBAction func toTopButton(_ sender: UIButton) {
        // 前の画面に戻る処理
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toSaveButton(_ sender: UIButton) {
        
        //○かXかどちらを選択したか判別する変数のインスタンスを生成
        var answer: Bool = true
        // 問題文が空白だったらアラートメッセージを表示、文字が入っていたら処理を進める
        if quizField.text! != "" {
        //答えにXを選んだ時
        if anserButton.selectedSegmentIndex == 0 {
            answer = false
        }  else {
            answer = true
            }
        } else {
            showAlert(message: "問題文を入力してください。")
        }
    
        var quizes:[[String: Any]] //問題文の格納配列
        let userDefaults = UserDefaults.standard //インスタンス生成
        // アプリ内に保存されたデータがない場合
        guard userDefaults.object(forKey: "quiz") != nil  else {
        quizes = []  //初期化
            quizes.append(
                [
                    "question": quizField.text!,
                    "answer": answer
                ])
            userDefaults.set(quizes, forKey: "quiz")
            showAlert(message: "問題が保存されました")
            quizField.text = ""
            return
        }
        // アプリ内に保存されたデータがある場合
        quizes = userDefaults.object(forKey: "quiz") as! [[String: Any]]
        quizes.append(
            [
                "question": quizField.text!,
                "answer": answer
            ])
        //保存
        userDefaults.set(quizes, forKey: "quiz")
        showAlert(message: "問題が保存されました")
        quizField.text = ""
        }
        
    // 削除ボタンを押した時の処理
    @IBAction func toDeleteButton(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        // アプリ内のデータを消去
        userDefaults.removeObject(forKey: "quiz")
        // アプリ内のデータに空白の配列を格納し、アプリが落ちるのを防止
        userDefaults.set([], forKey: "quiz")
        showAlert(message: "問題を全て削除しました")
    }
    
    // アラートを出す関数を定義    型としてこれを書く
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }

}
