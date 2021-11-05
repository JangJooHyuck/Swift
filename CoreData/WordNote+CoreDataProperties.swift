//
//  WordNote+CoreDataProperties.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/11/05.
//
//

import Foundation
import CoreData


extension WordNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordNote> {
        return NSFetchRequest<WordNote>(entityName: "WordNote")
    }

    @NSManaged public var wordcontents: String?
    @NSManaged public var word: String?

}

extension WordNote : Identifiable {

}
