//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine
import CoreData

class ContentsCVMainView:UICollectionViewCell{

    private var cancellable = Set<AnyCancellable>()
    
    var TodayWordTextLabel = UILabel()
    var TodayWordLabel = UILabel()
    var TodayWordContentLabel = UILabel()
    var TodayWordReplaceBT = UIButton(type: .custom)
    var addWordtoNoteBT = UIButton(type: .custom)
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 메인의 오늘의 단어 텍스트 라벨
        
        
        TodayWordTextLabel.text = "오늘의 단어"
        TodayWordTextLabel.font = UIFont.systemFont(ofSize: 50)
        addSubview(TodayWordTextLabel)
        
        // TodayWordlabel 생성 (오늘의 단어)
        
        TodayWordLabel.text = "오늘의 단어"
        // label font 설정
        TodayWordLabel.font = UIFont.systemFont(ofSize: 40)
        // label 을 뷰에 추가
        addSubview(TodayWordLabel)
        //label 의 길이가 길면 줄바꿈
        TodayWordLabel.numberOfLines = 5
        // 텍스트 좌측 정렬
        TodayWordLabel.textAlignment = .left
        
        
        // TodayWord의 뜻이 표시될 라벨 생성
        
        TodayWordContentLabel.text = "오늘의 단어가 표시될 라벨"
        TodayWordContentLabel.font = UIFont.systemFont(ofSize: 25)
        addSubview(TodayWordContentLabel)
        TodayWordContentLabel.numberOfLines = 5
        
        // TodayWord 새로고침 버튼
        // 버튼 위치
        
        // 버튼 타이틀
        TodayWordReplaceBT.setTitle("오늘의 단어 새로고침", for: .normal)
        // 버튼 백그라운드 컬러 설정
        TodayWordReplaceBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        TodayWordReplaceBT.layer.cornerRadius = 0.2 * TodayWordReplaceBT.bounds.size.width
        TodayWordReplaceBT.clipsToBounds = true
        
        // 버튼 클릭시 repalaceAction 호출
        TodayWordReplaceBT.addTarget(self, action: #selector(replaceAction), for: .touchUpInside)
        // 버튼을 뷰에 추가
        addSubview(TodayWordReplaceBT)
        
        //단어장 추가하기 버튼
        addWordtoNoteBT.setTitle("단어장에 추가하기", for: .normal)
        addWordtoNoteBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        addWordtoNoteBT.layer.cornerRadius = 0.2 * addWordtoNoteBT.bounds.size.width
        addWordtoNoteBT.clipsToBounds = true
        
        // 버튼 클릭시 addNoteAction 호출
        addWordtoNoteBT.addTarget(self, action: #selector(addNoteAction), for: .touchUpInside)
        // 버튼을 뷰에 추가
        addSubview(addWordtoNoteBT)
        
        // TodayWord func 실행
        MainViewModel.VM.Todayword()
        MainCellLayout()
        ChangeWord()
        ChangeContents()
    
        
    }
    // 뷰모델에 word 가 바뀌면, TodayWordlabel 의 텍스트를 VM 에 word 로 바꾼다.
    func ChangeWord(){
        
        MainViewModel.VM.$word.sink { value in
           
            self.TodayWordLabel.text = MainViewModel.VM.word
            
        }.store(in: &cancellable)
    }
    
    // 뷰모델에 contents 가 바뀌면, TodayWordContentslabel 의 텍스트를 VM 에 word 로 바꾼다.
    func ChangeContents(){
        
        MainViewModel.VM.$wordContents.sink { value in
            
            self.TodayWordContentLabel.text = MainViewModel.VM.wordContents
            
        }.store(in: &cancellable)
    }
    
    @objc func replaceAction(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        // TodayWord() 실행
        MainViewModel.VM.Todayword()
        
        
        
    }
    @objc func addNoteAction(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        
        let word = TodayWordLabel.text!
        let wordcontents = TodayWordContentLabel.text!
        
        
        
        if MainViewModel.VM.save(word: word, wordcontents: wordcontents) == true{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
           
       
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //메인 셀 레이아웃
    func MainCellLayout(){
    
        
        TodayWordLabel.translatesAutoresizingMaskIntoConstraints = false
        TodayWordTextLabel.translatesAutoresizingMaskIntoConstraints = false
        TodayWordReplaceBT.translatesAutoresizingMaskIntoConstraints = false
        TodayWordContentLabel.translatesAutoresizingMaskIntoConstraints = false
        addWordtoNoteBT.translatesAutoresizingMaskIntoConstraints = false
        
        //todayword 단순텍스트
        TodayWordTextLabel.textAlignment = .center
        TodayWordTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TodayWordTextLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true

        TodayWordTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
     
        
        
        //todayword 단어
        TodayWordLabel.textAlignment = .center
        TodayWordLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TodayWordLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordLabel.topAnchor.constraint(equalTo: TodayWordTextLabel.bottomAnchor, constant: 100).isActive = true
       
        TodayWordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        
        
        
        //todayword 단어 뜻
        TodayWordContentLabel.textAlignment = .center
        TodayWordContentLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        TodayWordContentLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordContentLabel.topAnchor.constraint(equalTo: TodayWordLabel.bottomAnchor, constant:30).isActive = true
        
        TodayWordContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        TodayWordContentLabel.layer.cornerRadius = 10
        TodayWordContentLabel.layer.borderWidth = 1
        
        
        // todayword 새로고침버튼
        
        TodayWordReplaceBT.heightAnchor.constraint(equalToConstant: 100).isActive = true
        TodayWordReplaceBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordReplaceBT.topAnchor.constraint(equalTo: TodayWordContentLabel.bottomAnchor, constant:50).isActive = true
       
        TodayWordReplaceBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        TodayWordReplaceBT.layer.cornerRadius = 10
        
        // 단어장 추가하기버튼

        addWordtoNoteBT.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addWordtoNoteBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        addWordtoNoteBT.topAnchor.constraint(equalTo: TodayWordReplaceBT.bottomAnchor, constant:10).isActive = true

        addWordtoNoteBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        addWordtoNoteBT.layer.cornerRadius = 10
       
    }
   
}


