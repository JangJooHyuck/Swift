//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import Combine

class DicViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = DicViewModel()
    @Published var UserWord : String = ""
    @Published var UserWordContents : String = ""
    
    // 오늘의 단어
    @objc func Findword() {
        
        //urlString에 vs에서 만든 api를 호출하고 wordTextField의 텍스트를 붙인다.
        let urlString = "http://localhost:1233/api/dictionary?word=" + UserWord
        //url 주소에 한글이 들어가면 인식을 못하기 때문에 addingPercentEncoding으로 변환함
        let encoding = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        if let urlpath = URL(string: encoding) {
            
            var request = URLRequest.init(url: urlpath)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request){ (data, response, error) in
                guard let data = data
                else
                {
                    return
        
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                                    
                    //word 가져오기
                    if let content = json["content"] as? String{
                                    
                                    DispatchQueue.main.async {
                                        
                                        self.UserWordContents = content
                                       
                                    }
                                }
                    // content 가져오기
                        }

            }.resume()
        }
    }
   
    
}

