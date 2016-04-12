//
//  SendReceiveController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/25/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class SendReceiveController: UIViewController {
  
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var acitivtyMonitor: UIActivityIndicatorView!
  @IBOutlet weak var sendDataButton: UIButton!
  
  let communicationManager = CommunicationManager()
  
  override func viewDidLoad() {
    self.title = "Send Business Card"
    self.navigationController!.navigationBar.topItem!.title = ""
    communicationManager.delegate = self
    acitivtyMonitor.color = UIColor.darkGrayColor()
    acitivtyMonitor.hidesWhenStopped = true
    acitivtyMonitor.startAnimating()
    statusLabel.text = "Searching for Devices..."
    self.sendDataButton.hidden = true
    communicationManager.startDeviceScan()
    self.view.backgroundColor = UIColor(red: (249.0/255.0), green: (248.0/255.0), blue: (249.0/255.0), alpha: 1.0)
    
  }
  
  override func viewWillDisappear(animated: Bool) {
    communicationManager.stopDeviceScan()
  }
  
  @IBAction func sendBusinessCard(sender: AnyObject) {
    
    let cardData = modelToData(CoreDataManager.returnMyBusinessCard()!)
    
    do {
      try communicationManager.session.sendData(cardData!, toPeers: communicationManager.session.connectedPeers, withMode: .Reliable)
    } catch {
      print("Error Sending Data!")
    }
    
  }
  
}

extension SendReceiveController : CommunicationManagerDelegate {
  
  
  func connectionStatus(state : MCSessionState) {
    
    dispatch_async(dispatch_get_main_queue(), {
      if state == .NotConnected {
        self.acitivtyMonitor.startAnimating()
        self.statusLabel.text =  "An error occured \n Please try again!"
        self.sendDataButton.hidden = true     
      } else if state == .Connected {
        
        self.statusLabel.text = "Connected!"
        self.acitivtyMonitor.stopAnimating()
        self.sendDataButton.hidden = false
        
      } else if state == .Connecting {
        
        self.statusLabel.text = "Found New Device..."
        
      } else {
        
        self.statusLabel.text = "An Error Occured"
      }
    })
  }
  //
  //  func connectionStatus(status: String) {
  //    dispatch_async(dispatch_get_main_queue(), {
  //
  //      extension MCSessionState {
  //        func returnString() -> String {
  //          if self == .NotConnected {
  //            return "Not connected!"
  //          } else if self == .Connected {
  //            return "Connected!"
  //          } else if self == .Connecting {
  //            return "Connecting to peer..."
  //          } else {
  //            return "An Error Occured"
  //          }
  //        }
  //      }
  //      self.statusLabel.text = status
  //
  //    })
  //  }
  
  func didReceiveCardData(cardModel: CardModel) {
    //Check if card is already saved.
    //Upload to server
    //    if ((CoreDataManager.returnAllSavedCards()?.contains(cardModel)) != nil) {
    //      print("Card already saved")
    //      let alertController = UIAlertController(title: "Error!", message: "Card is already saved!", preferredStyle: .Alert)
    //      self.presentViewController(alertController, animated: true, completion: nil)
    //    } else {
    
    dispatch_async(dispatch_get_main_queue(), {
      let cardReviewController = self.storyboard!.instantiateViewControllerWithIdentifier("CardReviewController") as! CardReviewController
      cardReviewController.cardModel = cardModel
      cardReviewController.buttonText = "Save Recevied Card"
      self.navigationController?.pushViewController(cardReviewController, animated: true)
    })
    //}
    
  }
  
}
