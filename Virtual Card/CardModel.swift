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
    var cardUserID : String = ""
    var cardPhoneNumber : String = ""
    var cardAddress : String = ""
    var cardEmail : String = ""

    
    init(cardFirstName : String, cardLastName : String, cardJobTitle : String, cardCompany : String, cardUserID : String, cardPhoneNumber : String, cardAddress : String, cardEmail : String) {
        self.cardFirstName = cardFirstName
        self.cardLastName = cardLastName
        self.cardJobTitle = cardJobTitle
        self.cardCompany = cardCompany
        self.cardUserID = "\(cardFirstName)1"
        self.cardPhoneNumber = cardPhoneNumber
        self.cardAddress = cardAddress
        self.cardEmail = cardEmail
    }
    
    init(dataModel : Dictionary<String, AnyObject>) {
        self.cardFirstName = dataModel["cardFirstName"] as! String
        self.cardLastName = dataModel["cardLastName"] as! String
        self.cardJobTitle = dataModel["cardJobTitle"] as! String
        self.cardCompany = dataModel["cardCompany"] as! String
        self.cardUserID = dataModel["cardUserID"] as! String
        self.cardPhoneNumber = dataModel["cardPhoneNumber"] as! String
        self.cardAddress = dataModel["cardAddress"] as! String
        self.cardEmail = dataModel["cardEmail"] as! String
        
    }
    
    init(cardEntity : CardEntity) {
        self.cardFirstName = cardEntity.firstName! as String
        self.cardLastName = cardEntity.lastName! as String
        self.cardCompany = cardEntity.company! as String
        self.cardJobTitle = cardEntity.jobTitle! as String
        self.cardUserID = cardEntity.userID! as String
        self.cardEmail = cardEntity.email! as String
        self.cardPhoneNumber = cardEntity.phoneNumber! as String
        self.cardAddress = cardEntity.address! as String
    }
    
    init(savedEntity : SavedEntity) {
        self.cardFirstName = savedEntity.firstName! as String
        self.cardLastName = savedEntity.lastName! as String
        self.cardCompany = savedEntity.company! as String
        self.cardJobTitle = savedEntity.jobTitle! as String
        self.cardUserID = savedEntity.userID! as String
        self.cardAddress = savedEntity.address! as String
        self.cardPhoneNumber = savedEntity.phoneNumber! as String
        self.cardEmail = savedEntity.email! as String
    }
    
    init(fetchedDictionary : [String : String]) {
        self.cardFirstName = fetchedDictionary["fName"]! as String
        self.cardLastName = fetchedDictionary["sName"]! as String
        self.cardCompany = fetchedDictionary["companyName"]! as String
        self.cardJobTitle = fetchedDictionary["designation"]! as String
        self.cardEmail = fetchedDictionary["email"]! as String
        self.cardAddress = fetchedDictionary["address1"]! as String
        self.cardUserID = fetchedDictionary["userId"]! as String
        self.cardPhoneNumber = fetchedDictionary["phone"]! as String
    }
    
}

func modelToData(cardModel : CardModel) -> NSData? {
    
    let modelDictionary = ["cardFirstName" : cardModel.cardFirstName, "cardLastName" : cardModel.cardLastName, "cardJobTitle" : cardModel.cardJobTitle, "cardCompany" : cardModel.cardCompany, "cardUserID" : cardModel.cardUserID, "cardPhoneNumber" : cardModel.cardPhoneNumber, "cardAddress" : cardModel.cardAddress, "cardEmail" : cardModel.cardEmail]
    
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
