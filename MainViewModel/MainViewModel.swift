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

    @Published var wordlist : [NSManagedObject] = {
        fetch()
    }()
   
   
    
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
     static func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        // sort// 정렬기준
        let sort = NSSortDescriptor(key: "wordDate", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
   
    
    func save(word: String, wordcontents: String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate!.persistentContainer.viewContext
        let object = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context)
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        let predicate = NSPredicate(format: "word = %@", word)
        fetchRequest.predicate = predicate
        
        // 영구 저장소에 commit후에 list프로퍼티에 추가
        do {
            let result = try context.fetch(fetchRequest)
            if result.count > 0 {
                //데이터에 이미 존재하네..그러면 리턴 false
                print("데이터에 이미 존재 Return False")
                
                return false
            } else {
//                //데이터에 값이 없으니 저장하자
                object.setValue(word, forKey: "word")
                object.setValue(wordcontents, forKey: "wordcontents")
                object.setValue(Date(), forKey: "wordDate")
                // 클릭 카운트
                object.setValue(0, forKey: "wordcc")
                self.wordlist.insert(object, at: 0)
                try context.save()
                return true
            }
            
        } catch {
          
            print ("Error")
            return false
        }
        
       
    }
    
    func update(object: NSManagedObject, word: String, contents: String)  -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        object.setValue(word, forKey: "word")
        object.setValue(contents, forKey: "wordcontents")
        object.setValue(Date(), forKey: "wordDate")
        
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
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

