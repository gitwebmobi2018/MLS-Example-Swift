//  DynamicHeightTableViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-02.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.

import UIKit

class DynamicHeightTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initWithData(title: String, value: String) {
        titleLabel.text = title
//        let nsstringValue = value as NSString
//        let str = nsstringValue.uppercased
        if value.count == 0 {
            valueLabel.text = "---"
        } else {
            valueLabel.text = value
        }
        titleLabel.adjustsFontSizeToFitWidth = true
        valueLabel.adjustsFontSizeToFitWidth = true
    }
    
}
