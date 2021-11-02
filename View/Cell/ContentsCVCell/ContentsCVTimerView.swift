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
    //테이블뷰
    let myTableView: UITableView = UITableView()
    
    
    //타이머 시작버튼
    var startTimerBT: UIButton = UIButton()
    
    // 전체삭제 버튼
    var removeTimerBT: UIButton = UIButton()
 
    // 타이머가 모두 삭제됬는지? (타이머 멈추게 하기위함)
    static var isTimerDelete = false
   
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(self.myTableView)
        self.addSubview(startTimerBT)
        self.addSubview(removeTimerBT)
      
        
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        self.startTimerBT.translatesAutoresizingMaskIntoConstraints = false
        self.removeTimerBT.translatesAutoresizingMaskIntoConstraints = false
        
        TVlayout()
        TMBTlayout()
        TMBTremoveLayout()
        sinkVm()
        ViewModel.VM.timerlist.removeAll()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Int(ViewModel.VM.TimerNum)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
       
        cell.textLabel?.text = ViewModel.VM.timerlist[indexPath.row] as! String
        
        return cell
    }
    func TVlayout(){
        
        //tableView layout
        
        self.myTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.myTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.myTableView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
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
        startTimerBT.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
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
        removeTimerBT.widthAnchor.constraint(equalToConstant: 170).isActive = true
        removeTimerBT.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        removeTimerBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        removeTimerBT.layer.cornerRadius = 10
    }
    func sinkVm(){
        
    // vm의 time 값이 변경되면
    ViewModel.VM.$time.sink {  value in
       
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
        
        // 타이머 순서 VM 에 전달
        ViewModel.VM.TimerNum += 1
//
        // 시간 포맷
        let nowDate = Date() // 현재의 Date (ex: 2000-01-01 09:14:48 +0000)

        let dateFormatter = DateFormatter()
        // 데이터 포맷
        dateFormatter.dateFormat = "a hh시mm분ss초"
        // PM, AM 을 오전, 오후로 변경
        dateFormatter.locale =  Locale(identifier: "ko_KR")
        // 현재 시간의 Date를 format에 맞춰 string으로 반환
        let str = dateFormatter.string(from: nowDate)
        
        // 타이머 시작버튼 누르면 isTimerDelete 를 다시 false 로 초기화
        ContentsCVTimerView.isTimerDelete = false
        
        // VM에 timeService 호출
        ViewModel.VM.timeService()
       
//        // 테이블뷰에 아이템 추가
        ViewModel.VM.timerlist.append("[" + String(ViewModel.VM.TimerNum) + "]" + " 시작시간 : " + "\(str)")
        
    }
    
    // 모두 삭제버튼 액션
    @objc func deleteTimer(sender: UIButton!){
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        
        
        ContentsCVTimerView.isTimerDelete = true
        // vm 초기화
        ViewModel.VM.TimerNum = 0
        ViewModel.VM.time = 302
        ViewModel.VM.timerlist.removeAll()
        
        self.myTableView.reloadData()
    
    }
   
  
   
}




