//
//  MessCLV.swift
//  ChatAppPro
//
//  Created by Apple on 11/04/2022.
//

import UIKit
import SwipeCellKit
class MessCLV: UICollectionViewCell {
    @IBOutlet weak var MessageCLV: UICollectionView!
  //  var userName = ["Sơn tùng MTP"]
    @IBOutlet weak var messCellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageCLV.dataSource = self
        MessageCLV.delegate = self
        MessageCLV.register(UINib(nibName: "MessCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MessCollectionViewCell")
    }
}
extension MessCLV: UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessCollectionViewCell", for: indexPath) as! MessCollectionViewCell
        cell.lblName.text = "Sơn tùng MTP \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let parent = self.parentMess as? MessageVC{
            let vc = FriendsVC(nibName: FriendsVC.className, bundle: nil)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            parent.present(vc, animated: true)
        }
    }
}

extension MessCLV: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: widthScreen/5.77, height: widthScreen/3)
        }
        return CGSize(width: widthScreen/5.77, height: widthScreen/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
