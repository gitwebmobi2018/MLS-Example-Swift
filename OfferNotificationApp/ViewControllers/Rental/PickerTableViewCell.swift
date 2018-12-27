//
//  PickerTableViewCell.swift
//  FinacialAnalyzingApp
//
//  Created by gitwebmobi2018 on 2017-12-02.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.

import UIKit

class PickerTableViewCell: UITableViewCell {

    @IBOutlet weak var title_lb: UILabel!
    @IBOutlet weak var value_lb: UILabel!
    
    let datePicker = UIDatePicker()
    
    var parentVC = CashMainViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initWithData(value: String, title: String, parent: CashMainViewController, valueIndex:Int) {
        value_lb.text = value
        title_lb.text = title
        parentVC = parent
        if valueIndex == 3 {
            configure_valueLabel()
        } else {
            value_lb.textColor = UIColor.black
            switch valueIndex {
            case 0, 4:
                value_lb.text = "$\(value)"
                break
            case 1:
                value_lb.text = "\(value)%"
                break
            default:
                break
            }
        }
    }
    
    func configure_valueLabel() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentDatePickerView))
        tapGesture.numberOfTapsRequired = 1
        value_lb.addGestureRecognizer(tapGesture)
    }
    @objc func presentDatePickerView() {
        datePicker.frame = CGRect(x: 0, y: parentVC.view.frame.size.height/5*4 - 49, width: parentVC.view.frame.size.width, height: parentVC.view.frame.size.height/5+5)
        datePicker.backgroundColor = UIColor.lightGray
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        parentVC.datePickerForDismiss = datePicker
        parentVC.view.addSubview(datePicker)
        
        let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:datePicker.frame.size.height, right:0.0)
        parentVC.scrollView.contentInset = contentInsets
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" //Your date format
        let initialDate = dateFormatter.date(from: value_lb.text!)
        datePicker.date = initialDate!
    }
    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        value_lb.text = dateFormatter.string(for: datePicker.date)
        DataManagement.sharedInstance.loan_valueArray[3] = value_lb.text!
    }
    
}
