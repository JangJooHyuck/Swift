//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import Combine

class ViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = ViewModel()
    
    @Published var MenuList = ["메인","사전","이메일","단어장","타이머"]
    @Published var CurrentCell = 0
    @Published var SideCurrentCell = 0
    
   
    
    
   
    
}

