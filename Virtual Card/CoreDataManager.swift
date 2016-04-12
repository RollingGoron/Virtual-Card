//
//  CoreDataManager.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/22/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
  
  class func saveReceivedCardToCoreData(cardModel : CardModel) {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = appDelegate.managedObjectContext
    let entity =  NSEntityDescription.entityForName("SavedEntity", inManagedObjectContext: managedObjectContext)
    let cardEntity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! SavedEntity
    
    
    cardEntity.firstName = cardModel.cardFirstName
    cardEntity.lastName = cardModel.cardLastName
    cardEntity.company = cardModel.cardCompany
    cardEntity.jobTitle = cardModel.cardJobTitle
    cardEntity.email = cardModel.cardEmail
    cardEntity.address = cardModel.cardAddress
    cardEntity.userID = cardModel.cardUserID
    cardEntity.phoneNumber = cardModel.cardPhoneNumber
    
    do {
      try managedObjectContext.save()
      print("Saved card info!")
    } catch let error as NSError {
      print("An error occured when saving \(error)")
    }
    
  }
  
  class func saveMyCardToCoreData(cardModel : CardModel) -> Bool? {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = appDelegate.managedObjectContext
    let entity =  NSEntityDescription.entityForName("CardEntity", inManagedObjectContext: managedObjectContext)
    let cardEntity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext) as! CardEntity
    
    
    cardEntity.firstName = cardModel.cardFirstName
    cardEntity.lastName = cardModel.cardLastName
    cardEntity.company = cardModel.cardCompany
    cardEntity.jobTitle = cardModel.cardJobTitle
    cardEntity.email = cardModel.cardEmail
    cardEntity.address = cardModel.cardAddress
    cardEntity.userID = cardModel.cardUserID
    cardEntity.phoneNumber = cardModel.cardPhoneNumber
    
    do {
      try managedObjectContext.save()
      print("Saved card info!")
      return true
    } catch let error as NSError {
      print("An error occured when saving \(error)")
    }
    return false
  }
  
  class func returnMyBusinessCard() -> CardModel? {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "CardEntity")
    
    do {
      let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest)
      
      if fetchResults.count == 0 {
        return nil
      }
      
      let savedCard = fetchResults as! [CardEntity]
      
      let myCard = savedCard[0]
      let cardModel = CardModel(cardEntity: myCard)
      print("Returned Card Data")
      return cardModel
      
    } catch {
      print("Error fetching saved card!")
      return nil
    }
    
  }
  
  class func returnAllSavedCards()-> NSMutableArray {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "SavedEntity")
    
    let returnedArray : NSMutableArray = []
    
    do {
      let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest)
      let savedCards = fetchResults as NSArray
      returnedArray.addObjectsFromArray(savedCards as! [SavedEntity])
      return returnedArray
      
    } catch {
      print("Error fetching saved card!")
      return NSMutableArray()
    }
  }
  
  class func removeSavedItemFromCoreData(savedEntity : SavedEntity) {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext = appDelegate.managedObjectContext
    managedObjectContext.deleteObject(savedEntity)
    do {
      try managedObjectContext.save()
    } catch let error as NSError {
      "An error occured when deleting: \(error)"
    }
    
    
    
  }
  
}
