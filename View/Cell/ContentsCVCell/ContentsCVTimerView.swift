//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import Combine

class ContentsCVTimerView:UICollectionViewCell, UITableViewDataSource, UITableViewDelegate{
    
    let hourTextField = UITextField()
    
    let minTextField = UITextField()
   
    let secTextField = UITextField()
   
  
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
        
     
        //사용자 시간설정 텍스트필드
        self.addSubview(hourTextField)
        self.addSubview(minTextField)
        self.addSubview(secTextField)
        
        //테이블뷰 밑 시작,삭제버튼
        self.addSubview(self.myTableView)
        self.addSubview(startTimerBT)
        self.addSubview(removeTimerBT)
      
        
        self.hourTextField.translatesAutoresizingMaskIntoConstraints = false
        self.minTextField.translatesAutoresizingMaskIntoConstraints = false
        self.secTextField.translatesAutoresizingMaskIntoConstraints = false
        
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
        TableViewReload()
        //사용자 시간설정 (시간, 분, 초)
        timeSetTextFieldLayout()
       
        //VM 초기화
        ViewModel.VM.timerlist.removeAll()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ViewModel.VM.timerlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = ViewModel.VM.timerlist[indexPath.row] as? String
        
     
        return cell
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
    
    func timeSetTextFieldLayout(){
    
        
        hourTextField.placeholder = "시간"
        hourTextField.textAlignment = .center
        hourTextField.font = UIFont.systemFont(ofSize: 20)
        hourTextField.backgroundColor = UIColor(red: 102/255, green: 240/255, blue: 10/255, alpha: 0.5)
        hourTextField.borderStyle = UITextField.BorderStyle.roundedRect
        hourTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        hourTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        hourTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        hourTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        
        
        minTextField.placeholder = "분"
        minTextField.textAlignment = .center
        minTextField.font = UIFont.systemFont(ofSize: 20)
        minTextField.backgroundColor = UIColor(red: 102/255, green: 240/255, blue: 10/255, alpha: 0.5)
        minTextField.borderStyle = UITextField.BorderStyle.roundedRect
        minTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        minTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        minTextField.topAnchor.constraint(equalTo: hourTextField.topAnchor, constant: 0).isActive = true
        minTextField.leadingAnchor.constraint(equalTo: hourTextField.leadingAnchor, constant: 120).isActive = true
        
        
        secTextField.placeholder = "초"
        secTextField.textAlignment = .center
        secTextField.font = UIFont.systemFont(ofSize: 20)
        secTextField.backgroundColor = UIColor(red: 102/255, green: 240/255, blue: 10/255, alpha: 0.5)
        secTextField.borderStyle = UITextField.BorderStyle.roundedRect
        secTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        secTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        secTextField.topAnchor.constraint(equalTo: hourTextField.topAnchor, constant: 0).isActive = true
        secTextField.leadingAnchor.constraint(equalTo: minTextField.leadingAnchor, constant: 120).isActive = true
        
    }
  
        
    //0.5초마다 테이블뷰 새로고침
    func TableViewReload() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            
            self.myTableView.reloadData()
            
        }
    }

    
    @objc func addTimer(sender: UIButton!)
    {
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        ViewModel.VM.isTimerDelete = false
        
      
// 타이머 시작시간
//        // 시간 포맷
//        let nowDate = Date() // 버튼을 눌렀을 때 현재의 Date (ex: 2000-01-01 09:14:48 +0000)
//        let dateFormatter = DateFormatter()
//
//        // 데이터 포맷
//        dateFormatter.dateFormat = "a hh시mm분ss초"
//        // PM, AM 을 오전, 오후로 변경
//        dateFormatter.locale =  Locale(identifier: "ko_KR")
//        // 현재 시간의 Date를 format에 맞춰 string으로 반환
//        let str = dateFormatter.string(from: nowDate)
//
//        // 타이머 시작버튼 누르면 isTimerDelete 를 다시 false 로 초기화
//        ContentsCVTimerView.isTimerDelete = false
        
        // 타이머
        
        //사용자가 입력한 시간을 가져오자
        let sec : String = secTextField.text!
        let min = self.minTextField.text
        let hour = self.minTextField.text
        
        var timeSet = 3
        let nowcell = ViewModel.VM.timerlist.count
        print(nowcell)
        
        ViewModel.VM.timerlist.append("\(timeSet)")
        print(ViewModel.VM.timerlist)
        self.myTableView.reloadData()
       
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            
            if ViewModel.VM.timerlist.isEmpty == false {
            timeSet -= 1
            
            
            ViewModel.VM.timerlist[nowcell] = (String(timeSet))
               
                }
            //타이머가 0이되면
            if timeSet == 0 {
                //타이머스탑하고
                timer.invalidate()
                ViewModel.VM.timerlist[nowcell] = ("시간 종료")
            }
            
            // 타이머 삭제되면 타이머 스탑
            if ViewModel.VM.isTimerDelete == true {

                timer.invalidate()

            }

        }

    

        
        
        // 테이블뷰에 타이머시작시간 추가.
       // ViewModel.VM.timerlist.append("[" + String(ViewModel.VM.TimerNum) + "]" + " 시작시간 : " + "\(str)" + ". 타이머: " + "\(time))")
        
    }
    
    

    
    // 모두 삭제버튼 액션
    @objc func deleteTimer(sender: UIButton!){
        // 버튼 클릭시 애니메이션 설정
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.white.cgColor
        colorAnimation.duration = 1  // animation duration
        sender.layer.add(colorAnimation, forKey: "ColorPulse")
        
        
        // vm 초기화
        ViewModel.VM.isTimerDelete = true
        
        ViewModel.VM.timerlist.removeAll()
        self.myTableView.reloadData()
    
    }
   
  
   
}




