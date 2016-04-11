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
        self.savedCardsTableView.registerNib(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        self.savedCardsTableView.rowHeight = 45
        
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
        let myCard = tableData[indexPath.row] as! CardEntity
        let aStr = String(format: "  %@  %@", myCard.firstName!,myCard.lastName!)
        cell.tableLabel.text = aStr
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
