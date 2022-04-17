//
//  Extention.swift
//  ChatAppPro
//
//  Created by Apple on 06/04/2022.
//

import Foundation
import SwiftMessages
var widthScreen = UIScreen.main.bounds.width
extension NSObject {
    var className: String {
        
        return String(describing: type(of: self))
    }
    
    class var className: String {
        
        return String(describing: self)
    }

}
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
extension UIViewController {
    func showError(message: String){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.error)
        success.configureDropShadow()
        success.configureContent(title: "Error", body: message)
        success.button?.isHidden = true
        
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
    
    func showSuccess(message: String){
        let success = MessageView.viewFromNib(layout: .cardView)
        success.configureTheme(.success)
        success.configureDropShadow()
        success.configureContent(title: "Success", body: message)
        success.button?.isHidden = true
        var successConfig = SwiftMessages.defaultConfig
        successConfig.presentationStyle = .top
        successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        SwiftMessages.show(config: successConfig, view: success)
    }
}
extension UIView {
    func radiusUIViewTopLeft(number: Int){
      
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset =  CGSize.zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        clipsToBounds = true
        layer.cornerRadius = CGFloat(number)
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 6, height: 6)
        layer.shadowRadius = 5.0
    }
   
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
extension UIImageView {

    func makeRounded() {

        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
extension UIView {
    var parentMess: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
extension UILabel {

    // extension user defined Method
    func setRoundEdge(radius: Float) {
        self.layer.cornerRadius = CGFloat(radius)
      //  self.textColor = UIColor.blue
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
