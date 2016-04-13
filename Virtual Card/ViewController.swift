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
    self.title = "OPEN Business Card"
    if CoreDataManager.returnMyBusinessCard() == nil {
      tableData = ["Create new Business Card", "View My Network", "Exchange Business Cards"]
    } else {
      tableData = ["View My Business Card", "View My Network", "Exchange Business Cards"]
    }
    
    self.tableView.reloadData()
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
    
    
    if indexPath.row == 0 {
      cell.iconImage.image = UIImage(named: "createIcon")
    } else if indexPath.row == 1 {
      cell.iconImage.image = UIImage(named: "listIcon")
    } else if indexPath.row == 2 {
      cell.iconImage.image = UIImage(named: "transferIcon")
    }
    
    return cell
    
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    if indexPath.row == 0 {
      
      if CoreDataManager.returnMyBusinessCard() == nil {
        let createCardController = self.storyboard?.instantiateViewControllerWithIdentifier("CreateNewCardController")
        self.navigationController?.pushViewController(createCardController!, animated: true)
      } else {
        let detailCardViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CardReviewController") as! CardReviewController
        detailCardViewController.cardModel = CoreDataManager.returnMyBusinessCard()
        self.navigationController?.pushViewController(detailCardViewController, animated: true)
      }
      
      
    }else if indexPath.row == 1 {
      let savedCardsController = self.storyboard?.instantiateViewControllerWithIdentifier("SavedCardsController")
      self.navigationController?.pushViewController(savedCardsController!, animated: true)
    } else if indexPath.row == 2 {
      let sendReceiveCardController = self.storyboard?.instantiateViewControllerWithIdentifier("SendReceiveController")
      self.navigationController?.pushViewController(sendReceiveCardController!, animated: true)
    }
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: self, action: nil);
    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
}
