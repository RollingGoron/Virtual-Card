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
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var jobTitleLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  @IBOutlet weak var saveButton: UIButton!
  
  @IBOutlet weak var phoneNoLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var bgView: UIView!
  @IBOutlet weak var imgView:UIImageView!
  
  weak var delegate: TaskCompletedProtocol?
  
  var cardModel : CardModel!
  var cardSaved: Bool!
  var buttonText = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Title"
    self.saveButton.setTitle(buttonText, forState: .Normal)
    let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelClicked")
    navigationItem.leftBarButtonItem = cancelButton
    
    saveButton.layer.cornerRadius = 5
    bgView.layer.cornerRadius = 5
    bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
    bgView.layer.borderWidth = 1
    
    let name = String(format: "%@ %@", cardModel.cardFirstName,cardModel.cardLastName)
    nameLabel.text = name
    jobTitleLabel.text = cardModel.cardJobTitle
    companyLabel.text = cardModel.cardCompany
    phoneNoLabel.text = cardModel.cardPhoneNumber
    emailLabel.text = cardModel.cardEmail
    addressLabel.text = cardModel.cardAddress
    
    // Do any additional setup after loading the view.
  }
  
  func cancelClicked(){
    dismissViewControllerAnimated(true) { () -> Void in
      
    };
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func dismissController(sender: AnyObject) {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Title"
        self.saveButton.setTitle(buttonText, forState: .Normal)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelClicked")
        navigationItem.leftBarButtonItem = cancelButton
        
        firstNameLabel.text = cardModel.cardFirstName
        lastNameLabel.text = cardModel.cardLastName
        jobTitleLabel.text = cardModel.cardJobTitle
        companyLabel.text = cardModel.cardCompany
      
        
        // Do any additional setup after loading the view.
    }
    
    if self.saveButton.titleLabel!.text == "Save My Card" {
      print("Parent is Send Business Card")
      CoreDataManager.saveMyCardToCoreData(self.cardModel)
      self.navigationController?.popToRootViewControllerAnimated(true)
    } else {
      print("Parents is no Send Business Card")
      CoreDataManager.saveReceivedCardToCoreData(self.cardModel)
      NetworkManager.sharedInstance.saveCardToServer(self.cardModel.cardFirstName, lastName: self.cardModel.cardLastName, company: self.cardModel.cardCompany, jobTitle: self.cardModel.cardJobTitle, userId: self.cardModel.cardUserID, address: self.cardModel.cardAddress, emailAddress: self.cardModel.cardEmail, phoneNumber: self.cardModel.cardPhoneNumber, networkCompletionBlock: { (returnedObject, returnedString, returnedBool ) -> Void in
        print("Returned Data: \(returnedObject) with response \(returnedString), and bool \(returnedBool)")
      })
      self.navigationController?.popToRootViewControllerAnimated(true)
      
    }
    
    
    
  }
}
