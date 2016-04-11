//
//  NetworkManager.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/22/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
  
  static let sharedInstance = NetworkManager()
  
  typealias NetworkCompletionBlock = ((AnyObject, String, Bool) -> Void?) // Change from AnyObject to known return type once agreed upon
  
  func sendAPI(apiRequest : NSURLRequest, networkCompletionBlock : NetworkCompletionBlock) {
    
  }
  
//  func saveCardToServer() -> NSURLRequest {
//    
//  }
//  
//  func fetchAllCardsForAccount() -> NSURLRequest {
//    
//  }

}
