//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import CoreData
import UIKit

class NoteViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = NoteViewModel()
    
    @Published var sortingHow : Bool = true
    
    func update(object: NSManagedObject, Click: Int) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        object.setValue(Click, forKey: "wordcc")
        do {
            try context.save()
            return true
        } catch {
            
            return false
        }
    }
//    // 같은라인에 텍스트 정렬방식
//    func alignLeftAndRight(left: String, right: String, length: Int) -> String {
//        // calculate how many spaces are needed
//        let numberOfSpacesToAdd = length - left.count - right.count
//
//        // create those spaces
//        let spaces = Array(repeating: " ", count: numberOfSpacesToAdd < 0 ? 0 : numberOfSpacesToAdd).joined()
//
//        // join these three things together
//        return left + spaces + right
//    }
   
}


