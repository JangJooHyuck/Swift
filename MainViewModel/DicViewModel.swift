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

class DicViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = DicViewModel()
    @Published var UserWord : String = ""
    @Published var UserWordContents : String = ""
    
        var container: NSPersistentContainer!
  
    func CoreData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        
       // let entity = NSEntityDescription.entity(forEntityName: "WordNote", in: self.container.viewContext)
        
     //   let word = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        
      //  word.setValue("Pingu", forKey: "word")
      //  word.setValue("010-0000-0000", forKey: "wordcontents")
        
//        do {
//            try self.container.viewContext.save()
//        } catch {
//            print(error.localizedDescription)
//        }
        
    }
    func fetch() {
        
        do {
            let contact = try self.container.viewContext.fetch(WordNote.fetchRequest()) as! [WordNote]
            
            contact.forEach {
                print($0.word)
                print($0.wordcontents)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
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

