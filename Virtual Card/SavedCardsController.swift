//
//  SavedCardsController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/25/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class SavedCardsController: UIViewController {
  @IBOutlet weak var savedCardsTableView: UITableView!
  var tableData = NSArray()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Title"
    tableData = CoreDataManager.returnAllSavedCards()
    savedCardsTableView.reloadData()
    self.savedCardsTableView.rowHeight = 101
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("CardCell") as! CardCell
    let myCard = tableData[indexPath.row] as! CardEntity
    let aStr = String(format: "%@ %@", myCard.firstName!,myCard.lastName!)
    cell.nameLabel.text = aStr
    cell.jobLabel.text = myCard.jobTitle
    cell.companyLabel.text = myCard.company
    
    return cell
    
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
}

class CardCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var jobLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}

