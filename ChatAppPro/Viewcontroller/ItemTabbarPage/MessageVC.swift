//
//  MessageVC.swift
//  ChatAppPro
//
//  Created by Apple on 08/04/2022.
//

import UIKit
import SwipeCellKit
import SwiftKeychainWrapper
class MessageVC: UIViewController,UISearchBarDelegate {
    
    @IBOutlet var containView: UIView!
    @IBOutlet weak var containViewMess:UIView!
    @IBOutlet weak var TabBarView:UIView!
    @IBOutlet weak var tabBarVIew: UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var searchBarFriend: UISearchBar!
    @IBOutlet weak var MessTBVMain: UICollectionView!
    
    let bar  = AnimatedSearchBar(frame: CGRect.zero, duration: 3.0, outlineColor: UIColor.red)
    var userName = [infoUserMess]()
    var txtTitle = ""
    var isSwitchMess = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarMess()
        containView.radiusUIViewTopLeft(number: Int(widthScreen)/9)
        
        MessTBVMain.dataSource = self
        MessTBVMain.delegate = self
        
        MessTBVMain.register(UINib(nibName: "MessageCLVCell", bundle: nil), forCellWithReuseIdentifier: "MessageCLVCell")
        MessTBVMain.register(UINib(nibName: "MessCLV", bundle: nil), forCellWithReuseIdentifier: "MessCLV")
        //SET title
        lblTitle.text = txtTitle
        
        containViewMess.radiusUIViewTopLeft(number: Int(widthScreen)/9)
        TabBarView.radiusUIViewTopLeft(number: Int(widthScreen)/15)
        // NOTE: textFild onChange
        KeychainWrapper.standard.set(isSwitchMess, forKey: "SAVE_SWITCH_MESS")
        // tabTextField()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        containViewMess.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(GetName_(_:)), name: Notification.Name("txtID"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let Save:Int =  KeychainWrapper.standard.integer(forKey: "SAVE_SWITCH_MESS"){
            isSwitchMess = Save
        }
        if isSwitchMess == 1{
            
            backGroundDark()
        }else{
            backGroundLight()
        }
    }
    @objc func GetName_(_ notification : Notification){
        let text = notification.object as! Int
        isSwitchMess = text
        KeychainWrapper.standard.set(isSwitchMess, forKey: "SAVE_SWITCH_MESS")
        if isSwitchMess == 1{
            backGroundDark()
        }else{
            backGroundLight()
        }
    }
    func setSearchBarMess(){
        searchBarFriend.layer.borderColor = UIColor.white.cgColor
        searchBarFriend.tintColor = UIColor.clear
        searchBarFriend.backgroundColor = .clear
        searchBarFriend.layer.borderWidth = 1
        searchBarFriend.layer.cornerRadius = widthScreen/15
        searchBarFriend.clipsToBounds = true;
    }
    func backGroundDark(){
        containViewMess.overrideUserInterfaceStyle = .dark
        tabBarVIew.backgroundColor = .black
        containView.backgroundColor = .black
    }
    func backGroundLight(){
        containViewMess.overrideUserInterfaceStyle = .light
        tabBarVIew.backgroundColor = .white
        containView.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
    }
    @objc func dismissKeyboard() {
        containViewMess.endEditing(true)
    }
}

extension MessageVC: UICollectionViewDataSource, UICollectionViewDelegate, SwipeCollectionViewCellDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return userName.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessCLV", for: indexPath) as! MessCLV
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCLVCell", for: indexPath) as! MessageCLVCell
        cell.delegate = self
        cell.reloadData(with: userName[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.userName.remove(at: indexPath.row)
            self.MessTBVMain.deleteItems(at: [indexPath])
        }
        let more = SwipeAction(style: .default, title: "More") { action, indexPath in
            print("more")
        }
        // customize the action appearance
        more.image = UIImage(named: "More")
        return [deleteAction,more]
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hung")
        
    }
}

extension MessageVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: collectionView.frame.width, height: 70)
            }
            return CGSize(width: collectionView.frame.width, height:  widthScreen/2.6)
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: collectionView.frame.width, height: 70)
        }
        return CGSize(width: collectionView.frame.width, height:  widthScreen/4)
        
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
