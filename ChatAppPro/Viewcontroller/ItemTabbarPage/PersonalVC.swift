//
//  PersonalVC.swift
//  ChatAppPro
//
//  Created by Apple on 08/04/2022.
//

import UIKit
import SwiftKeychainWrapper
class PersonalVC: UIViewController {
    
    @IBOutlet weak var viewSetting: UIView!
    @IBOutlet weak var PersonalCLV: UICollectionView!
    
    
    @IBOutlet weak var lblNamePer: UILabel!
    @IBOutlet weak var switchChangeBG: UISwitch!
    @IBOutlet weak var viewDark: UIView!
    var isSwitch = 0
    var listSetting = ["Tài khoản","Thông báo","Tài khoản và bảo mật","Quản lý dữ liệu và bộ nhớ","Nhắn tin","Thiết bị","Trợ giúp"]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //        a.overrideUserInterfaceStyle = .dark
        viewDark.radiusUIViewTopLeft(number: Int(widthScreen)/9)
        PersonalCLV.dataSource = self
        PersonalCLV.delegate = self
        PersonalCLV.register(UINib(nibName: "PersonalCLVCell", bundle: nil), forCellWithReuseIdentifier: "PersonalCLVCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let Save:Int =  KeychainWrapper.standard.integer(forKey: "SAVE_SWITCH"){
            isSwitch = Save
        }
        print(isSwitch)
        if isSwitch == 1{
            switchChangeBG.isOn = true
            backGroundDark()
        }else{
            switchChangeBG.isOn = false
            lblNamePer.textColor = UIColor.black
            backGroundLight()
        }
    }
    @IBAction func btnDarkLight(_ sender: UISwitch) {
        
        if sender.isOn == true{
            isSwitch = 1
            backGroundDark()
        }else{
            isSwitch = 0
            lblNamePer.textColor = UIColor.black
            backGroundLight()
        }
        NotificationCenter.default.post(name: Notification.Name("txtID"), object: isSwitch)
        KeychainWrapper.standard.set(isSwitch, forKey: "SAVE_SWITCH")
      
        
    }
    func backGroundDark(){
        viewDark.overrideUserInterfaceStyle = .dark
        lblNamePer.textColor = .white
        viewDark.backgroundColor = UIColor.black
    }
    func backGroundLight(){
        viewDark.overrideUserInterfaceStyle = .light
        lblNamePer.textColor = UIColor.black
        viewSetting.backgroundColor = .clear
        viewDark.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
    }
}
extension PersonalVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSetting.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonalCLVCell", for: indexPath) as! PersonalCLVCell
        cell.lblNamePersional.text = listSetting[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hung")
    }
}

extension PersonalVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: collectionView.frame.width, height: 70)
        }
        return CGSize(width: collectionView.frame.width, height: widthScreen/9.375)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

