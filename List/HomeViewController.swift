//
//  HomeViewController.swift
//  List
//
//  Created by 小林美穂 on 2023/04/28.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var postArray = try! Realm().objects(PostData.self).sorted(byKeyPath: "id", ascending: true)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        
        tableView.fillerRowHeight = UITableView.automaticDimension
        
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // カスタムセルを登録する
        //        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        //        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
        
        
    }
    
    
    // segue で画面遷移する時に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let inputViewController:InputViewController = segue.destination as! InputViewController
        
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = postArray[indexPath!.row]
        } else {
            let task = PostData()
            
            let allTasks = realm.objects(PostData.self)
            if allTasks.count != 0 {
                task.id = allTasks.max(ofProperty: "id")! + 1
            }
            
            inputViewController.task = task
        }
    }
    
    // 入力画面から戻ってきた時に TableView を更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell") as! PostTableViewCell
        cell.setPostData(postArray[indexPath.row])
        
        // セル内のボタンのアクションをソースコードで設定する
        cell.challengeSwitch.addTarget(self, action:#selector(changeSwitch(_:)), for: .touchUpInside)

        
        return cell
    }
    
    
    
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue",sender: nil)
    }
    
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // --- ここから ---
        if editingStyle == .delete {
            // データベースから削除する
            try! realm.write {
                self.realm.delete(self.postArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } // --- ここまで追加 ---
    }
    
    let cellHeigh:CGFloat = 50
    
    
    // セルの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeigh
    }
    
    @objc func changeSwitch(_ sender: UISwitch) {
        let indexPath = self.tableView.indexPathForSelectedRow
        var task = postArray[indexPath!.row]
        
        
        
        
        if task.challenge == true {
            
            try! realm.write{
//                task.contents = "test"
                task.challenge = true
                
                realm.add(task, update: .modified)
                
            }
            
            
            
            
        } else {
            try! realm.write{
                task.challenge = false
//                task.contents = "test2"

                realm.add(task, update: .modified)
            }
        }
        
        
    }
}
