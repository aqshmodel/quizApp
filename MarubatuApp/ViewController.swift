//
//  ViewController.swift
//  MarubatuApp
//
//  Created by Takahiro Tsukada on 2019/06/08.
//  Copyright © 2019 Takahiro Tsukada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        showQuestion()
    }

    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    var currentQuestionNum:Int = 0
     var collectA = 0
    
    let questions: [[String: Any]] = [
        // 辞書の定義 キー値: 中身
        [
            "question": "iPhoneアプリを開発する統合環境はZcodeである",
            "answer": false
        ],
        [
            "question": "Xcode画面の右側にはユーティリティーズがある",
            "answer": true
        ],
        [
            "question": "UILabelは文字列を表示する際に利用する",
            "answer": true
        ]
        //  ここまで中身
    ]
    
    // ラベルに辞書の内容を読み込む関数
    func showQuestion() {
        // 辞書questionsからデータを読み出す
        let questionA = questions[currentQuestionNum]
        // キー値questionのデータをラベルに表示するため、queに代入
        if let que = questionA["question"] as? String {
            questionLabel.text = que
        }
    }
    
    // 答えを判別する関数の定義
    func checkAnswer(yourAnswer: Bool) {
        
        let questionA = questions[currentQuestionNum]
        
        if let ans = questionA["answer"] as? Bool {
            if  yourAnswer == ans {
                // true 正解なら
                collectA += 1
                if currentQuestionNum + 1 < questions.count {
                showAlert(message: "正解")
                }
            } else {
                // false 不正解なら
                showAlert(message: "不正解")
            }
        } else {
            print("答えがありません")
            return
        }
        currentQuestionNum += 1
        // 問題が入っている配列の数で判別し、最後の問題に到達したら最初の問題に戻る簡易処理
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
            showAlert(message: "\(collectA)問正解！")
            collectA = 0
        }
        showQuestion()
    }
    
    
    // アラートを出す関数を定義    型としてこれを書く
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func tapNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tapYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    
}

