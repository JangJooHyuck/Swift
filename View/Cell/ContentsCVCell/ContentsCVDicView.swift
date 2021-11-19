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
    
    // 단어장에 추가하기 버튼
    var addWordtoNoteBT = UIButton(type: .custom)
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(WordLabel)
        addSubview(WordTextField)
        addSubview(addWordtoNoteBT)
        
        // 버튼을 뷰에 추가
        DicLayout()
        ChangeWordContents()
    }
    
   //단어장에 추가하기 버튼을 눌렀을 때
    @objc func addNoteAction(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        // 텍스트 필드가 비어있지 않을 때만 단어장 추가를 실행함
        if WordTextField.text != "" {
        let word = WordTextField.text!
        let wordcontents = WordLabel.text!
        print(MainViewModel.VM.wordlist.count)
        
         //세이브 성공시
        if MainViewModel.VM.save(word: word, wordcontents: wordcontents) == true{
            //단어장 탭 리로드
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            let alert = UIAlertController(title: "완료", message:"단어장에 해당 단어가 추가되었습니다." , preferredStyle: UIAlertController.Style.alert)
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
        //세이브 실패시
        else {
            let alert = UIAlertController(title: "실패", message:"해당 단어는 이미 단어장에 존재합니다." , preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            let moveAction = UIAlertAction(title: "단어장으로 이동", style: .default){_ in
                // 단어장으로 이동
                ViewModel.VM.CurrentCell = 3
                // 해당단어 저장
            }
            alert.addAction(okAction)
            alert.addAction(moveAction)
            alert.view.layer.borderWidth = 1
            alert.view.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1.0)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        //단어가 입력되지 않았을 시
        else{
            let alert = UIAlertController(title: "실패", message:"단어가 입력되지 않았습니다" , preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            alert.view.layer.borderWidth = 1
            alert.view.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1.0)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    // 텍스트필드에 값이 입력될 때마다 실행
    @objc func ChangeWord(){
        DicViewModel.VM.UserWord = self.WordTextField.text!
        DicViewModel.VM.Findword()
    }
    
    func ChangeWordContents(){
        DicViewModel.VM.$UserWordContents.sink { value in
        self.WordLabel.text = value
        }.store(in: &cancellable)
    }
    
    //사전메뉴 컴포넌트들 레이아웃
    func DicLayout(){
        
        //사용자가 값을 입력하는 곳
        // textField 에 입력된값 실시간 체크
        WordTextField.addTarget(self, action: #selector(ChangeWord), for:UIControl.Event.editingChanged)
        WordTextField.textAlignment = .center
        WordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        WordTextField.widthAnchor.constraint(equalToConstant: 400).isActive = true
        WordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 250).isActive = true
        WordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        WordTextField.placeholder = "검색하실 단어를 입력해주세요."
        WordTextField.font = UIFont.systemFont(ofSize: 15)
        WordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        WordTextField.backgroundColor = UIColor(red: 102/255, green: 240/255, blue: 10/255, alpha: 0.5)
        WordTextField.translatesAutoresizingMaskIntoConstraints = false
        WordTextField.layer.cornerRadius = 20
        
        //사용자가 입력한 단어의 뜻이 표출되는 곳
        WordLabel.textAlignment = .center
        WordLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        WordLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        WordLabel.topAnchor.constraint(equalTo: WordTextField.bottomAnchor, constant: 10).isActive = true
        WordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        WordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        WordLabel.font = UIFont.systemFont(ofSize: 20)
        WordLabel.translatesAutoresizingMaskIntoConstraints = false
        WordLabel.numberOfLines = 5
        WordLabel.textAlignment = .left
        WordLabel.layer.cornerRadius = 20
        WordLabel.layer.borderWidth = 1
        
        // 단어장 추가하기버튼
        addWordtoNoteBT.translatesAutoresizingMaskIntoConstraints = false
        addWordtoNoteBT.setTitle("단어장에 추가하기", for: .normal)
        addWordtoNoteBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        addWordtoNoteBT.layer.cornerRadius = 20
        addWordtoNoteBT.clipsToBounds = true
        addWordtoNoteBT.addTarget(self, action: #selector(addNoteAction), for: .touchUpInside)
        addWordtoNoteBT.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addWordtoNoteBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        addWordtoNoteBT.topAnchor.constraint(equalTo: WordLabel.bottomAnchor, constant:50).isActive = true
        addWordtoNoteBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        addWordtoNoteBT.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



