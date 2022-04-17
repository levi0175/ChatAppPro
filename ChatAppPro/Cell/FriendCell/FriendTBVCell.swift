//
//  FriendTBVCell.swift
//  ChatAppPro
//
//  Created by Apple on 12/04/2022.
//

import UIKit

class FriendTBVCell: UITableViewCell {
    @IBOutlet weak var imageFriend:UIView!
    @IBOutlet weak var lblFriend:UILabel!
    @IBOutlet weak var btnAddFriend:UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnAddFriend.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    @IBAction func btnAddFriend(_ sender: Any) {
        print("ADD FRIEND")
    }
    
}
