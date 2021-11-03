//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import UIKit
import Combine

class ViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = ViewModel()
    
    @Published var MenuList = ["메인","사전","이메일","단어장","타이머"]
    @Published var CurrentCell = 0
    @Published var SideCurrentCell = 0
   
    
    // 사이드메뉴 하이라이트
    @Published var didSideMenuHighright = false
    //타이머 시간
    @Published var time = 300
    
    @Published var timerlist = []
    
    
//    func timeService() {
//        
//        // 1초마다 타임을 1씩 빼준다.
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            
//            self.time -= 1
//            print("\(self.time)")
//            
//            
//            // 타이머 멈추면 스탑
//            if ContentsCVTimerView.isTimerDelete == true {
//                
//                timer.invalidate()
//                
//            }
//            
//        }
//        
//    }
//   
    
}

