//
//  ViewController.swift
//  Timer
//
//  Created by 岩男高史 on 2018/12/07.
//  Copyright © 2018 岩男高史. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //label
  @IBOutlet weak var byousuLabel: UILabel!
  //startButton
  @IBAction func startButton(_ sender: UIButton) {
    //timerが実行中かどうかチェック
    //timerをアンラップしてnowTimerに代入
    if let nowTimer = timer {
      //もしタイマーが、実行中だったらスタートしない
      if nowTimer.isValid == true {
        //何も処理しない
        return
      }
    }
    //タイマーをスタート
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
  }
  //stopButton
  @IBAction func stopButton(_ sender: UIButton) {
    //タイマーが実行中かチェック
    //タイマーをアンラップしてnowtimerに代入
    if let nowTimer = timer {
      //もしタイマーが実行中だったら停止
      if nowTimer.isValid == true {
        //タイマー停止
        nowTimer.invalidate()
      }
    }
  }
  //settings
  @IBAction func settings(_ sender: UIBarButtonItem) {
    //タイマーが実行中かチェック
    if let nowTimer = timer {
      if nowTimer.isValid == true {
        nowTimer.invalidate()
        
      }
    }
    //画面遷移を行う
    performSegue(withIdentifier: "gosetting", sender: nil)
  }
  
  //タイマーの変数を作成
  var timer:Timer?
  //カウントの変数を作成
  var count = 0
  //設定値を扱うキーを設定
  let settingsKey = "timer_value"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // UserDefaultsのインスタンスを作成
    let defaults = UserDefaults.standard
    //初期値を登録
    defaults.register(defaults: [settingsKey : 10])
  }
  
  //画面の更新をする
  func displayUpdata() -> Int {
    //userdefaultsを生成
    let settings = UserDefaults.standard
    //取得した秒数をtimerValueに渡す
    let timerValue = settings.integer(forKey: settingsKey)
    //残り時間を生成
    let remainCount = timerValue - count
    //ラベルに表示
    byousuLabel.text = "残り\(remainCount)秒"
    //残り時間を戻り値に設定
    return remainCount
  }
  
  //経過時間の処理
  
  @objc func timerInterrupt(_ timer:Timer) {
    //countに＋１をしていく
    count += 1
    //remainCountが０以下の時、タイマーを止める
    if displayUpdata() <= 0 {
      //初期化処理
      count = 0
      //タイマー停止
      timer.invalidate()
      
      //カスタマイズ編
      let alertController = UIAlertController(title: "終了", message: "タイマー終了時間です", preferredStyle: .alert)
      //ダイアログに表示させるOkボタンを作成
      let defaultsAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      //アクションを追加
      alertController.addAction(defaultsAction)
      //ダイアログの表示
      present(alertController, animated: true, completion: nil)
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    //カウント０にする
    count = 0
    //タイマーの表示を更新する
    _ = displayUpdata()
  }


}

