//
//  topMenuCell.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import UIKit
import WebKit

class EmailCell:UICollectionViewCell, WKUIDelegate{

  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 웹뷰 추가
        let EmailWebview = WKWebView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height))
        
        
        EmailWebview.uiDelegate = self
        self.addSubview(EmailWebview)
        
        // url 설정
        let url = URL(string: "http://localhost:1233/main")
        // 응답을 저장
        let request = URLRequest(url: url!)
        // request 가져오기
        EmailWebview.load(request)
        
        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
}




