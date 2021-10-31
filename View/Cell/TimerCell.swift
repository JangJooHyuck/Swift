//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit

class TimerCell:UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    
   
    //테이블뷰
    let myTableView: UITableView = UITableView()
    var timerlist : Array = [""]
    
    //타이머 시작버튼
    var startTimerBT: UIButton = UIButton()
    // timer
    let timer : UILabel = UILabel()
    
    // timer 시간
    var limitTime : Int = 180 // 3분으로 설정
    // 버튼 타이틀
    
    
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        timer.frame = CGRect(x:0,y:0,width: bounds.width, height: bounds.height )
        
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.addSubview(myTableView)
        self.addSubview(startTimerBT)
        self.addSubview(timer)
        
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        self.startTimerBT.translatesAutoresizingMaskIntoConstraints = false
        
        TVlayout()
        TMBTlayout()
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timerlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = timerlist[indexPath.row]
        
        return cell
    }
    func TVlayout(){
        
        //tableView layout
        
        myTableView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        myTableView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        myTableView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        myTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        myTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
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
        startTimerBT.widthAnchor.constraint(equalToConstant: 400).isActive = true
        startTimerBT.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        startTimerBT.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        startTimerBT.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        startTimerBT.layer.cornerRadius = 10
        
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
        
        getSetTime()
        // 테이블뷰에 아이템 추가
       
       // self.timerlist.append("[" + String(ViewModel.VM.TimerNum) + "]" + " 현재시간 : " + "\(Date())")
        self.timerlist.append(timer.text!)
       // self.timerlist.append("종료시간 : " + "\(Date() - 300)")
     
        //테이블뷰 리로드
        self.myTableView.reloadData()
       
    }
    
    @objc func getSetTime(){
        secToTime(sec: limitTime)
        limitTime -= 1
       
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60

        if second < 10 {
            timer.text = String(minute) + ":" + "0" + String(second)
        } else {
            timer.text = String(minute) + ":" + String(second)
        }
        
        if limitTime != 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        }
        else if limitTime == 0 {
            timer.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}




