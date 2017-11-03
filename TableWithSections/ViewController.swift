//
//  ViewController.swift
//  TableWithSections
//
//  Created by IosDeveloper on 03/11/17.
//  Copyright © 2017 iOSDeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //Outlet for TableView
    @IBOutlet weak var mainTableView: UITableView!
    //Array for section names
    let section = ["First Header", "Second Header", "Third Header"]
    //Array for Items in sections
    let items = [["Content", "Content1", "Content2"], ["Content3", "Content4", "Content5"], ["Content6", "Content7", "Content8"]]
    //Array that store index of opened Section while running
    var collapaseHandlerArray = [String]()
    
    //MARK:-----ViewDidLoad------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting Seprators below Table as nil
        self.mainTableView.tableFooterView = UIView()
        
        //Registering cell of header
        mainTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        
        //Setting Delegate and datasource for Table
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.reloadData()
    }
    
}

//MARK:-----TableView Methods------
extension ViewController : UITableViewDataSource,UITableViewDelegate {
    
    //setting number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    //Setting headerView Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    //Setting Header Customised View
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Declare cell
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! TableViewCell
        
        //Setting Header Components
        headerCell.titleLabel.text = self.section[section]
        headerCell.ButtonToShowHide.tag = section
        
        //Handling Button Title
        if self.collapaseHandlerArray.contains(self.section[section]){
            //if its opened
            headerCell.ButtonToShowHide.setTitle("Hide", for: .normal)
        }
        else{
            //if closed
            headerCell.ButtonToShowHide.setTitle("Show", for: .normal)
        }
        
        //Adding a target to button
        headerCell.ButtonToShowHide.addTarget(self, action: #selector(ViewController.HandleheaderButton(sender:)), for: .touchUpInside)
        return headerCell.contentView
        
    }
    
    //Setting number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.collapaseHandlerArray.contains(self.section[section]){
            return items[section].count
        }
        else{
            return 0
        }        
    }
    
    
    //Setting cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //setting title
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    //Setting footer height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    //Header cell button Action
    @objc func HandleheaderButton(sender: UIButton){
        
        //check status of button
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "Show"{
                //if yes
                self.collapaseHandlerArray.append(self.section[sender.tag])
                sender.setTitle("Hide", for: .normal)
            }
            else {
                //if no
                while self.collapaseHandlerArray.contains(self.section[sender.tag]){
                    if let itemToRemoveIndex = self.collapaseHandlerArray.index(of: self.section[sender.tag]) {
                        //remove title of header from array
                        self.collapaseHandlerArray.remove(at: itemToRemoveIndex)
                        sender.setTitle("Show", for: .normal)
                    }
                }
            }
        }
        //reload section
        self.mainTableView.reloadSections(IndexSet(integer: sender.tag), with: .none)
    }
}
