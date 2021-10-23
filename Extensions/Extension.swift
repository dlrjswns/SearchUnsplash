//
//  DesignUITextField.swift
//  UnplashSearch
//
//  Created by 이건준 on 2021/10/23.
//

import UIKit
import Toast_Swift
extension UITextField{
    func addLeftImage(image:UIImage){
        let imageView = UIImageView(image: image)
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.leftView = imageView
        self.leftViewMode = .always
    }
}

extension UIViewController{
    func makeCustomToast(message:String, title:String, imageName:String){
        var style = ToastStyle()
        style.backgroundColor = .white
        style.titleColor = .black
        style.titleFont = UIFont.boldSystemFont(ofSize: 20)
        style.messageColor = .black
        style.titleAlignment = .center
        self.view.makeToast(message, duration: 1.0, position: .center, title: title, image: UIImage(named: imageName), style: style, completion: nil)
    }
    @objc func keyboardWillShow(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(){
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    func keyboardMoveWhenTapped(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    func keyboardHideWhenTapped(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}
