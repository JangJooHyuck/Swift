//
//  ViewModel.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/10/27.
//

import Foundation
import CoreData

class NoteViewModel {
    
    // 여러 뷰에서 해당 모델 사용하게하기
    static let VM = NoteViewModel()
    
    @Published var ChangeSort: String = ""
    @Published var sortingHow : Bool = true
    
    func sortList(){
        let request = NoteEntity.fetchRequest() as NSFetchRequest<NoteEntity>
        let sort = NSSortDescriptor(key: "wordDate", ascending: true)
        request.sortDescriptors = [sort]
        
    }
   
}


