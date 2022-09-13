 //
//  RateUITableViewCell.swift
//  rate
//
//  Created by kevin on 2019/11/9.
//  Copyright © 2019 kevin. All rights reserved.
//

import UIKit

class RateTableViewCell: UITableViewCell {
    @IBOutlet var flagLabel: UILabel!
    @IBOutlet var currencyLabel: UILabel!
    @IBOutlet var buyLabel: UILabel!
    @IBOutlet var sellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
