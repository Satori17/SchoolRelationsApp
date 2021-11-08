//
//  Pupil+CoreDataProperties.swift
//  SchoolRelationsApp
//
//  Created by Saba Khitaridze on 05.11.21.
//
//

import Foundation
import CoreData


extension Pupil {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pupil> {
        return NSFetchRequest<Pupil>(entityName: "Pupil")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var gender: String?
    @NSManaged public var classYear: String?
    @NSManaged public var teachers: NSSet?

}

// MARK: Generated accessors for teachers
extension Pupil {

    @objc(addTeachersObject:)
    @NSManaged public func addToTeachers(_ value: Teacher)

    @objc(removeTeachersObject:)
    @NSManaged public func removeFromTeachers(_ value: Teacher)

    @objc(addTeachers:)
    @NSManaged public func addToTeachers(_ values: NSSet)

    @objc(removeTeachers:)
    @NSManaged public func removeFromTeachers(_ values: NSSet)

}

extension Pupil : Identifiable {

}
