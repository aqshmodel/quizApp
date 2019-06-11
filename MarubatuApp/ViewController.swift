//
//  ViewController.swift
//  MarubatuApp
//
//  Created by Takahiro Tsukada on 2019/06/08.
//  Copyright © 2019 Takahiro Tsukada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentQuestionNum:Int = 0
    var collectA = 0
    var quizes: [[String: Any]] = []
    let userDefaults = UserDefaults.standard
    var imageArray : Array<UIImage> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        while let okImage = UIImage(named: "full\(imageArray.count+1)") {
            imageArray.append(okImage)
        }
        // Do any additional setup after loading the view.
        showQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // 画面遷移で戻ったときにquizesに入っている配列を一旦初期化し、アプリ内データから読み込む
        quizes = []
        
        if userDefaults.object(forKey: "quiz") != nil {
            quizes = userDefaults.object(forKey: "quiz") as! [[String: Any]]
        }
        showQuestion()
    }

    
    @IBOutlet weak var questionLabel: UILabel!
    
    
   
//        // 辞書の定義 キー値: 中身
//        [
//            "question": "iPhoneアプリを開発する統合環境はZcodeである",
//            "answer": false
//        ],
//        [
//            "question": "Xcode画面の右側にはユーティリティーズがある",
//            "answer": true
//        ],
//        [
//            "question": "UILabelは文字列を表示する際に利用する",
//            "answer": true
//        ]
//        //  ここまで中身
    
    // ラベルに辞書の内容を読み込む関数
    func showQuestion() {
            // まだ問題が残っている場合には処理を行う
        if (quizes.count > currentQuestionNum){
            let question = quizes[currentQuestionNum]
            
            if let que = question["question"] as? String {
                questionLabel.text = "\(currentQuestionNum+1)問目: " + que  // 問題文をラベルに表示
            }
            
        } else {
            // 問題が入っていない時にはエラーメッセージ
            questionLabel.text = "問題がありません。作成してください。"
            }
    }
    
    // 答えを判別する関数の定義
    func checkAnswer(yourAnswer: Bool) {
        
        let questionA = quizes[currentQuestionNum]
        
        if let ans = questionA["answer"] as? Bool {
            if  yourAnswer == ans {
                // true 正解なら正解数をカウント
                collectA += 1
                if currentQuestionNum + 1 < quizes.count {
                showAlert(message: "正解")
                }
            } else {
                // false 不正解なら
                if currentQuestionNum + 1 < quizes.count {
                showAlert(message: "不正解")
                }
            }
        } else {
            print("答えがありません")
            return
        }
        currentQuestionNum += 1
        // 問題が入っている配列の数で判別し、最後の問題に到達したら最初の問題に戻る簡易処理
        if currentQuestionNum >= quizes.count {
            currentQuestionNum = 0
            showAlert(message: "結果は\(collectA)問正解！ クイズ終了！")
            collectA = 0
            showAnime()
        }
        showQuestion()
    }
    
    func showAnime(){
    
            // アニメーションの適用
            fullImage.animationImages = imageArray
            // アニメーションの長さ:2秒
            fullImage.animationDuration = 5
            // アニメーション再生回数:1回
            fullImage.animationRepeatCount = 1
            // アニメーションを開始
            fullImage.startAnimating()
    
    }
    
    // アラートを出す関数を定義    型としてこれを書く
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "とじる", style: .cancel , handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBOutlet weak var fullImage: UIImageView!
    
    @IBAction func tapNoButton(_ sender: Any) {
        guard userDefaults.object(forKey: "quiz") != nil  else {return}
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tapYesButton(_ sender: Any) {
        guard userDefaults.object(forKey: "quiz") != nil  else {return}
        checkAnswer(yourAnswer: true)
    }
    
    
}

