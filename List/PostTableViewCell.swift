//
//  PostTableViewCell.swift
//  List
//
//  Created by 小林美穂 on 2023/04/28.
//

import UIKit
import RealmSwift

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var contentsTextField: UITextField!
    
    @IBOutlet weak var challengeLabel: UILabel!
    
    
    @IBOutlet weak var challengeSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//     PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {

//        var postData = PostData()

        // キャプションの表示
        self.contentsTextField.text = "\(postData.contents)"
        self.challengeLabel.text = "\(postData.challenge)"

        self.challengeSwitch.isOn = postData.challenge
    }

    
}
