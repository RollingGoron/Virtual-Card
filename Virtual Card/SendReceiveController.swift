//
//  SendReceiveController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/25/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class SendReceiveController: UIViewController {
  
  @IBOutlet weak var statusLabel: UILabel!
  
  @IBOutlet weak var sendDataButton: UIButton!
  
  let communicationManager = CommunicationManager()
  
  override func viewDidLoad() {
    self.title = "Send Business Card"
    self.navigationController!.navigationBar.topItem!.title = ""
    communicationManager.delegate = self
    
    statusLabel.text = "Searching for Devices..."
    communicationManager.startDeviceScan()
    
    
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
  
  func connectionStatus(status: String) {
    dispatch_async(dispatch_get_main_queue(), {
      self.statusLabel.text = status
    })
  }
  
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