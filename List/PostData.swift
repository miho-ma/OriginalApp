//
//  PostData.swift
//  List
//
//  Created by 小林美穂 on 2023/04/28.
//

import RealmSwift

class PostData: Object {
    
//     管理用 ID。プライマリーキー
    @objc dynamic var id = 0

    // 内容
    @objc dynamic var contents = ""

    // 日時
    @objc dynamic var challenge = false
    
    // id をプライマリーキーとして設定
    override static func primaryKey() -> String? {
        return "id"
    }
}
