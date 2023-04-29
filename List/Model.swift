//
//  Model.swift
//  List
//
//  Created by 小林美穂 on 2023/04/27.
//

import RealmSwift

class Task: Object {
    @objc dynamic var taskTitle: String = ""
    //Listの定義
    let tickets = List<Ticket>()
}

class Ticket: Object {
    @objc dynamic var ticketTitle: String = ""
}
