//
//  InputViewController.swift
//  List
//
//  Created by 小林美穂 on 2023/04/28.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var contentsTextField: UITextField!
    
    
    let realm = try! Realm()
    var task: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentsTextField.text = task.contents
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write{
            self.task.contents = self.contentsTextField.text!
            self.task.challenge = false
            
            self.realm.add(self.task, update: .modified)
            
        }
        super.viewWillDisappear(animated)
    }

}
