//
//  RootViewController.swift
//  UnplashSearch
//
//  Created by 이건준 on 2021/10/23.
//

import UIKit
import Toast_Swift
import Alamofire

class RootViewController:UIViewController{
    var item = [ImageItem]()
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
       let segment = UISegmentedControl(items: ["사진 키워드", "사용자 입력"])
        segment.addTarget(self, action: #selector(segmentTapped), for: UIControl.Event.valueChanged)
        segment.setImage(UIImage(systemName: "person.fill"), forSegmentAt: 1)
        segment.setImage(UIImage(systemName: "photo.fill"), forSegmentAt: 0)
        segment.widthAnchor.constraint(equalToConstant: 150).isActive = true
        segment.selectedSegmentIndex = 0 //Segment0 Tapped When StartProject
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
        button.addTarget(self, action: #selector(goToVC), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        keyboardMoveWhenTapped()
        keyboardHideWhenTapped()
        self.textField.delegate = self
        callAPI(query: "Cat")
    }
    //MARK: -Objc
    @objc func segmentTapped(_ sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            textField.placeholder = "사진 키워드 입력"
        case 1:
            textField.placeholder = "사용자 이름 입력"
        default:
            print("segmentTapped()")
        }
    }
    
    @objc func goToVC(){
        if segmentControl.selectedSegmentIndex == 0{
            self.present(ImageViewController(), animated: true, completion: nil)
        }else if segmentControl.selectedSegmentIndex == 1{
            self.present(PersonViewController(), animated: true, completion: nil)
        }else{
            makeCustomToast(message: "무엇을 검색할까요?", title: "알림", imageName: "alarm.png")
        }
        
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
    
    func callAPI(query:String){
        let urI = "\(API.BASE_URL)search/photos?query=\(query)&client_id=\(API.CLIENT_ID)"
        let urL:URL! = URL(string: urI)
        let apiData = try! Data(contentsOf: urL)
        
        do{
            let apiDictionary = try JSONSerialization.jsonObject(with: apiData, options: []) as! NSDictionary
            let results = apiDictionary["results"] as! NSArray
            
            for a in results{
               let urls = a as! NSDictionary
               let thumb = urls["urls"] as! NSDictionary
               let thumbURL = thumb["thumb"] as! String
                let url:URL! = URL(string: thumbURL)
               let data = try! Data(contentsOf: url)
                let item = ImageItem()
                item.image = UIImage(data: data)
                item.append(item)
            }
        }catch{}
    }
}

extension RootViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count != 1 && string.count == 1{
            button.isHidden = false
        }else if textField.text?.count == 1 && string.count == 0{
            button.isHidden = true
        }
        
        let count = textField.text!.count + string.count
        if count>12{
            makeCustomToast(message: "12자만 입력가능합니다", title: "알림", imageName: "alarm.png")
            return false
        }else{
            return true
        }
        
    }
}
