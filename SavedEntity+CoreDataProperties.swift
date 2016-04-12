//
//  SavedEntity+CoreDataProperties.swift
//  Virtual Card
//
//  Created by Peter Gosling on 4/12/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SavedEntity {

    @NSManaged var company: String?
    @NSManaged var firstName: String?
    @NSManaged var jobTitle: String?
    @NSManaged var lastName: String?
    @NSManaged var userID: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var email: String?
    @NSManaged var address: String?

}
