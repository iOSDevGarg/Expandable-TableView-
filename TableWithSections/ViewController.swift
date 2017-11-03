//
//  ViewController.swift
//  TableWithSections
//
//  Created by IosDeveloper on 03/11/17.
//  Copyright © 2017 iOSDeveloper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mainTableView: UITableView!
    
    let section = ["pizza", "deep dish pizza", "calzone"]
    
    let items = [["Margarita", "BBQ Chicken", "Peproni"], ["sausage", "meat lovers", "veggie lovers"], ["sausage", "chicken pesto", "prawns & mashrooms"]]
    
    var collapaseHandlerArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.tableFooterView = UIView()
        mainTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.reloadData()
    }
    
}

extension ViewController : UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! TableViewCell
        headerCell.titleLabel.text = self.section[section]
        headerCell.ButtonToShowHide.tag = section
        if self.collapaseHandlerArray.contains(self.section[section]){
            headerCell.ButtonToShowHide.setTitle("Hide", for: .normal)
        }
        else{
            headerCell.ButtonToShowHide.setTitle("Show", for: .normal)
        }
        headerCell.ButtonToShowHide.addTarget(self, action: #selector(ViewController.HandleheaderButton(sender:)), for: .touchUpInside)
        return headerCell.contentView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.collapaseHandlerArray.contains(self.section[section]){
            return items[section].count
        }
        else{
            return 0
        }        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    @objc func HandleheaderButton(sender: UIButton){
        
        if let buttonTitle = sender.title(for: .normal) {
            if buttonTitle == "Show"{
                self.collapaseHandlerArray.append(self.section[sender.tag])
                sender.setTitle("Hide", for: .normal)
            }
            else {
                while self.collapaseHandlerArray.contains(self.section[sender.tag]){
                    if let itemToRemoveIndex = self.collapaseHandlerArray.index(of: self.section[sender.tag]) {
                        self.collapaseHandlerArray.remove(at: itemToRemoveIndex)
                        sender.setTitle("Show", for: .normal)
                    }
                }
            }
        }
        self.mainTableView.reloadSections(IndexSet(integer: sender.tag), with: .none)
    }
    
    
}
