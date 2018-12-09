//
//  PickerViewController.swift
//  Timer
//
//  Created by 岩男高史 on 2018/12/07.
//  Copyright © 2018 岩男高史. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
  //UIpickerViewの列数を設定
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  //pickerviewの行数を設定
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return settingsArray.count
  }
  //表示する内容を設定
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return String(settingsArray[row])
  }
  //picker選択時に実行
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //userdefaultsの設定
    let settings = UserDefaults.standard
    settings.setValue(settingsArray[row], forKey: settingskey)
    settings.synchronize()
  }
  
  //pickerViewに表示する数値を作成
  let settingsArray:[Int] = [10,20,30,40,50,60]
  //設定値を入れるキー
  let settingskey = "timer_value"
  
  
  @IBOutlet weak var pickerview: UIPickerView!
  
  //決定ボタンで実行される
  
  @IBAction func getButton(_ sender: UIButton) {
    _ = navigationController?.popViewController(animated: true)
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // delegateとデータソースの通知先を設定
      pickerview.delegate = self
      pickerview.dataSource = self
      //userdefaultsの取得
      let defaults = UserDefaults.standard
      let timerValue = defaults.integer(forKey: settingskey)
      
      //pickerの選択を合わせる
      for row in 0..<settingsArray.count {
        if settingsArray[row] == timerValue {
          pickerview.selectRow(row, inComponent: 0, animated: true)
        }
      }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
