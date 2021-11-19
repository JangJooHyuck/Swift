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
        
        //라벨과 버튼 추가
        addSubview(TodayWordTextLabel)
        addSubview(TodayWordLabel)
        addSubview(TodayWordContentLabel)
        addSubview(TodayWordReplaceBT)
        addSubview(addWordtoNoteBT)
        
        // TodayWord func 실행
        MainViewModel.VM.Todayword()
        MainCellLayout()
        ChangeWord()
        ChangeContents()
        
        
        // CoreData DB 경로 확인용 test
        let container = NSPersistentContainer(name: "SwiftApp")
        print(container.persistentStoreDescriptions.first?.url! as Any)
        
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
    
    // 새로고침 눌렀을 때 버튼 이벤트 설정
    @objc func replaceAction(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        // TodayWord() 실행
        MainViewModel.VM.Todayword()
        
        let alert = UIAlertController(title: "완료", message:"새로운 단어로 변경하였습니다." , preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alert, animated: true, completion: nil)
        
       
    }
    
    //단어장에 추가하기 버튼 눌렀을 때 이벤트
    @objc func addNoteAction(sender: UIButton!)
    {
       
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        // 현재 라벨에 있는 단어와 뜻 텍스트 저장
        let word = TodayWordLabel.text!
        let wordcontents = TodayWordContentLabel.text!
     
        if MainViewModel.VM.save(word: word, wordcontents: wordcontents) == true{
            //단어장 탭 리로드
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            let alert = UIAlertController(title: "완료", message:"단어장에 단어가 추가되었습니다." , preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            let moveAction = UIAlertAction(title: "단어장으로 이동", style: .default){_ in
                // 단어장으로 이동
                ViewModel.VM.CurrentCell = 3
                // 해당단어 저장
                // 해당단된
            }
            alert.addAction(okAction)
            alert.addAction(moveAction)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
        //세이브실패시
        else {
            
            let alert = UIAlertController(title: "실패", message:"해당 단어는 이미 단어장에 존재합니다." , preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            let moveAction = UIAlertAction(title: "단어장으로 이동", style: .default){_ in
                // 단어장으로 이동
                ViewModel.VM.CurrentCell = 3
                // 해당단어 저장
                // 해당단된
            }
            alert.addAction(okAction)
            alert.addAction(moveAction)
           
          
            alert.view.layer.borderWidth = 1
            alert.view.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1.0)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alert, animated: true, completion: nil)
        }
        
           
       
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //메인 셀 레이아웃
    func MainCellLayout(){
        
        //todayword 단순텍스트
        TodayWordTextLabel.translatesAutoresizingMaskIntoConstraints = false
        TodayWordTextLabel.text = "오늘의 단어"
        TodayWordTextLabel.font = UIFont.systemFont(ofSize: 50)
        TodayWordTextLabel.textAlignment = .center
        TodayWordTextLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TodayWordTextLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70).isActive = true
        TodayWordTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
     
        
        //todayword 단어
        TodayWordLabel.translatesAutoresizingMaskIntoConstraints = false
        TodayWordLabel.text = "오늘의 단어"
        TodayWordLabel.font = UIFont.systemFont(ofSize: 40)
        TodayWordLabel.numberOfLines = 5
        TodayWordLabel.textAlignment = .left
        TodayWordLabel.textAlignment = .center
        TodayWordLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        TodayWordLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordLabel.topAnchor.constraint(equalTo: TodayWordTextLabel.bottomAnchor, constant: 100).isActive = true
        TodayWordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        
        
        //todayword 단어 뜻
        TodayWordContentLabel.translatesAutoresizingMaskIntoConstraints = false
        TodayWordContentLabel.textAlignment = .center
        TodayWordContentLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        TodayWordContentLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordContentLabel.topAnchor.constraint(equalTo: TodayWordLabel.bottomAnchor, constant:30).isActive = true
        TodayWordContentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        TodayWordContentLabel.layer.cornerRadius = 10
        TodayWordContentLabel.layer.borderWidth = 1
        TodayWordContentLabel.text = "오늘의 단어가 표시될 라벨"
        TodayWordContentLabel.font = UIFont.systemFont(ofSize: 25)
        TodayWordContentLabel.numberOfLines = 5
         
        
        // todayword 새로고침버튼
        TodayWordReplaceBT.translatesAutoresizingMaskIntoConstraints = false
        TodayWordReplaceBT.heightAnchor.constraint(equalToConstant: 100).isActive = true
        TodayWordReplaceBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        TodayWordReplaceBT.topAnchor.constraint(equalTo: TodayWordContentLabel.bottomAnchor, constant:50).isActive = true
        TodayWordReplaceBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        TodayWordReplaceBT.layer.cornerRadius = 20
        TodayWordReplaceBT.setTitle("오늘의 단어 새로고침", for: .normal)
        TodayWordReplaceBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
                TodayWordReplaceBT.clipsToBounds = true
        TodayWordReplaceBT.addTarget(self, action: #selector(replaceAction), for: .touchUpInside)
    
        
        // 단어장 추가하기버튼
        addWordtoNoteBT.translatesAutoresizingMaskIntoConstraints = false
        addWordtoNoteBT.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addWordtoNoteBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        addWordtoNoteBT.topAnchor.constraint(equalTo: TodayWordReplaceBT.bottomAnchor, constant:10).isActive = true
        addWordtoNoteBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        addWordtoNoteBT.layer.cornerRadius = 20
        addWordtoNoteBT.setTitle("단어장에 추가하기", for: .normal)
        addWordtoNoteBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        addWordtoNoteBT.clipsToBounds = true
        addWordtoNoteBT.addTarget(self, action: #selector(addNoteAction), for: .touchUpInside)
    }
   
}


