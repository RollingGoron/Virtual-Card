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
        if self.parentViewController?.title != "Send Business Card" {
            CoreDataManager.saveMyCardToCoreData(self.cardModel)
            self.navigationController?.popToRootViewControllerAnimated(true)
        } else {
            CoreDataManager.saveReceivedCardToCoreData(self.cardModel)
            NetworkManager.sharedInstance.saveCardToServer(self.cardModel.cardFirstName, lastName: self.cardModel.cardLastName, company: self.cardModel.cardCompany, jobTitle: self.cardModel.cardJobTitle, networkCompletionBlock: { (returnedObject, returnedString, returnedBool ) -> Void in
                        self.navigationController?.popToRootViewControllerAnimated(true)
                print("Returned Data: \(returnedObject) with response \(returnedString), and bool \(returnedBool)")
            })
        }
        
        
    }
}
