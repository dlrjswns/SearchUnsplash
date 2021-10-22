//
//  RootViewController.swift
//  UnplashSearch
//
//  Created by 이건준 on 2021/10/23.
//

import UIKit

class RootViewController:UIViewController{
    lazy var imageView:UIImageView={
       let imageView = UIImageView()
        imageView.image = UIImage(named: "image1.png")
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var segmentControl:UISegmentedControl={
       let segment = UISegmentedControl(items: ["사진검색", "사용자검색"])
        return segment
    }()
    
    lazy var textField:UITextField={
       let textField = UITextField()
        textField.backgroundColor = .tertiarySystemGroupedBackground
        textField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.placeholder = "사진 키워드 입력"
        textField.layer.cornerRadius = 10
        textField.addLeftImage(image: UIImage(systemName: "magnifyingglass")!)
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    lazy var button:UIButton={
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("검색", for: UIControl.State.normal)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 5
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        keyboardMoveWhenTapped()
        keyboardHideWhenTapped()
        self.textField.delegate = self
    }
    
    //MARK: -Configure
    func configure(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        view.addSubview(segmentControl)
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40).isActive = true
        
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 30).isActive = true
    
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
    }
    
}

extension RootViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count != 1 && string.count == 1{
            button.isHidden = false
        }else if textField.text?.count == 1 && string.count == 0{
            button.isHidden = true
        }
        return true
        
    }
}
