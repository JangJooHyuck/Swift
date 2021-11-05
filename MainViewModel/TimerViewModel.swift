//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import UIKit
import Combine

class TimerViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = TimerViewModel()
    
    // 타이머가 모두 삭제됬는지? (타이머 멈추게 하기위함)
    @Published var isTimerDelete = false
    // 타이머가 돌아간 값이 들어갈 배열
    @Published var timerlist = []
    
    
}


