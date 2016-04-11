//
//  CardReviewController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/27/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class CardReviewController: UIViewController {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    var cardModel : CardModel!
    var cardSaved: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameLabel.text = cardModel.cardFirstName
        lastNameLabel.text = cardModel.cardLastName
        jobTitleLabel.text = cardModel.cardJobTitle
        companyLabel.text = cardModel.cardCompany
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissController(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
        dismissViewControllerAnimated(true) { () -> Void in
            
            if self.parentViewController?.title == "Send Business Card" {
                CoreDataManager.saveReceivedCardToCoreData(self.cardModel)
            } else {
                CoreDataManager.saveMyCardToCoreData(self.cardModel)
                NetworkManager.sharedInstance.saveCardToServer(self.cardModel.cardFirstName, lastName: self.cardModel.cardLastName, company: self.cardModel.cardCompany, jobTitle: self.cardModel.cardJobTitle, networkCompletionBlock: { (returnedObject, returnedString, returnedBool ) -> Void? in
                    print("Returned Data: \(returnedObject) with response \(returnedString), and bool \(returnedBool)")
                })
            }
        
        }
        
    }
    
}
