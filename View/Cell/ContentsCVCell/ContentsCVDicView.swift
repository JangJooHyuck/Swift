//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine

class ContentsCVDicView:UICollectionViewCell{

    private var cancellable = Set<AnyCancellable>()
    
    // 사용자가 단어를 입력하는 곳
    let WordTextField =  UITextField()
    
    // 사용자가 입력한 단어의 뜻이 표출되는 라벨
    var WordLabel = UILabel()
    
    // 단어장 추가 버튼
    var addWord = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(WordLabel)
        addSubview(WordTextField)
        addSubview(addWord)
        
        // textField 에 입력된값 실시간 체크
        WordTextField.addTarget(self, action: #selector(ChangeWord), for:UIControl.Event.editingChanged)
        
        // 버튼 클릭시 searchAction 호출
        addWord.addTarget(self, action: #selector(addwordBT), for: .touchUpInside)
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
            print(value)
            
        }.store(in: &cancellable)
    }

    //  add word 버튼 이벤트 설정
    @objc func addwordBT(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        
    }
   
    //사전 레이아웃
    func DicLayout(){
        
        WordTextField.translatesAutoresizingMaskIntoConstraints = false
        WordLabel.translatesAutoresizingMaskIntoConstraints = false
        addWord.translatesAutoresizingMaskIntoConstraints = false
        
        //사용자가 값을 입력하는 곳
        WordTextField.textAlignment = .center
        WordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        WordTextField.widthAnchor.constraint(equalToConstant: 400).isActive = true
        WordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        WordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        WordTextField.placeholder = "Enter Word here"
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
        
        //단어장 추가 버튼
        
        addWord.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addWord.widthAnchor.constraint(equalToConstant: 400).isActive = true
        addWord.topAnchor.constraint(equalTo: WordLabel.bottomAnchor, constant: 50).isActive = true
        addWord.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        addWord.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        addWord.setTitle("단어장에 추가하기", for: .normal)
        addWord.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        addWord.layer.cornerRadius = 0.05 * addWord.bounds.size.width
        addWord.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}



