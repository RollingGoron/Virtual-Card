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
  
    
  var tableData = [String]()

  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Title"    
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    self.tableView.registerNib(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
  }
  
  override func viewWillAppear(animated: Bool) {
    self.title = "OPEN Virtual Business Card"
    if CoreDataManager.returnMyBusinessCard() == nil {
      tableData = ["Create new OPEN Business Card", "Saved Business Cards", "Send/Receive OPEN Business Card"]
    } else {
      tableData = ["View My OPEN Business Card", "Saved Business Cards", "Send/Receive OPEN Business Card"]
    }
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
