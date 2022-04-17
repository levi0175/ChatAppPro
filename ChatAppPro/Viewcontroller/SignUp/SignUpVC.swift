//
//  SignUpVC.swift
//  ChatAppPro
//
//  Created by Apple on 06/04/2022.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
class SignUpVC: UIViewController {
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassWord: UITextField!
    @IBOutlet weak var textFieldCheckPassWord: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var ContainView: UIView!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnStatusTerm: UIButton!
    @IBOutlet var MainView: UIView!
    var checkTerms = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        MainView.addGestureRecognizer(tap)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textFieldEmail.addTarget(self, action: #selector(SignUpVC.textFieldDidChangeEmail(_:)),
                                 for: .editingChanged)
    }
    @objc func dismissKeyboard() {
        MainView.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.MainView.frame.origin.y == 0 {
                self.MainView.frame.origin.y -= widthScreen/2.42
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.ContainView.frame.origin.y != 0 {
            self.MainView.frame.origin.y = 0
        }
    }
    @objc func textFieldDidChangeEmail(_ textField: UITextField) {
        if (textField.text == ""){
            btnSignUp.setBackgroundImage(UIImage.init(named: "BtnLoginNo"), for: UIControl.State.normal)
            print("\(checkTerms)")
        }else{
            print("ok")
            btnSignUp.setBackgroundImage(UIImage.init(named: "BtnLoginOk"), for: UIControl.State.normal)
        }
    }
    @IBAction func btnSignUp(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            // There's something wrong with the fields, show error message
            self.showError(message: error ?? "Xin mời nhập lại")
        }
        else {
            let UserName = textFieldName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let Password = textFieldPassWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let Email = textFieldEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if Email.isValidEmail == false{
                self.showError(message: "Email không cú pháp ...@gmail.com")
            }else if checkTerms == false{
                self.showError(message: "Bạn cần đồng ý các chính sách và điều khoản")
            }else{
                Auth.auth().createUser(withEmail: Email, password: Password) { (result, err) in
                    if err != nil {
                        // There was an error creating the user
                        self.showError(message: "Error creating user")
                    }
                    else {
                        // User was created successfully, now store the first name and last name
                        let db = Firestore.firestore()
                        
                        db.collection("users").addDocument(data: ["user":UserName, "passWord":Password, "email":Email, "uid": result!.user.uid ]) { (error) in
                            
                            //                            if error != nil {
                            //                                // Show error message
                            //                                self.showError(message: "Error saving user data")
                            //                            }
                        }
                        self.showSuccess(message: "Tạo tài khoản thành công")
                        self.dismiss(animated: true)
                    }
                }
            }
        }
    }
    @IBAction func btnTerms(_ sender: Any) {
        
        
    }
    @IBAction func btnPolicy(_ sender: Any) {
    }
    @IBAction func btnCheckTerm(_ sender: Any) {
        if checkTerms{
            btnStatusTerm.setBackgroundImage(UIImage.init(named: "checkNone"), for: UIControl.State.normal)
            print("no")
        }else{
            btnStatusTerm.setBackgroundImage(UIImage.init(named: "check"), for: UIControl.State.normal)
            print("oke")
        }
        checkTerms = !checkTerms
    }
    func validateFields() -> String? {
        let userEmail = Auth.auth().currentUser?.email
        
        if textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == userEmail {
            
            self.showError(message: "Email đã tồn tại")
        }else{
            if textFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || textFieldPassWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                self.showError(message: "Hãy nhập đầy đủ thông tin")
                //            return "Hãy nhập đầy đủ thông tin"
            }
            if textFieldCheckPassWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) != textFieldPassWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                self.showError(message: "Mật khẩu không khớp")
                return "Mật khẩu không khớp"
            }
        }
        return nil
    }
    //    func showError(_ message:String) {
    //        errorLabel.text = message
    //        errorLabel.alpha = 1
    //    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
