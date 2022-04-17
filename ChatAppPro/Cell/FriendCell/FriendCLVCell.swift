//
//  FriendCLVCell.swift
//  ChatAppPro
//
//  Created by Apple on 14/04/2022.
//

import UIKit
var arrTitle = [infoUserList]()
class FriendCLVCell: UICollectionViewCell {
    var ArrSectionTitle = [String]()
    var arrInfoUser = [String: [infoUserList]]()
//    var  statusSearchBar = false
//    var listSearch = [String]()
    @IBOutlet weak var itemTBVFriend: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        itemTBVFriend.dataSource = self
        itemTBVFriend.delegate = self
        itemTBVFriend.register(UINib(nibName: "FriendTBVCell", bundle: nil), forCellReuseIdentifier: "FriendTBVCell")
        // Initialization code
        appendInfoUser()
        
    }
//    func getData(){
//        for i in 0..<arrTitle.count{
//            listSearch.append("\(arrTitle[i].giveName) \(arrTitle[i].familyName)")
//        }
//        print(listSearch)
//    }
    func appendInfoUser(){
        arrTitle = [infoUserList(id: 0, giveName: "Hung", familyName: "Anh", imageUser: "AVT"),
                    infoUserList(id: 1, giveName: "Hung Van", familyName: "Bao", imageUser: "AVT"),
                    infoUserList(id: 2, giveName: "Hung", familyName: "Bo", imageUser: "AVT"),
                    infoUserList(id: 3, giveName: "Hung Van", familyName: "Dung", imageUser: "AVT"),
                    infoUserList(id: 4, giveName: "Hng", familyName: "Hung", imageUser: "AVT")]
        getCharactor()
      //  getData()
    }
    func getCharactor(){
        for item in arrTitle{
            let key = String(item.familyName.prefix(1))
            if var Values = arrInfoUser[key] {
                Values.append(item)
                arrInfoUser[key] = Values
            } else {
                arrInfoUser[key] = [item]
            }
        }
        ArrSectionTitle = [String](arrInfoUser.keys)
        ArrSectionTitle = ArrSectionTitle.sorted(by: { $0 < $1 })
    }

}
extension FriendCLVCell: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return ArrSectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let carKey = ArrSectionTitle[section]
        if let carValues = arrInfoUser[carKey] {
            return carValues.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTBVCell", for: indexPath) as! FriendTBVCell
        let key = ArrSectionTitle[indexPath.section]
        if let value = arrInfoUser[key] {
            cell.lblFriend.text = "\(value[indexPath.row].giveName) \(value[indexPath.row].familyName)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ArrSectionTitle[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ArrSectionTitle
    }
}
//extension FriendCLVCell: UISearchBarDelegate{
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == ""{
//            statusSearchBar = false
//            print("1")
//        }else{
//            print("2")
//            statusSearchBar = true
//        }
//        listSearch = searchText.isEmpty ? listSearch : listSearch.filter({(dataString: String) -> Bool in
//            // If dataItem matches the searchText, return true to include it
//            return dataString.range(of: searchText, options: .caseInsensitive) != nil
//        })
//        self.itemTBVFriend.reloadData()
//    }
//}
