//
//  CardModel.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/22/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import Foundation

struct CardModel : Equatable {
  var cardFirstName : String = ""
  var cardLastName : String = ""
  var cardJobTitle : String = ""
  var cardCompany : String = ""
  
  init(cardFirstName : String, cardLastName : String, cardJobTitle : String, cardCompany : String) {
    self.cardFirstName = cardFirstName
    self.cardLastName = cardLastName
    self.cardJobTitle = cardJobTitle
    self.cardCompany = cardCompany
  }
  
  init(dataModel : Dictionary<String, AnyObject>) {
    self.cardFirstName = dataModel["cardFirstName"] as! String
    self.cardLastName = dataModel["cardLastName"] as! String
    self.cardJobTitle = dataModel["cardJobTitle"] as! String
    self.cardCompany = dataModel["cardCompany"] as! String
    
  }
  
  init(cardEntity : CardEntity) {
    self.cardFirstName = cardEntity.firstName! as String
    self.cardLastName = cardEntity.lastName! as String
    self.cardCompany = cardEntity.company! as String
    self.cardJobTitle = cardEntity.jobTitle! as String
  }
  
  init(savedEntity : SavedEntity) {
    self.cardFirstName = savedEntity.firstName! as String
    self.cardLastName = savedEntity.lastName! as String
    self.cardCompany = savedEntity.company! as String
    self.cardJobTitle = savedEntity.jobTitle! as String
  }
  
}

func modelToData(cardModel : CardModel) -> NSData? {
  
  let modelDictionary = ["cardFirstName" : cardModel.cardFirstName, "cardLastName" : cardModel.cardLastName, "cardJobTitle" : cardModel.cardJobTitle, "cardCompany" : cardModel.cardCompany]
  
  do {
    
    let modelData : NSData = try NSJSONSerialization.dataWithJSONObject(modelDictionary, options: .PrettyPrinted)
    return modelData
    
  } catch {
    print("An error occured converting data")
    return nil
  }
}

func == (lhs : CardModel, rhs : CardModel) -> Bool {
  
  if lhs.cardCompany == rhs.cardCompany && lhs.cardFirstName == rhs.cardFirstName && lhs.cardLastName == rhs.cardLastName && lhs.cardJobTitle == rhs.cardJobTitle {
    return true
  } else {
    return false
  }
  
}
