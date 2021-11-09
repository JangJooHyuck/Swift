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

    var isTimerRun:Bool = false
    var backUpTableCount: Int = 0
    
    var isInsertTime:Bool = false
    
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
        
        self.myTableView.register(ContentCVTimerViewTableCell.self, forCellReuseIdentifier: "cell")
        
        
        // 텍스트필드 클릭 이벤트
        hourText.addTarget(self, action: #selector(touchTextField), for: UIControl.Event.touchDown)
        minText.addTarget(self, action: #selector(touchTextField), for: UIControl.Event.touchDown)
        secText.addTarget(self, action: #selector(touchTextField), for: UIControl.Event.touchDown)
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
        
        //데이터 바인딩하기
        TimerCellDataBinding()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //셀의 갯수는 vm 의 timerlist 배열에 요소 갯수만큼
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //테이블 사이즈 저장
        
        self.backUpTableCount = TimerViewModel.VM.timerlist.count
        return TimerViewModel.VM.timerlist.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell: ContentCVTimerViewTableCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContentCVTimerViewTableCell
        
        let (h, m, s) = TimerViewModel.VM.convertIntToTime(seconds: TimerViewModel.VM.timerlist[indexPath.row])
        
        cell.lbl.text = String("\(h) 시간 " + "\(m) 분 " + "\(s) 초")
        
        if TimerViewModel.VM.timerlist[indexPath.row] == 0 {
            cell.lbl.text = "[시간종료]"
        }

        return cell
        
}
   
    //delete cell to swipe
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
        if editingStyle == .delete {

            TimerViewModel.VM.timerlist.remove(at: indexPath.row)
            self.myTableView.deleteRows(at: [indexPath], with: .fade)
            
            TimerViewModel.VM.timerlistCount -= 1
            
            
            }
    }
 
    // 텍스트 필드 클릭시
    @objc func touchTextField(){
        self.hourText.layer.borderWidth = 1
        self.minText.layer.borderWidth = 1
        self.secText.layer.borderWidth = 1
        self.hourText.layer.borderColor = UIColor.black.cgColor
        self.minText.layer.borderColor = UIColor.black.cgColor
        self.secText.layer.borderColor = UIColor.black.cgColor
    }
    
    func TimerCellDataBinding(){
        
        TimerViewModel.VM.$timerlist.sink { value in
            
            if self.backUpTableCount != value.count {
                self.myTableView.reloadData()
            } else {
                //각각 아이템..
                for (idx, item) in value.enumerated() {
                    let indexPath:IndexPath = IndexPath(row: idx, section: 0)
                    
                    let cell:ContentCVTimerViewTableCell = self.myTableView.cellForRow(at: indexPath) as! ContentCVTimerViewTableCell
                    
                    let (h, m, s) = TimerViewModel.VM.convertIntToTime(seconds: item)
                    
                    cell.lbl.text = String("\(h) 시간 " + "\(m) 분 " + "\(s) 초")
                    if item == 0 {
                        cell.lbl.text = "[시간종료]"
                    }
                   
                }
                
            }

        }.store(in: &cancellable)
        
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
        secText.leadingAnchor.constraint(equalTo: hourText.leadingAnchor, constant: 257).isActive = true
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
    
    
     
        
    //vm 배열의 갯수가 바뀔때마다 호출
    func tableViewReload(){
        TimerViewModel.VM.$timerlistCount.sink { value in
            
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
        
        // 타이머
        let userSec = Int(secText.text!) ?? 0
        let userMin = Int(minText.text!) ?? 0
        let userHour = Int(hourText.text!) ?? 0
        
        // (사용자가 시간을 입력 하였을 때)
        if secText.text?.isEmpty == false || minText.text?.isEmpty == false || hourText.text?.isEmpty == false
        {
            // 사용자가 값을 입력헀다고 전달
            self.isInsertTime = true
        }
        // (사용자가 시간을 입력하지 않았을 때)
        else {
            // shake 애니메이션
            UIView.animate(withDuration: 0.05, animations: {
                self.hourText.transform = self.hourText.transform.rotated(by: CGFloat.pi / -0.52)
                self.minText.transform = self.minText.transform.rotated(by: CGFloat.pi / 0.52)
                self.secText.transform = self.secText.transform.rotated(by: CGFloat.pi / -0.52)

                self.hourText.layer.borderColor = UIColor.red.cgColor
                self.minText.layer.borderColor = UIColor.red.cgColor
                self.secText.layer.borderColor = UIColor.red.cgColor
                self.hourText.layer.borderWidth = 2
                self.minText.layer.borderWidth = 2
                self.secText.layer.borderWidth = 2
                
                
            })
            UIView.animate(withDuration: 0.3, animations: {
                
                self.hourText.transform = self.hourText.transform.rotated(by: CGFloat.pi / 0.52)
                self.minText.transform = self.minText.transform.rotated(by: CGFloat.pi / -0.52)
                self.secText.transform = self.secText.transform.rotated(by: CGFloat.pi / 0.52)

                
            })
          
            self.isInsertTime = false
           
        }
        
        // 사용자가 시간을 입력했을 때만 타이머 실행
        if self.isInsertTime == true {
       
        // 타이머가 삭제됬을때 isTimerdelete 가 true 로 바뀌었으므로 다시 타이머가 돌아갈 때 초기화 시켜줌
        TimerViewModel.VM.isTimerDelete = false
        // 뷰모델에 배열에 사용자가 입력한 시간 전달
        TimerViewModel.VM.timerlist.append(Int(userSec + (userMin * 60 ) + (userHour * 3600)))
        
       // print("\(TimerViewModel.VM.timerlist)")
        
        //배열 갯수 하나 추가 전달
        TimerViewModel.VM.timerlistCount += 1
        // 만약 isTimerRun 이 false 면,
        if isTimerRun == false {
            // VM startTimer 실행
        TimerViewModel.VM.startTimer()
            // isTimerRun 을 true 로 바꿔준다
            isTimerRun = true
            }
        
        }
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
//
        self.isTimerRun = false
        TimerViewModel.VM.isTimerDelete = true
        // vm 배열에 모든 요소들을 삭제하고,
        TimerViewModel.VM.timerlist.removeAll()
        // 타이머리스트의 카운트를 0 으로 바꾼다
        TimerViewModel.VM.timerlistCount = 0
  
    }
   
  
   
}




