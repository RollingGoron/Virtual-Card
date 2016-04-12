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
    
    typealias NetworkCompletionBlock = (([String : AnyObject], String, Bool) -> Void?) // Change from AnyObject to known return type once agreed upon
    
    func sendAPI(apiRequest : NSMutableURLRequest, networkCompletionBlock : NetworkCompletionBlock) {
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithRequest(apiRequest, completionHandler: { (data, response, error) -> Void in
            
            do {
                
                if data == nil {
                    print("An error occured \(error)")
                } else {
                    let responseData = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String : AnyObject]
                    networkCompletionBlock(responseData!, "Success", true)
                }
                
            } catch let error as NSError {
                print(error)
            }
            
        })
        
        dataTask.resume()
        
        
    }
    
    func saveCardToServer(firstName  : String, lastName : String, company : String, jobTitle : String, networkCompletionBlock : NetworkCompletionBlock) -> Void {
        
        let jsonDictionary = ["userId": firstName+"1", "fName" : firstName, "sName" : lastName, "companyName" : company]
        
        
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(jsonDictionary, options: .PrettyPrinted)
            
            let saveRequest = NSMutableURLRequest(URL: NSURL(string: "http://businesscardhackathon.gbsfr7dipy.us-west-2.elasticbeanstalk.com/businessCard")!)
            saveRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            saveRequest.HTTPMethod = "POST"
            saveRequest.HTTPBody = jsonData
            
            sendAPI(saveRequest, networkCompletionBlock: { (returnedObject, returnedString, returnedBool) -> Void? in
                networkCompletionBlock(returnedObject, returnedString, returnedBool)
            })
            
        } catch let error as NSError {
            print("Error converting JSON \(error)")
        }
        
    }
    
    func fetchAllCardsForAccount(networkCompletionBlock : NetworkCompletionBlock) {
        
        do {
            let fetchRequest = NSMutableURLRequest(URL: NSURL(string: "http://businesscardhackathon.gbsfr7dipy.us-west-2.elasticbeanstalk.com/businessCard")!)
            fetchRequest.HTTPMethod = "GET"
            sendAPI(fetchRequest, networkCompletionBlock: { (returnedObject, returnedString, returnedBool) -> Void? in
                networkCompletionBlock(returnedObject, returnedString, returnedBool)
            })
            
        }
    }
    
}
