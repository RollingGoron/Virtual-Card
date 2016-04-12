//
//  CardDetailViewController.swift
//  Virtual Card
//
//  Created by Manasa Reddy on 4/12/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgView:UIImageView!
  
  
    var cardModel : CardModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.layer.cornerRadius = 5
        bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        bgView.layer.borderWidth = 1
        
        let aStr = String(format: "%@ %@", cardModel.cardFirstName,cardModel.cardLastName)
        nameLabel.text = aStr
        jobTitleLabel.text = cardModel.cardJobTitle
        companyLabel.text = cardModel.cardCompany
        phoneNoLabel.text = cardModel.cardPhoneNumber
        emailLabel.text = cardModel.cardEmail
        addressLabel.text = cardModel.cardAddress

      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
