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
        self.savedCardsTableView.registerNib(UINib(nibName: "SavedCell", bundle: nil), forCellReuseIdentifier: "SavedCell")
        self.savedCardsTableView.rowHeight = 87
        self.savedCardsTableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        NetworkManager.sharedInstance.fetchAllCardsForAccount { (returnedObject, returnedString, returnedBool) -> Void in
            
            guard let returnedCardsArray = returnedObject["busiunessCards"] as? [Dictionary<String, String>] else {
                return
            }
            
            if returnedCardsArray.count != self.tableData.count { // Check if new cards have been added.
                
                for (var i = 0; i < returnedCardsArray.count; i++) {
                    print(returnedCardsArray[i])
                    
                    CoreDataManager.saveReceivedCardToCoreData(CardModel(fetchedDictionary: returnedCardsArray[i]))
                }
                self.tableData = CoreDataManager.returnAllSavedCards()
                dispatch_async(dispatch_get_main_queue(), {
                    self.savedCardsTableView.reloadData()
                })
            }
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
//  override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//  }
//
extension SavedCardsController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let savedEntity = tableData[indexPath.row] as! SavedEntity
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SavedCell") as! SavedCell
        
        cell.firstNameLabel.text = savedEntity.firstName
        cell.lastNameLabel.text = savedEntity.lastName
        cell.jobTitleLabel.text = savedEntity.jobTitle
        cell.companyTitle.text = savedEntity.company
        
        return cell
        
    }
    
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
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

