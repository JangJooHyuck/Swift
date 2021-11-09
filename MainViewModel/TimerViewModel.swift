//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import Combine

class TimerViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = TimerViewModel()
    
    // 타이머가 모두 삭제됬는지? (타이머 멈추게 하기위함)
    @Published var isTimerDelete = false
    // 타이머가 돌아간 값이 들어갈 배열
    @Published var timerlist: [Int] = []
    
    @Published var timerlistCount = 0
    
    //유저가 정한 시간
    var UserSetTime: Int = 0
    
    
    func TimeCalculate(){
        
        // 버튼을 눌렀을 때 현재의 Date
        let nowDate = Date()
        
        // 사용자가 입력한 시간을 현재 Date 에 더한다.
        let flowDate = nowDate.addingTimeInterval(TimeInterval(self.UserSetTime))
        
        //현재시간에서 사용자가 입력한 시간까지 남은시간 구하기
        let leftDate = Int(flowDate.timeIntervalSince(nowDate))
        //구한 값을 배열에 추가
        self.timerlist.append(leftDate)
        print("현재시간 : "+"\(nowDate)")
        print("더한시간 : "+"\(flowDate)")
        print("남은시간 : "+"\(leftDate)")
        
    }
    
    func startTimer() {
        
    
        
       
        
        
       
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            //timerlist 가 비어있지 않다면 실행
            if self.timerlist.isEmpty == false {
                    // 배열 전체를 돌면서 -1 해준다.
            for arrayNum in 0..<self.timerlist.count {
                    
                // 값이 0보다 크면 실행
                if self.timerlist[arrayNum] > 0 {
                    
                self.timerlist[arrayNum] -= 1
                    
                }
                else {
                    
                    self.timerlist[arrayNum] = 0
                }
                
                }
            }
           //  타이머 삭제되면 타이머 스탑
            if self.isTimerDelete == true {
           
                timer.invalidate()
           
            }
        
            
            
        }
       
    }
   
    
    // int 값을 시 분 초로 바꿔준다.
    func convertIntToTime (seconds : Int) -> (Int, Int, Int)
    {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}


