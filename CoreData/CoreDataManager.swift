//
//  Coredata.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/11/10.
//
import UIKit
import CoreData


class CoreDataManager {
    static let shared : CoreDataManager = CoreDataManager()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "WordNote"
    
    
    
    func saveWord(word: String, wordcontents: String, completion: (Bool) -> Void) {
        guard let context = self.context,
              let entity = NSEntityDescription.entity(forEntityName: WordNote.rawValue, in: context)
        else { return }
        
        guard let Note = NSManagedObject(entity: entity, insertInto: context) as? WordNote else { return }
        
        Note.word = word
        Note.wordcontents = wordcontents
        
        do {
            try context.save()
            completion(true)
        } catch {
            print(error.localizedDescription)
            completion(false)
        }
    }
    
    // MARK: - 저장된 모든 정보를 가져온다
    
    func loadFromCoreData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        guard let context = self.context else { return [] }
        do {
            let results = try context.fetch(request)
            return results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}


