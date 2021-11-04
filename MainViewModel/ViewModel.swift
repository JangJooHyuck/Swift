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
   
    // 타이머가 모두 삭제됬는지? (타이머 멈추게 하기위함)
    @Published var isTimerDelete = false
   
 
    
    @Published var timerlist = []
    
    
}

