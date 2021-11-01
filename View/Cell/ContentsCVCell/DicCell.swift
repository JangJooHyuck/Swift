//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit

class DicCell:UICollectionViewCell{

    // 사용자가 단어를 입력하는 곳
    let WordTextField =  UITextField()
    
    // 사용자가 입력한 단어의 뜻이 표출되는 라벨
    var WordLabel = UILabel()
    
    // 단어장 추가 버튼
    var addWord = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        WordLabel.frame = CGRect(x:50, y: 350, width: 300, height: 300)
       
    
        
        // label font 설정
        WordLabel.font = UIFont.systemFont(ofSize: 20)
        // label 을 뷰에 추가
        addSubview(WordLabel)
        //label 의 길이가 길면 줄바꿈
        WordLabel.numberOfLines = 5
        // 텍스트 좌측 정렬
        WordLabel.textAlignment = .left
        
        // 사용자가 입력할 word TextField 설정
        
        // textField 설정
       
        // textField placeHolder 설정
           WordTextField.placeholder = "Enter Word here"
        // textField font 설정
           WordTextField.font = UIFont.systemFont(ofSize: 15)
        // textField 박스 설정
           WordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        WordTextField.backgroundColor = UIColor(red: 102/255, green: 240/255, blue: 10/255, alpha: 0.5)
        // textField 뷰에 추가
           addSubview(WordTextField)
        // textField 에 입력된값 실시간 체크
        WordTextField.addTarget(self, action: #selector(Findword), for:UIControl.Event.editingChanged)
        
        // 검색버튼 설정
        // 버튼 크기,위치
        addWord.frame = CGRect(x:60, y:800, width: 300, height: 50)
        // 버튼 타이틀
        addWord.setTitle("단어장에 추가하기", for: .normal)
        // 버튼 백그라운드 컬러 설정
        addWord.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        addWord.layer.cornerRadius = 0.05 * addWord.bounds.size.width
        addWord.clipsToBounds = true
        
        // 버튼 클릭시 searchAction 호출
        addWord.addTarget(self, action: #selector(addwordBT), for: .touchUpInside)
        // 버튼을 뷰에 추가
        addSubview(addWord)
        DicLayout()
        
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
    // 단어찾기
    // 오늘의 단어
    @objc func Findword() {
        
        if WordTextField.text?.isEmpty ?? true {
            WordLabel.text = nil
        }
        //urlString에 vs에서 만든 api를 호출하고 wordTextField의 텍스트를 붙인다.
        let urlString = "http://localhost:1233/api/dictionary?word=" + WordTextField.text!
        //url 주소에 한글이 들어가면 인식을 못하기 때문에 addingPercentEncoding으로 변환함
        let encoding = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        if let urlpath = URL(string: encoding) {
            
            var request = URLRequest.init(url: urlpath)
            request.httpMethod = "GET"
            print (urlpath)
            URLSession.shared.dataTask(with: request){ (data, response, error) in
                guard let data = data
                else
                {
                    return
        
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                                    
                    //word 가져오기
                    if let content = json["content"] as? String{
                                    
                                    DispatchQueue.main.async {
                                        self.WordLabel.text = content
                                        
                                    }
                                }
                    // content 가져오기
                        }
            }.resume()
        }
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
        WordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        //사용자가 입력한 단어의 뜻이 표출되는 곳
        WordLabel.textAlignment = .center
        WordLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        WordLabel.widthAnchor.constraint(equalToConstant: 400).isActive = true
        WordLabel.topAnchor.constraint(equalTo: WordTextField.bottomAnchor, constant: 10).isActive = true
        WordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        WordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        WordLabel.layer.cornerRadius = 10
        WordLabel.layer.borderWidth = 1
        
        //단어장 추가 버튼
        
        addWord.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addWord.widthAnchor.constraint(equalToConstant: 400).isActive = true
        addWord.topAnchor.constraint(equalTo: WordLabel.bottomAnchor, constant: 50).isActive = true
        addWord.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        addWord.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}



