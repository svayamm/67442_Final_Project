//
//  ProjectTableViewCell.swift
//  Busy
//
//  Created by j w on 12/7/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var taskCountLabel: UILabel!
    @IBOutlet weak var taskCount: UILabel!
    @IBOutlet weak var DueLabel: UILabel!
    @IBOutlet weak var Due: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
