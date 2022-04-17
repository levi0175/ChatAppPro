//
//  GroupVC.swift
//  ChatAppPro
//
//  Created by Apple on 08/04/2022.
//

import UIKit

class GroupVC: UIViewController {
    @IBOutlet weak var ContainView:UIView!
    @IBOutlet weak var TabBarView:UIView!
    let bar  = AnimatedSearchBar(frame: CGRect.zero, duration: 3.0, outlineColor: UIColor.black)
    override func viewDidLoad() {
        super.viewDidLoad()
        ContainView.radiusUIViewTopLeft(number: Int(widthScreen)/9)
        TabBarView.radiusUIViewTopLeft(number: Int(widthScreen)/15)
    }
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
         if let bar = searchBar as? AnimatedSearchBar {
             if bar.searchField.isHidden {
                 return false
             }
         }
         return true
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
