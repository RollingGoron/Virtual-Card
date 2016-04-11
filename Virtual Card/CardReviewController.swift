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
  
  weak var delegate: TaskCompletedProtocol?
  
  var cardModel : CardModel!
  var cardSaved: Bool!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Title"
    
    let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelClicked")
    navigationItem.leftBarButtonItem = cancelButton
    
    firstNameLabel.text = cardModel.cardFirstName
    lastNameLabel.text = cardModel.cardLastName
    jobTitleLabel.text = cardModel.cardJobTitle
    companyLabel.text = cardModel.cardCompany
    
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
    let isSaved = CoreDataManager.saveMyCardToCoreData(self.cardModel)! as Bool
    
    if isSaved {
      self.delegate!.saveButtonClicked()
      dismissViewControllerAnimated(false) { () -> Void in
      }
    }
    
    
  }
  
  
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
