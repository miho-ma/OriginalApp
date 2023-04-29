//
//  ViewController.swift
//  List
//
//  Created by 小林美穂 on 2023/04/27.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        print(Realm.Configuration.defaultConfiguration.fileURL)


        do {
            //インスタンスの取得
            let realm = try! Realm()
            let dictionary: [String: Any] =
                ["taskTitle": "夏休みの宿題",
                 "tickets": [["ticketTitle": "算数"],
                             ["ticketTitle": "英語"],
                             ["ticketTitle": "社会"]]
                ]

            let task = Task(value: dictionary) //Taskモデルのインスタンスの作成

            //書き込み処理
            try! realm.write {
                realm.add(task)
                print(task)
            }
        }
        catch {
            print(error)
        }
        
        
        do {
            //インスタンスの取得
            let realm = try Realm()
            let results = realm.objects(Task.self)

            let ticket = Ticket(value: ["ticketTitle": "国語"]) //Ticketモデルのインスタンスの作成

            print("追加前",results)
            // 追加処理
            try! realm.write {
                for task in results {
                    task.tickets.append(ticket)
                }
            }
            print("追加後",results)
        }
        catch {
            print(error)
        }

        
        do {
            //インスタンスの取得
            let realm = try Realm()
            let results = realm.objects(Task.self)

            print("削除前",results)
            // 削除処理
            try! realm.write {
                for task in results {
                    for (index, ticket) in task.tickets.enumerated() {
                        if ticket.ticketTitle == "国語" {
                            task.tickets.remove(at: index)
                        }
                    }
                }
            }
            print("削除後",results)
        }
        catch {
            print(error)
        }
        

        do {
            //インスタンスの取得
            let realm = try Realm()
            let results = realm.objects(Task.self)

            print("更新前",results)
            // 削除処理
            try! realm.write {
                results.first?.taskTitle = "晩ご飯の食材"  //プロパティの更新
            }
            print("更新後",results)
        }
        catch {
            print(error)
        }
        
        do {
            //インスタンスの取得
            let realm = try Realm()
            let results = realm.objects(Task.self)

            let ticketArray: [Dictionary<String, String>] =
             [["ticketTitle": "魚"],
              ["ticketTitle": "醤油"],
              ["ticketTitle": "味噌"]]

            print("更新前",results)
            // 更新処理
            try! realm.write {
                results.first?.setValue(ticketArray, forKey: "tickets")
            }
            print("更新後",results)
        }
        catch {
            print(error)
        }
        
        
        
        
        do {
            //インスタンスの取得
            let realm = try Realm()

            //オブジェクトの取得
            let results = realm.objects(Task.self)
            print(results)
        }
        catch {
            print(error)
        }
        
        
    }


}


