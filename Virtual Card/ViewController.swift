//
//  ViewController.swift
//  Virtual Card
//
//  Created by Peter Gosling on 3/22/16.
//  Copyright © 2016 Peter Gosling. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  let tableData = ["Create new OPEN Business Card", "Saved Business Cards", "Send/Receive OPEN Business Card"]
  let cardData = CardModel(cardFirstName: "Bob", cardLastName: "Sacamano", cardJobTitle: "Accountant", cardCompany: "Target")
  

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Title"
    
    //CoreDataManager.returnMyBusinessCard()
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    self.tableView.registerNib(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
    
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
    
    let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeCell
    cell.tableLabel.text = tableData[indexPath.row]
    cell.tableLabel.textAlignment = NSTextAlignment.Center
    
    return cell
    
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    if indexPath.row == 0 {
      let createCardController = self.storyboard?.instantiateViewControllerWithIdentifier("CreateNewCardController")
      self.navigationController?.pushViewController(createCardController!, animated: true)
    }else if indexPath.row == 1 {
        let savedCardsController = self.storyboard?.instantiateViewControllerWithIdentifier("SavedCardsController")
        self.navigationController?.pushViewController(savedCardsController!, animated: true)
    } else if indexPath.row == 2 {
      let sendReceiveCardController = self.storyboard?.instantiateViewControllerWithIdentifier("SendReceiveController")
      self.navigationController?.pushViewController(sendReceiveCardController!, animated: true)
    }
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }

}
