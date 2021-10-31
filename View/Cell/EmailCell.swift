//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import WebKit

class EmailCell:UICollectionViewCell{

  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 웹뷰 추가
        let EmailWebview = WKWebView()
       
        // url 설정
        let url = URL(string: "http://localhost:1233/main")
        // 응답을 저장
        let request = URLRequest(url: url!)
        // request 가져오기
        EmailWebview.load(request)
        self.addSubview(EmailWebview)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}




