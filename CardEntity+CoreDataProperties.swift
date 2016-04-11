//
//  CardEntity+CoreDataProperties.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/25/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CardEntity {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var company: String?
    @NSManaged var jobTitle: String?

}
