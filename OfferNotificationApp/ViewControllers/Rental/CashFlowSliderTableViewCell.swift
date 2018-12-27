//
//  CashFlowSliderTableViewCell.swift
//  FinacialAnalyzingApp
//
//  Created by gitwebmobi2018 on 2017-12-02.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.

import UIKit

class CashFlowSliderTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var value_lb: UILabel!
    @IBOutlet weak var title_lb: UILabel!
    
    var parentVC = CashMainViewController()
    var valueIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showTextField))
        tapGesture.numberOfTapsRequired = 1
        value_lb.addGestureRecognizer(tapGesture)
        
        let toolbarDone = UIToolbar.init()
        toolbarDone.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideTextField))
        done.tintColor = UIColor.white
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        toolbarDone.items = items as? [UIBarButtonItem]
        toolbarDone.sizeToFit()
        textField.inputAccessoryView = toolbarDone
        textField.isEnabled = false
        textField.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: MyFunctions
    
    @objc func showTextField() {
        DataManagement.sharedInstance.cashSliderCell = self
        slider.isHidden = true
        slider.isEnabled = false
        value_lb.isHidden = true
        value_lb.isEnabled = false
        textField.isHidden = false
        textField.isEnabled = true

        textField.becomeFirstResponder()
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.text = DataManagement.sharedInstance.cash_valueArray[valueIndex]
        
        textField.selectAll(nil)
        DataManagement.sharedInstance.keyboardHide = false
    }
    @objc func hideTextField() {
        if textField.text != "" {
            var roundedValue = roundf((textField.text! as NSString).floatValue)
            DataManagement.sharedInstance.cash_valueArray[valueIndex] = "\(Int(roundedValue))"
            if valueIndex == 5 {
                roundedValue = (DataManagement.sharedInstance.roundFloatValue(value: textField.text!) as NSString).floatValue
                DataManagement.sharedInstance.cash_valueArray[valueIndex] = "\(roundedValue)"
            }
            
            value_lb.text = DataManagement.sharedInstance.cash_valueArray[valueIndex]
            slider.value = roundedValue
            
            parentVC.sliderValueChangedRightNow = true
            parentVC.configure_ratioValues()
            parentVC.tableView.reloadData()
        }
        
        slider.isHidden = false
        slider.isEnabled = true
        value_lb.isHidden = false
        value_lb.isEnabled = true
        textField.isHidden = true
        textField.isEnabled = false
        textField.resignFirstResponder()
        
        DataManagement.sharedInstance.keyboardHide = true
    }
    func configure_Slider() {
        switch valueIndex {
        case 1:
            setting_Slider(min: 0, max: 1000000)
            break
        case 2:
            setting_Slider(min: 0, max: 100000)
            break
        case 3:
            setting_Slider(min: 0, max: 1000000)
            break
        case 4:
            setting_Slider(min: 0, max: 100)
            break
        case 5:
            setting_Slider(min: 0, max: 20)
            break
        case 6:
            setting_Slider(min: 0, max: 30)
            break
        case 8:
            setting_Slider(min: 0, max: 10000)
            break
        case 9:
            setting_Slider(min: 0, max: 12)
            break
        case 11:
            setting_Slider(min: 0, max: 20000)
            break
        case 12:
            setting_Slider(min: 0, max: 5000)
            break
        case 13:
            setting_Slider(min: 0, max: 100000)
            break
        case 14:
            setting_Slider(min: 0, max: 5000)
            break
        case 15:
            setting_Slider(min: 0, max: 20)
            break
        case 16:
            setting_Slider(min: 0, max: 20)
            break
        default:
            break
        }
    }
    func setting_Slider(min: Float, max: Float) {
        slider.minimumValue = min
        slider.maximumValue = max
        slider.value = (DataManagement.sharedInstance.cash_valueArray[valueIndex] as NSString).floatValue
    }
    func initWithData(value: String, title: String, parent: CashMainViewController, value_index: Int) {
        title_lb.text = title
        valueIndex = value_index
        if valueIndex == 5 {
            textField.keyboardType = .decimalPad
        } else {
            textField.keyboardType = .numberPad
        }
        parentVC = parent
        initWithValueLabel(value: value)
        configure_Slider()
    }
    func initWithValueLabel(value: String) {
        
        var resultString = "$\(value)"
        
        switch valueIndex {
        case 4:
            resultString = "\(value)%"
            break
        case 5:
            resultString = "\(value)%"
            break
        case 6:
            resultString = "\(value) years"
            break
        case 9:
            resultString = "\(value)%"
            break
        case 15:
            resultString = "\(value)%"
            break
        case 16:
            resultString = "\(value)%"
            break
        default:
            break
        }
        
        value_lb.text = resultString
    }
    
    //MARK: EventFunctions
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        
        var roundedValue : Float = 0.0
        
        switch valueIndex {
        case 1:
            roundedValue = roundf(slider.value/1000) * 1000.0
            break
        case 2:
            roundedValue = roundf(slider.value/1000) * 1000.0
            break
        case 3:
            roundedValue = roundf(slider.value/1000) * 1000.0
            break
        case 4:
            roundedValue = roundf(slider.value)
            break
        case 5:
            roundedValue = (DataManagement.sharedInstance.roundFloatValue(value: "\(slider.value)") as NSString).floatValue
            break
        case 6:
            roundedValue = roundf(slider.value)
            break
        case 8:
            roundedValue = roundf(slider.value/500) * 500.0
            break
        case 9:
            roundedValue = roundf(slider.value)
            break
        case 11:
            roundedValue = roundf(slider.value/1000) * 1000.0
            break
        case 12:
            roundedValue = roundf(slider.value)
            break
        case 13:
            roundedValue = roundf(slider.value)
            break
        case 14:
            roundedValue = roundf(slider.value/100) * 100.0
            break
        case 15:
            roundedValue = roundf(slider.value)
            break
        case 16:
            roundedValue = roundf(slider.value)
            break
            
        default:
            break
        }
        if valueIndex == 5 {
            DataManagement.sharedInstance.cash_valueArray[valueIndex] = "\(roundedValue)"
        } else {
            DataManagement.sharedInstance.cash_valueArray[valueIndex] = "\(Int(roundedValue))"
        }
        
        initWithValueLabel(value: "\(DataManagement.sharedInstance.cash_valueArray[valueIndex])")
        
        parentVC.sliderValueChangedRightNow = true
        parentVC.configure_ratioValues()
        parentVC.tableView.reloadData()
    }
    func checkLimit(value : String, limit: Float) -> Bool {
        if (value as NSString).floatValue <= limit {
            return true
        } else{
            return false
        }
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        slider.isHidden = false
        slider.isEnabled = true
        value_lb.isHidden = false
        value_lb.isEnabled = true
        self.textField.isHidden = true
        self.textField.isEnabled = false
        self.textField.resignFirstResponder()
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        
        switch valueIndex {
        case 1:
            return checkLimit(value: txtAfterUpdate as String, limit: 1000000)
            
        case 2:
            return checkLimit(value: txtAfterUpdate as String, limit: 100000)
            
        case 3:
            return checkLimit(value: txtAfterUpdate as String, limit: 1000000)
            
        case 4:
            return checkLimit(value: txtAfterUpdate as String, limit: 100)
            
        case 5:
            return checkLimit(value: txtAfterUpdate as String, limit: 20)
            
        case 6:
            return checkLimit(value: txtAfterUpdate as String, limit: 30)
            
        case 8:
            return checkLimit(value: txtAfterUpdate as String, limit: 10000)
            
        case 9:
            return checkLimit(value: txtAfterUpdate as String, limit: 12)
            
        case 11:
            return checkLimit(value: txtAfterUpdate as String, limit: 20000)
            
        case 12:
            return checkLimit(value: txtAfterUpdate as String, limit: 5000)
            
        case 13:
            return checkLimit(value: txtAfterUpdate as String, limit: 100000)
            
        case 14:
            return checkLimit(value: txtAfterUpdate as String, limit: 5000)
            
        case 15:
            return checkLimit(value: txtAfterUpdate as String, limit: 20)
            
        case 16:
            return checkLimit(value: txtAfterUpdate as String, limit: 20)
            
        default:
            return false
        }
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.isHidden == false {
            hideTextField()
        }
        return true
    }
}
