//
//  TableViewCell.swift
//  TableWithSections
//
//  Created by IosDeveloper on 03/11/17.
//  Copyright © 2017 iOSDeveloper. All rights reserved.
//

import UIKit
    
class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ButtonToShowHide: UIButton!
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func ButtonActionHandler(_ sender: Any) {
        isChecked = !isChecked
        if isChecked{
            ButtonToShowHide.setTitle("Hide", for: .normal)
        }
        else{
            ButtonToShowHide.setTitle("Show", for: .normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
