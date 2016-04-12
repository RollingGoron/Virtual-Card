//
//  CardReviewController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/27/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

protocol TaskCompletedProtocol:class
{
  func saveButtonClicked()
}

class CardReviewController: UIViewController {
  
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var jobTitleLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBOutlet weak var bgView: UIView!
  
  weak var delegate: TaskCompletedProtocol?
  
  var cardModel : CardModel!
  var cardSaved: Bool!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Title"
    
    saveButton.layer.cornerRadius = 5
    bgView.layer.cornerRadius = 5
    bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
    bgView.layer.borderWidth = 1
    
    let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelClicked")
    navigationItem.leftBarButtonItem = cancelButton
    
    let aStr = String(format: "%@ %@", cardModel.cardFirstName,cardModel.cardLastName)
    firstNameLabel.text = aStr
    jobTitleLabel.text = cardModel.cardJobTitle
    companyLabel.text = cardModel.cardCompany
    firstNameLabel.text = cardModel.cardFirstName

  }
  
  func cancelClicked(){
    dismissViewControllerAnimated(true) { () -> Void in
      
    };
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
//  
//  @IBAction func dismissController(sender: AnyObject) {
//    let isSaved = CoreDataManager.saveMyCardToCoreData(self.cardModel)! as Bool
//    
//    if isSaved {
//      self.delegate!.saveButtonClicked()
//      dismissViewControllerAnimated(false) { () -> Void in
//      }
//    }
//    
//  
//  }

  
  @IBAction func dismissController(sender: AnyObject) {

    
    if self.parentViewController?.title != "Send Business Card" {
      CoreDataManager.saveReceivedCardToCoreData(self.cardModel)
      dismissViewControllerAnimated(false) { () -> Void in
      }

      self.navigationController?.popViewControllerAnimated(true)
    } else {
      CoreDataManager.saveMyCardToCoreData(self.cardModel)
      NetworkManager.sharedInstance.saveCardToServer(self.cardModel.cardFirstName, lastName: self.cardModel.cardLastName, company: self.cardModel.cardCompany, jobTitle: self.cardModel.cardJobTitle, networkCompletionBlock: { (returnedObject, returnedString, returnedBool ) -> Void in
        self.navigationController?.popToRootViewControllerAnimated(true)
        print("Returned Data: \(returnedObject) with response \(returnedString), and bool \(returnedBool)")
      })
    }
    
    
  }
}