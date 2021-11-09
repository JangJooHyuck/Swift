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
    @Published var timeSet = 0
    @Published var timerlistCount = 0
    
    
    func startTimer() {
        
        
//        // 시간 포맷
//        let nowDate = Date() // 버튼을 눌렀을 때 현재의 Date (ex: 2000-01-01 09:14:48 +0000)
//        let dateFormatter = DateFormatter()
//        // 데이터 포맷
//        dateFormatter.dateFormat = "a hh시 mm분 ss초"
//        // PM, AM 을 오전, 오후로 변경
//        dateFormatter.locale =  Locale(identifier: "ko_KR")
//        // 현재 시간의 Date를 format에 맞춰 string으로 반환
//        let str = dateFormatter.string(from: nowDate)
        
        
       
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
            
            
//            if TimerViewModel.VM.timerlist.isEmpty == false {
//
//                if self.timeSet == 0 {
//                    print("시간이 입력되지 않았음")
//                }
//                else{
//            // 시간세팅해논거에서 -1 하고.
//                    self.timeSet -= 1
//                    print("\(self.timeSet)")
//            // 현재 시간값을 시분초로 바꿔준 값을 h, m, s 에 저장한다
//                    let (h, m, s) = self.convertIntToTime(seconds: self.timeSet)
//
//            // 배열 값을 변경
//                    self.timerlist[self.timerlist.count - 1] = String("\(h) 시간 " + "\(m) 분 " + "\(s) 초")
//            }
//        }
//            //타이머가 0이되면
//            if self.timeSet <= 0 {
//                //타이머스탑하고
//                timer.invalidate()
//                self.timerlist[self.timerlist.count - 1] = ("[시간 종료]" + " 종료시간 : " + "\(str)" )
//            }
            
//            // 타이머 삭제되면 타이머 스탑
//            if self.isTimerDelete == true {
//
//                timer.invalidate()
//
//            }
        
        
        //addTimer end
    
    
    // int 값을 시 분 초로 바꿔준다.
    func convertIntToTime (seconds : Int) -> (Int, Int, Int)
    {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}


