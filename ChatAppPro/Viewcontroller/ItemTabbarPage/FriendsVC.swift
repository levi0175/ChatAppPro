//
//  FriendsVC.swift
//  ChatAppPro
//
//  Created by Apple on 08/04/2022.
//

import UIKit
import SwiftKeychainWrapper
class FriendsVC: UIViewController {
    @IBOutlet weak var viewMenu: UIView!
    @IBOutlet weak var ContainView: UIView!
    @IBOutlet weak var listCollection: UICollectionView!
    @IBOutlet weak var btnRequired: UIButton!
    @IBOutlet weak var btnAllFriend: UIButton!
    @IBOutlet weak var TabBarView: UIView!
    @IBOutlet weak var btnFriend: UIButton!
    
    @IBOutlet weak var viewTabar: UIView!
    @IBOutlet weak var darkView: UIView!
    @IBOutlet weak var searchBarFriend: UISearchBar!
    var hori : NSLayoutConstraint?
    var runHori : Float = 0.0
    var statusSearchBar = false
    var listSearch = [String]()
    var his = [String]()
    var isSwitchMess = 0
    var arrTitle = [infoUserMess]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBarFriend()
    
        listCollection.dataSource = self
        listCollection.delegate = self
        searchBarFriend.delegate = self
        
        ContainView.radiusUIViewTopLeft(number: Int(widthScreen)/9)
        listCollection.register(UINib(nibName: FriendCLVCell.className, bundle: nil), forCellWithReuseIdentifier: "FriendCLVCell")
        listCollection.register(UINib(nibName: SearchFriendCLVCell.className, bundle: nil), forCellWithReuseIdentifier: "SearchFriendCLVCell")

        NotificationCenter.default.addObserver(self, selector: #selector(GetName_(_:)), name: Notification.Name("txtID"), object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        darkView.addGestureRecognizer(tap)
        setupHorizonalBar()
        setUpCollectionView()
        defaultbt()
       
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let Save:Int =  KeychainWrapper.standard.integer(forKey: "SAVE_SWITCH_FR"){
            isSwitchMess = Save
        }
        if isSwitchMess == 1{
           
            backGroundDark()
        }else{
            backGroundLight()
        }
    }
    @objc func dismissKeyboard() {
        darkView.endEditing(true)
    }
    @objc func GetName_(_ notification : Notification){
        let text = notification.object as! Int
        isSwitchMess = text
        KeychainWrapper.standard.set(isSwitchMess, forKey: "SAVE_SWITCH_FR")
        if isSwitchMess == 1{
            backGroundDark()
        }else{
            backGroundLight()
        }
        print(isSwitchMess)
    }
    func setSearchBarFriend(){
        searchBarFriend.layer.borderColor = UIColor.white.cgColor
        searchBarFriend.tintColor = UIColor.clear
        searchBarFriend.backgroundColor = .clear
        searchBarFriend.layer.borderWidth = 1
        searchBarFriend.layer.cornerRadius = widthScreen/15
        searchBarFriend.clipsToBounds = true;
    }
    func backGroundDark(){
        darkView.overrideUserInterfaceStyle = .dark
        ContainView.backgroundColor = .black
        viewTabar.backgroundColor = .black
        
    }
    func backGroundLight(){
        darkView.overrideUserInterfaceStyle = .light
        ContainView.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        viewTabar.backgroundColor = hexStringToUIColor(hex: "F5F5F5")
        
    }
    func getData(){
        for i in 0..<arrTitle.count{
            listSearch.append("\(arrTitle[i].giveName) \(arrTitle[i].familyName)")
        }
        print(listSearch)
    }
    func setUpCollectionView() {
        listCollection.isPagingEnabled = true
        if let flowLayout = listCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    func setupHorizonalBar(){
        
        let horizonal = UIView()
        horizonal.backgroundColor = hexStringToUIColor(hex: "5B71E2")
        horizonal.translatesAutoresizingMaskIntoConstraints = false
        viewMenu.addSubview(horizonal)
        
        horizonal.bottomAnchor.constraint(equalTo: viewMenu.bottomAnchor).isActive = true
        horizonal.widthAnchor.constraint(equalTo: viewMenu.widthAnchor, multiplier: 1/3).isActive = true
        horizonal.heightAnchor.constraint(equalToConstant: 4).isActive = true
        hori = horizonal.leftAnchor.constraint(equalTo: self.viewMenu.leftAnchor, constant: 0)
        
        hori?.isActive = true
    }
    func  defaultbt(){
        btnFriend.setTitleColor(hexStringToUIColor(hex: "5B71E2"), for: .normal)
        btnAllFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
        btnRequired.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
    }
    func scrollMenuItemIndex(menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        listCollection.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnMenuClick(_ sender: UIButton) {
        
        scrollMenuItemIndex(menuIndex: sender.tag)
        runHori = Float(CGFloat(sender.tag) * viewMenu.frame.width/3)
        hori?.constant = CGFloat(runHori)
        UIView.animate(withDuration: 0.4, animations: {
            self.viewMenu.layoutIfNeeded()
        })
        switch sender.tag{
        case 0:
            defaultbt()
        case 1:
            btnFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnAllFriend.setTitleColor(hexStringToUIColor(hex: "5B71E2"), for: .normal)
            btnRequired.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            
        case 2:
            btnFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnAllFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnRequired.setTitleColor(hexStringToUIColor(hex: "5B71E2"), for: .normal)
        default: break
        }
    }
}
extension FriendsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if statusSearchBar == false{
            return 3
        }
        return his.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if statusSearchBar == false{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCLVCell", for: indexPath) as? FriendCLVCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchFriendCLVCell", for: indexPath) as? SearchFriendCLVCell else {
            return UICollectionViewCell()
        }
        cell.lblNameFriend.text = his[indexPath.row]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if UIDevice.current.userInterfaceIdiom == .pad{
            hori?.constant = scrollView.contentOffset.x/9.1
            print(scrollView.contentOffset.x/9.1)
        }
        hori?.constant = scrollView.contentOffset.x/3.82
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("x: \(Int(targetContentOffset.pointee.x / viewMenu.frame.width))")
        
        let index = Int(targetContentOffset.pointee.x / viewMenu.frame.width)
        if (index == 0){
            btnFriend.setTitleColor(hexStringToUIColor(hex: "5B71E2"), for: .normal)
            btnAllFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnRequired.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            
        }else if (index == 1){
            btnFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnAllFriend.setTitleColor(hexStringToUIColor(hex: "5B71E2"), for: .normal)
            btnRequired.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            
        }else {
            btnFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnAllFriend.setTitleColor(hexStringToUIColor(hex: "999999"), for: .normal)
            btnRequired.setTitleColor(hexStringToUIColor(hex: "5B71E2"), for: .normal)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hung")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if statusSearchBar == false{
            if UIDevice.current.userInterfaceIdiom == .pad{
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            }
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: collectionView.frame.width, height: 70)
        }
        return CGSize(width: collectionView.frame.width, height: 70)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if statusSearchBar == false{
            return 0
        }
        return 50
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension FriendsVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            statusSearchBar = false
            his.removeAll()
        }else{
            statusSearchBar = true
        }
        if let layout = listCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        his = searchText.isEmpty ? listSearch : listSearch.filter({(dataString: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        print("his: \(his)")
        self.listCollection.reloadData()
    }
}
