//
//  UPTaskTableViewCell.swift
//  Busy
//
//  Created by j w on 12/7/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit

class UPTaskTableViewCell: UITableViewCell {
    @IBOutlet weak var projLabel: UILabel!
    @IBOutlet weak var projName: UILabel!
    @IBOutlet weak var DueLabel: UILabel!
    @IBOutlet weak var Due: UILabel!
    @IBOutlet weak var TaskName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
