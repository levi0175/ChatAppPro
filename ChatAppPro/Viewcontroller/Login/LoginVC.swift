//
//  LoginVC.swift
//  ChatAppPro
//
//  Created by Apple on 06/04/2022.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassWord: UITextField!
    //    @IBOutlet weak var btnForgetPassWord: UIButton!
    //    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnShowPassWord: UIButton!
    
    @IBOutlet var ContainView: UIView!
    var checkLogin = 0
    var checkLogined = 0
    var checkShowPass = false
    override func viewDidLoad() {
        super.viewDidLoad()
        btnShowPassWord.isHidden = true
        tabTextField()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textFieldEmail.addTarget(self, action: #selector(LoginVC.textFieldDidChangeEmail(_:)),
                                 for: .editingChanged)
        textFieldPassWord.addTarget(self, action: #selector(LoginVC.textFieldDidChangePassWord(_:)),
                                    for: .editingChanged)
     
    }
   
    func tabTextField(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
    
        ContainView.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        ContainView.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.ContainView.frame.origin.y == 0 {
                self.ContainView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.ContainView.frame.origin.y != 0 {
            self.ContainView.frame.origin.y = 0
        }
    }
    @objc func textFieldDidChangeEmail(_ textField: UITextField) {
        if (textField.text == ""){
            btnLogin.setBackgroundImage(UIImage.init(named: "BtnLoginNo"), for: UIControl.State.normal)
            print("no")
        }else{
            print("ok")
            btnLogin.setBackgroundImage(UIImage.init(named: "BtnLoginOk"), for: UIControl.State.normal)
        }
        
    }
    @objc func textFieldDidChangePassWord(_ textField: UITextField) {
        if (textField.text == ""){
            btnShowPassWord.isHidden = true
            print("no")
        }else{
            btnShowPassWord.isHidden = false
            print("ok")
            
        }
    }
    @IBAction func btnLogin(_ sender: Any) {
        
        checkLogin += 1
        if checkLogin == 3{
            checkLogin = 0
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa có tài khoản? tạo ngay", preferredStyle: .alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Sign Up", style: .default, handler: { (handler) in
                let vc = SignUpVC(nibName: SignUpVC.className, bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler:{ (handler) in
            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let email = textFieldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passWord = textFieldPassWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if email.isValidEmail == false{
                self.showError(message: "Email không cú pháp ...@gmail.com")
            }else{
                Auth.auth().signIn(withEmail: email, password: passWord) { (result, error) in
                    if error != nil {
                        self.showError(message: "Đăng nhập thất bại, sai tài khoản hoặc mật khẩu")
                        // self.errorLabel.text = error!.localizedDescription
                        // self.errorLabel.alpha = 1
                    }
                    else {
                        self.showSuccess(message: "Đăng nhập thành công")
                        let vc = TabarViewController(nibName: TabarViewController.className, bundle: nil)
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true)
                    }
                }
            }
        }
    }
    @IBAction func btnSignUp(_ sender: Any) {
        let vc = SignUpVC(nibName: SignUpVC.className, bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    @IBAction func btnForgetPassWord(_ sender: Any) {
        
    }
    @IBAction func btnShowPassWordAct(_ sender: Any) {
        if checkShowPass == false{
            textFieldPassWord.isSecureTextEntry = false
        }else{
            textFieldPassWord.isSecureTextEntry = true
        }
        checkShowPass = !checkShowPass
    }
}
