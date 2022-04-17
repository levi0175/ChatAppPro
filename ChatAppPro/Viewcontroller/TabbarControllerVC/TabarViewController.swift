//
//  TabarViewController.swift
//  ChatAppPro
//
//  Created by Apple on 08/04/2022.
//

import UIKit

class TabarViewController: UITabBarController {
    var userName = [infoUserMess]()
    let date = String(DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName = [infoUserMess(id: 0, giveName: "Hung", familyName: "Anh", time: date, imageUser: "AVT", wattingMess: 2, messageNew: "Nguyễn Văn Hùng đã gửi tin nhắn cho bạn"),
                    infoUserMess(id: 0, giveName: "Hung Van", familyName: "Bao", time: date, imageUser: "AVT", wattingMess: 3, messageNew: "Nguyễn Đức Bảo đang đi tán gái"),
                    infoUserMess(id: 0, giveName: "Hung", familyName: "Bo", time: date, imageUser: "AVT", wattingMess: 1, messageNew: "Hà Min Tú đang ăn cơm"),
                    infoUserMess(id: 0, giveName: "Hung Van", familyName: "Dung", time: date, imageUser: "AVT", wattingMess: 4, messageNew: "Nguyễn Văn Quang đã gửi tin nhắn cho bạn"),
                    infoUserMess(id: 0, giveName: "Hng", familyName: "Hung", time: date, imageUser: "AVT", wattingMess: 5, messageNew: "Nguyễn Văn Non đã gửi tin nhắn cho bạn"),
        ]
        configureViewController()
    }
    
    private func configureViewController() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(rgb: 0x09092F)

        let messVC = MessageVC(nibName: "MessageVC", bundle: nil)
        messVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "_Message"), tag: 0)
        messVC.txtTitle = "Tin nhắn"
        messVC.userName = userName
        messVC.tabBarItem.image = messVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        
//        let groupVC = GroupVC(nibName: "GroupVC", bundle: nil)
//        groupVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Group"), tag: 1)
//        groupVC.tabBarItem.image = groupVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        
        let friendVC = FriendsVC(nibName: "FriendsVC", bundle: nil)
        friendVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Friend"), tag: 2)
        friendVC.arrTitle = userName
        friendVC.tabBarItem.image = friendVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        
        let meVC = PersonalVC(nibName: "PersonalVC", bundle: nil)
        meVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Me"), tag: 3)
        meVC.tabBarItem.image = meVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        
        self.setViewControllers([messVC,friendVC,meVC], animated: true)
        
        self.tabBar.tintColor = UIColor(rgb: 0x8827BF)
        self.tabBar.backgroundColor = .clear
        self.tabBar.layer.cornerRadius = 12
        self.tabBar.clipsToBounds = true
//         self.tabBar.layer.borderWidth = 1
//         self.tabBar.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
    }
//    override var selectedIndex: Int { // Mark 1
//            didSet {
//                guard let selectedViewController = viewControllers?[selectedIndex] else {
//                    return
//                }
//                selectedViewController.tabBarItem.setTitleTextAttributes([.font: UIFont.init(name: "Roboto-Medium", size: 13) as Any], for: .normal)
//            }
//        }
//
//        override var selectedViewController: UIViewController? { // Mark 2
//            didSet {
//
//                guard let viewControllers = viewControllers else {
//                    return
//                }
//
//                for viewController in viewControllers {
//                    if viewController == selectedViewController {
//                        viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.init(name: "Roboto-Medium", size: 13) as Any], for: .normal)
//                    } else {
//                        viewController.tabBarItem.setTitleTextAttributes([.font: UIFont.init(name: "Roboto-Medium", size: 11) as Any], for: .normal)
//                    }
//                }
//            }
//        }
}
