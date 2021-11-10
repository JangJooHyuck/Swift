//
//  WordNote+CoreDataProperties.swift
//  SwiftApp
//
//  Created by 장주혁 on 2021/11/10.
//
//

import Foundation
import CoreData


extension WordNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordNote> {
        return NSFetchRequest<WordNote>(entityName: "WordNote")
    }

    @NSManaged public var word: String?
    @NSManaged public var wordcontents: String?

}

extension WordNote : Identifiable {

}
