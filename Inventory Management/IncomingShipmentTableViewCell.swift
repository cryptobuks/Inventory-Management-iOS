//
//  IncomingShipmentTableViewCell.swift
//  Inventory Management
//
//  Created by Nishant Patel on 3/25/17.
//  Copyright © 2017 Nishant Patel. All rights reserved.
//

import UIKit

class IncomingShipmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var orderTitleLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
