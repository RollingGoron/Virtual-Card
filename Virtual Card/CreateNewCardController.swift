//
//  CreateNewCardController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/25/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class CreateNewCardController: UIViewController, TaskCompletedProtocol {
  
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var companyTextField: UITextField!
  @IBOutlet weak var jobTitleTextField: UITextField!
  @IBOutlet weak var createButton: UIButton!
  
  var cardSaved: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController!.navigationBar.topItem!.title = ""
    self.title = "Create a new Business Card"
    createButton.layer.cornerRadius = 5
    
  }
  
  func saveButtonClicked(){
    self.navigationController!.popToRootViewControllerAnimated(false)
  }
  
  @IBAction func saveCardInfoToModel(sender: AnyObject) {
    
    if firstNameTextField.text == "" || lastNameTextField.text == "" || companyTextField.text == "" || jobTitleTextField.text == "" {
      let alertController = UIAlertController(title: "Sorry!", message: "Please fill out all fields", preferredStyle: .Alert)
      
      let defaultAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
      alertController.addAction(defaultAction)
      self.presentViewController(alertController, animated: true, completion: nil)
      
    } else {
      
      
      let cardReviewNav = self.storyboard?.instantiateViewControllerWithIdentifier("CardReviewNavigation") as! UINavigationController
      
      let cardReviewController = cardReviewNav.viewControllers[0] as! CardReviewController
      cardReviewController.cardModel = CardModel(cardFirstName: firstNameTextField.text!, cardLastName: lastNameTextField.text!, cardJobTitle: jobTitleTextField.text!, cardCompany: companyTextField.text!, cardUserID: firstNameTextField.text!, cardPhoneNumber: "555-666-4332", cardAddress: "123 E Fake St.", cardEmail: "userEmail@gmail.com")
      cardReviewController.cardSaved = cardSaved
      cardReviewController.delegate = self
      
      self.presentViewController(cardReviewNav, animated: true, completion: { () -> Void in
        
      })
      /*
      let cardModel = CardModel(cardFirstName: firstNameTextField.text!, cardLastName: lastNameTextField.text!, cardJobTitle: jobTitleTextField.text!, cardCompany: companyTextField.text!)
      CoreDataManager.saveMyCardToCoreData(cardModel)
      self.navigationController?.popViewControllerAnimated(true)*/
    }
    
  }
}
