//
//  CardDetailViewController.swift
//  Virtual Card
//
//  Created by Srinivas Mamidishetty on 4/12/16.
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
    
    var cardModel : SavedEntity!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.layer.cornerRadius = 5
        bgView.layer.borderColor = UIColor.lightGrayColor().CGColor
        bgView.layer.borderWidth = 1
        
        let aStr = String(format: "%@ %@", cardModel.firstName!,cardModel.lastName!)
        nameLabel.text = aStr
        jobTitleLabel.text = cardModel.jobTitle
        companyLabel.text = cardModel.company
        phoneNoLabel.text = cardModel.phoneNumber
        emailLabel.text = cardModel.email
        addressLabel.text = cardModel.address

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
