//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import Combine

class MainViewModel {

    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = MainViewModel()
    @Published var word : String = ""
    @Published var wordContents : String = ""
    
    // 오늘의 단어
    func Todayword() {
        //https://qteveryday.tistory.com/233 참고
        
        //visual studio 에서 만든 api 를 불러온다
        if let url = URL(string: "http://localhost:1233/api/randomword") {
            var request = URLRequest.init(url: url)
            request.httpMethod = "GET"
            
            // URLSession 객체를 통해 전송, 응답값 처리
            URLSession.shared.dataTask(with: request){ (data, response, error) in
                guard let data = data else {return}
                
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                                    
                    //json 타입에서 word 의 value 를 가져온다.
                                if let word = json["word"] as? String{
                                    
                                    DispatchQueue.main.async {
                                        self.word = word
                                        
                                    }
                                }
                    // content 가져오기
                                if let content = json["content"] as? String{
                                    
                                    DispatchQueue.main.async {
                                        // TodayWordcontentLabel에 text를 content 로 바꿈
                                        self.wordContents = content
                                        
                                        
                                        // 콘텐츠의 길이가 길면 ... 으로 표시하는걸 막기위해 최대 5줄까지 확장가능하게함
                                      //  self.TodayWordContentLabel.numberOfLines = 5
                                        
                                    }
                                }
                }
            }.resume()
        }
    }
   
    
    
   
    
}

