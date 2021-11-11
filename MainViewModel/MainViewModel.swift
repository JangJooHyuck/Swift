//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import Combine
import CoreData
import UIKit

class MainViewModel {

    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = MainViewModel()
    @Published var word : String = ""
    @Published var wordContents : String = ""
    
    
    @Published var UserWordData: [String] = []
    @Published var UserWordContentsData: [String] = []
    
    lazy var wordlist : [NSManagedObject] = {
        
        return fetch()
        
    }()
   //get data in tableview
    
    func delete(obejct: NSManagedObject) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(obejct)
        
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }

    
    // read Data
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        // sort
        let sort = NSSortDescriptor(key: "word", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
    
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
                                        
                                    }
                                }
                }
            }.resume()
        }
    }
   
    
    
   
    
}

