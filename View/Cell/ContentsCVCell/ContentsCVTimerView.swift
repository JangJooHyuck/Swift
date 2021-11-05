//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine

class ContentsCVTimerView:UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    private var cancellable = Set<AnyCancellable>()

    
    let hourText = UITextField()
    let minText = UITextField()
    let secText = UITextField()
   
  
    //테이블뷰
    let myTableView: UITableView = UITableView()
    
    //타이머 시작버튼
    var startTimerBT: UIButton = UIButton()
    
    // 전체삭제 버튼
    var removeTimerBT: UIButton = UIButton()
 
   
    var tableCellNum = 0
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 시간설정버튼
        
        self.addSubview(hourText)
        self.addSubview(minText)
        self.addSubview(secText)
        
        self.hourText.translatesAutoresizingMaskIntoConstraints = false
        self.minText.translatesAutoresizingMaskIntoConstraints = false
        self.secText.translatesAutoresizingMaskIntoConstraints = false
        
        //테이블뷰 밑 시작,삭제버튼
        self.addSubview(self.myTableView)
        self.addSubview(startTimerBT)
        self.addSubview(removeTimerBT)
      
        
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        self.startTimerBT.translatesAutoresizingMaskIntoConstraints = false
        self.removeTimerBT.translatesAutoresizingMaskIntoConstraints = false
        
        //테이블뷰
        TVlayout()
        //타이머시작버튼
        TMBTlayout()
        //타이머모두삭제버튼
        TMBTremoveLayout()
        //테이블뷰 새로고침
        tableViewReload()
        //시간설정버튼
        TimeSetBtLayout()
        
        //VM 초기화
        TimerViewModel.VM.timerlist.removeAll()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TimerViewModel.VM.timerlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TimerViewModel.VM.timerlist[indexPath.row] as? String
        
     
        return cell
    }
 
    
    
    func TimeSetBtLayout(){
        

        hourText.placeholder = "시간"
        hourText.textAlignment = .center
        hourText.backgroundColor = .clear
        hourText.layer.borderWidth = 1
        hourText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hourText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hourText.topAnchor.constraint(equalTo: startTimerBT.topAnchor, constant: -100).isActive = true
        hourText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        hourText.layer.cornerRadius = 10
        
        
        minText.placeholder = "분"
        minText.textAlignment = .center
        minText.backgroundColor = .clear
        minText.layer.borderWidth = 1
        minText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        minText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        minText.topAnchor.constraint(equalTo: startTimerBT.topAnchor, constant: -100).isActive = true
        minText.leadingAnchor.constraint(equalTo: hourText.leadingAnchor, constant: 130).isActive = true
        minText.layer.cornerRadius = 10
        
        
        secText.placeholder = "초"
        secText.textAlignment = .center
        secText.backgroundColor = .clear
        secText.layer.borderWidth = 1
        secText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        secText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        secText.topAnchor.constraint(equalTo: startTimerBT.topAnchor, constant: -100).isActive = true
        secText.leadingAnchor.constraint(equalTo: minText.leadingAnchor, constant: 130).isActive = true
        secText.layer.cornerRadius = 10
    }
    
    func TVlayout(){
        
        //tableView layout
        
        self.myTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.myTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.myTableView.topAnchor.constraint(equalTo: startTimerBT.bottomAnchor, constant: 20).isActive = true
        self.myTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        self.myTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    func TMBTlayout(){
        
        startTimerBT.setTitle("타이머 시작하기", for: .normal)
        // 버튼 백그라운드 컬러 설정
        startTimerBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        startTimerBT.layer.cornerRadius = 0.2 * startTimerBT.bounds.size.width
        startTimerBT.clipsToBounds = true
    
        // 버튼 클릭시 repalaceAction 호출
        startTimerBT.addTarget(self, action: #selector(addTimer), for: .touchUpInside)
        
        
        startTimerBT.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startTimerBT.widthAnchor.constraint(equalToConstant: 170).isActive = true
        startTimerBT.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        startTimerBT.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        
        startTimerBT.layer.cornerRadius = 10
        
    }
    func TMBTremoveLayout(){
        removeTimerBT.setTitle("모두 삭제", for: .normal)
        // 버튼 백그라운드 컬러 설정
        removeTimerBT.backgroundColor = UIColor(red: 102/255, green: 100/255, blue: 10/255, alpha: 0.5)
        // 버튼 원형으로 생성
        removeTimerBT.layer.cornerRadius = 0.2 * startTimerBT.bounds.size.width
        removeTimerBT.clipsToBounds = true
    
        // 버튼 클릭시 repalaceAction 호출
        removeTimerBT.addTarget(self, action: #selector(deleteTimer), for: .touchUpInside)
        
        
        removeTimerBT.heightAnchor.constraint(equalToConstant: 50).isActive = true
        removeTimerBT.widthAnchor.constraint(equalToConstant: 180).isActive = true
        removeTimerBT.topAnchor.constraint(equalTo: startTimerBT.topAnchor, constant: 0).isActive = true
        removeTimerBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        removeTimerBT.layer.cornerRadius = 10
    }
    
    
     
        
    //vm 타이머배열이 바뀔 때마다 테이블을 재배치한다.
    func tableViewReload(){
        TimerViewModel.VM.$timerlist.sink { value in
          
            self.myTableView.reloadData()
            
        }.store(in: &cancellable)
    }
 
    

    
    @objc func addTimer(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        TimerViewModel.VM.startTimer()
        
        TimerViewModel.VM.isTimerDelete = false
        
        
        // 타이머
        let userSec = Int(secText.text!) ?? 0
        let userMin = Int(minText.text!) ?? 0
        let userHour = Int(hourText.text!) ?? 0
       
        // 시간설정
        TimerViewModel.VM.timeSet = Int(userSec + (userMin * 60 ) + (userHour * 3600))
        // 현재 뷰모델 배열 갯수
        
        
       
    }
    
    
    
    
    
    // 모두 삭제버튼 액션
    @objc func deleteTimer(sender: UIButton!){
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        self.secText.text = nil
        self.minText.text = nil
        self.hourText.text = nil
        
        // vm 초기화
        TimerViewModel.VM.isTimerDelete = true
        
        TimerViewModel.VM.timerlist.removeAll()
        self.myTableView.reloadData()
    
    }
   
  
   
}




