//
//  ViewController.swift
//  searchSample
//
//  Created by Togami Yuki on 2018/10/25.
//  Copyright © 2018 Togami Yuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //候補が入る配列
    var autoCompletePossibilities: [String] = []
    //入力した文字にマッチした候補だけを入れる配列
    var autoComplete: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        //検索候補を入れる配列
        autoCompletePossibilities = ["あ","あい","あいう","いうえ","いうえお","か","あか","かあ"]
    }
}



extension ViewController:UITextFieldDelegate{
    //テキストが変更された時に呼ばれる
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchAutocompleteEntriesWithSubstring(substring)
        return true
    }
    
    //入力された文字列にマッチする候補を取得
    func searchAutocompleteEntriesWithSubstring(_ substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        for key in autoCompletePossibilities {
            let myString:NSString! = key as NSString
            let substringRange :NSRange! = myString.range(of: substring)
            if (substringRange.location  == 0) {
                autoComplete.append(key)
            }
        }
        tableView.reloadData()
    }
    
    //キーボードを閉じる①
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //キーボードを閉じる②
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}





extension ViewController:UITableViewDelegate,UITableViewDataSource{
    //セルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    //セルのインスタンス化
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = autoComplete[indexPath.row]
        return cell
    }
    
    
    //セルが選択された時に動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
        autoComplete = []
        tableView.reloadData()
        textField.text = selectedCell.textLabel!.text!
    }
}











