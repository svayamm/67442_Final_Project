//
//  TableViewCell.swift
//  Busy
//
//  Created by Svayam Mishra on 03/12/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Summary: UILabel!
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
