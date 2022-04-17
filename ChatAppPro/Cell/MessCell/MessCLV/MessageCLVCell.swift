//
//  MessageCLVCell.swift
//  ChatAppPro
//
//  Created by Apple on 17/04/2022.
//

import UIKit
import SwipeCellKit
class MessageCLVCell: SwipeCollectionViewCell {
    @IBOutlet weak var lblNumberNew: UILabel!
    @IBOutlet weak var lblMess: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func reloadData(with info: infoUserMess){
        lblMess.text = info.messageNew
        lblName.text = info.giveName + info.familyName
        lbldate.text = info.time
        lblNumberNew.text = String(info.wattingMess)
    }
}
