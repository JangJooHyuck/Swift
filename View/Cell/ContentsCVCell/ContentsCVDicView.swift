//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine
import CoreData


class ContentsCVDicView:UICollectionViewCell{

    var cancellable = Set<AnyCancellable>()
    
    
    // 사용자가 단어를 입력하는 곳
    let WordTextField =  UITextField()
    
    // 사용자가 입력한 단어의 뜻이 표출되는 라벨
    var WordLabel = UILabel()
    
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(WordLabel)
        addSubview(WordTextField)
       
        
        // textField 에 입력된값 실시간 체크
        WordTextField.addTarget(self, action: #selector(ChangeWord), for:UIControl.Event.editingChanged)
        
       
        // 버튼을 뷰에 추가
        DicLayout()
        ChangeWordContents()
       
        
    }
    
    @objc func ChangeWord(){
    
        DicViewModel.VM.UserWord = self.WordTextField.text!
       
        DicViewModel.VM.Findword()
     
    }
    
    func ChangeWordContents(){
        
        DicViewModel.VM.$UserWordContents.sink { value in
            
        self.WordLabel.text = value
          
        }.store(in: &cancellable)
    }

   
    
   
    //사전 레이아웃
    func DicLayout(){
        
        WordTextField.translatesAutoresizingMaskIntoConstraints = false
        WordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //사용자가 값을 입력하는 곳
        WordTextField.textAlignment = .center
        WordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        WordTextField.widthAnchor.constraint(equalToConstant: 400).isActive = true
        WordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        WordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        WordTextField.placeholder = "검색하실 단어를 입력해주세요."
        WordTextField.font = UIFont.systemFont(ofSize: 15)
        WordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        WordTextField.backgroundColor = UIColor(red: 102/255, green: 240/255, blue: 10/255, alpha: 0.5)
        
        
        //사용자가 입력한 단어의 뜻이 표출되는 곳
        WordLabel.textAlignment = .center
        WordLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        WordLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        WordLabel.topAnchor.constraint(equalTo: WordTextField.bottomAnchor, constant: 10).isActive = true
        WordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        WordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        WordLabel.font = UIFont.systemFont(ofSize: 20)
       
        
        //label 의 길이가 길면 줄바꿈
        WordLabel.numberOfLines = 5
        // 텍스트 좌측 정렬
        WordLabel.textAlignment = .left
        WordLabel.layer.cornerRadius = 10
        WordLabel.layer.borderWidth = 1
        
      
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}



