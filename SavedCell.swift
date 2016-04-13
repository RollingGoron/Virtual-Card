//
//  SavedCell.swift
//  Virtual Card
//
//  Created by Peter Gosling on 4/11/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class SavedCell: UITableViewCell {
  
  @IBOutlet weak var companyTitle: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  //@IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var jobTitleLabel: UILabel!
  
  @IBOutlet weak var avatarImage: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
