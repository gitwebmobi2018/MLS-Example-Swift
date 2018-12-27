//
//  ClosingDateFSPagerViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-24.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.
//

import UIKit
import FSPagerView

class ClosingDateFSPagerViewCell: FSPagerViewCell {

    //MARK: Components
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayofweekLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    
    //MARK: Properties
    var parentVC = ClosingDateScrollViewHorizontalTableViewCell()
    
    //MARK: Override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectedCellAction(isSelected: false)
    }
    
    //MARK: My Functions
    func initWithData(parent: ClosingDateScrollViewHorizontalTableViewCell, isSelected: Bool, dayString: String, monthString: String, dayofweekString: String) {
        parentVC = parent
        selectedCellAction(isSelected: isSelected)
        dateLabel.text = dayString
        dayofweekLabel.text = dayofweekString
        monthLabel.text = monthString
    }
    
    func selectedCellAction(isSelected:Bool) {
        if isSelected {
            backView.layer.borderColor = UIColor.black.cgColor
            backView.layer.borderWidth = 1
            dateLabel.textColor = UIColor.black
            dayofweekLabel.textColor = UIColor.black
            monthLabel.textColor = UIColor.black
        } else {
            backView.layer.borderColor = UIColor.lightGray.cgColor
            backView.layer.borderWidth = 0.5
            dateLabel.textColor = UIColor.lightGray
            dayofweekLabel.textColor = UIColor.lightGray
            monthLabel.textColor = UIColor.lightGray
        }
    }

}
