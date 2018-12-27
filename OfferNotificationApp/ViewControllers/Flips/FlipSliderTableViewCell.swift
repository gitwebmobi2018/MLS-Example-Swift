//
//  FlipSliderTableViewCell.swift
//  FinacialAnalyzingApp
//
//  Created by gitwebmobi2018 on 2017-12-02.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.

import UIKit

class FlipSliderTableViewCell: UITableViewCell, UITextFieldDelegate{

    @IBOutlet weak var lb_value: UILabel!
    @IBOutlet weak var lb_title: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tf_value: UITextField!
    
    var parentVC = FlipMainViewController()
    var valueIndex : Int = 0
    
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set (newFrame) {
//            var frame = newFrame
//            frame.origin.x += 15
//            frame.size.width -= 30
//            super.frame = frame
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showTextField))
        lb_value.addGestureRecognizer(tapGesture)
        
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
        tf_value.inputAccessoryView = toolbarDone
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: MyFunctions
    
    @objc func showTextField() {
        DataManagement.sharedInstance.flipSubSliderViewCell = self
        slider.isHidden = true
        slider.isEnabled = false
        lb_value.isHidden = true
        lb_value.isEnabled = false
        tf_value.isHidden = false
        tf_value.isEnabled = true
        
        tf_value.becomeFirstResponder()
        tf_value.clearButtonMode = UITextFieldViewMode.whileEditing
        tf_value.text = DataManagement.sharedInstance.flip_ValueArray[valueIndex]
        tf_value.selectAll(nil)
        
        DataManagement.sharedInstance.keyboardHide = false
    }
    @objc func hideTextField() {
        if tf_value.text != "" {
            let roundedValue = roundf((tf_value.text! as NSString).floatValue)
            DataManagement.sharedInstance.flip_ValueArray[valueIndex] = "\(Int(roundedValue))"
            slider.value = roundedValue
        }
        configure_Value_Lb()
        parentVC.showMaxOfferValue()
        
        slider.isHidden = false
        slider.isEnabled = true
        lb_value.isHidden = false
        lb_value.isEnabled = true
        tf_value.isHidden = true
        tf_value.isEnabled = false
        tf_value.resignFirstResponder()
        
        DataManagement.sharedInstance.keyboardHide = true
    }
    
    func configure_Value_Lb() {
        let value = DataManagement.sharedInstance.flip_ValueArray[valueIndex]
        lb_value.text = DataManagement.sharedInstance.valueSet(value: value, valueIndex: valueIndex)
    }
    
    func configure_Slider() {
        
        switch valueIndex {
        case 0:
            setting_Slider(min: 0, max: 1000000)
            break
        case 1:
            setting_Slider(min: 0, max: 24)
            break
        case 2:
            setting_Slider(min: 0, max: 10000)
            break
        case 3:
            setting_Slider(min: 0, max: 10000)
            break
        case 4:
            setting_Slider(min: 0, max: 2000)
            break
        case 5:
            setting_Slider(min: 0, max: 500)
            break
        case 6:
            setting_Slider(min: 0, max: 200000)
            break
        case 7:
            setting_Slider(min: 0, max: 10)
            break
        case 8:
            setting_Slider(min: 0, max: 1000)
            break
        case 9:
            setting_Slider(min: 0, max: 10)
            break
        case 10:
            setting_Slider(min: 0, max: 10000)
            break
        case 11:
            setting_Slider(min: 0, max: 200000)
            break
        case 12:
            setting_Slider(min: 0, max: 100000)
            break
            
        default:
            break
        }
    }
    func setting_Slider(min: Float, max: Float) {
        slider.minimumValue = min
        slider.maximumValue = max
        let value = (DataManagement.sharedInstance.flip_ValueArray[valueIndex] as NSString).floatValue
        slider.value = value
    }
    func initWithData(parent: FlipMainViewController, title: String, value: String, value_index: Int) {
        parentVC = parent
        lb_title.text = title
        lb_value.text = value
        valueIndex = value_index
        configure_Value_Lb()
        configure_Slider()
    }
    
    //MARK: MyEventFunctions
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        var roundedValue : Float = 0.0
        switch valueIndex {
        case 0:
            roundedValue = roundf(slider.value/1000) * 1000.0
            break
        case 1:
            roundedValue = roundf(slider.value)
            break
        case 2:
            roundedValue = roundf(slider.value/100) * 100.0
            break
        case 3:
            roundedValue = roundf(slider.value/100) * 100.0
            break
        case 4:
            roundedValue = roundf(slider.value/50) * 50.0
            break
        case 5:
            roundedValue = roundf(slider.value)
            break
        case 6:
            roundedValue = roundf(slider.value/500) * 500.0
            break
        case 7:
            roundedValue = slider.value
            break
        case 8:
            roundedValue = roundf(slider.value/10) * 10.0
            break
        case 9:
            roundedValue = slider.value
            break
        case 10:
            roundedValue = roundf(slider.value/100) * 100.0
            break
        case 11:
            roundedValue = roundf(slider.value/500) * 500.0
            break
        case 12:
            roundedValue = roundf(slider.value/500) * 500.0
            break
            
        default:
            break
        }
        DataManagement.sharedInstance.flip_ValueArray[valueIndex] = "\(Int(roundedValue))"
        configure_Value_Lb()
        parentVC.showMaxOfferValue()
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
        lb_value.isHidden = false
        lb_value.isEnabled = true
        tf_value.isHidden = true
        tf_value.isEnabled = false
        tf_value.resignFirstResponder()
        return false
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        switch valueIndex {
        case 0:
            return checkLimit(value: txtAfterUpdate as String, limit: 1000000)
            
        case 1:
            return checkLimit(value: txtAfterUpdate as String, limit: 24)
            
        case 2:
            return checkLimit(value: txtAfterUpdate as String, limit: 10000)
            
        case 3:
            return checkLimit(value: txtAfterUpdate as String, limit: 10000)
            
        case 4:
            return checkLimit(value: txtAfterUpdate as String, limit: 2000)
            
        case 5:
            return checkLimit(value: txtAfterUpdate as String, limit: 500)
            
        case 6:
            return checkLimit(value: txtAfterUpdate as String, limit: 200000)
            
        case 7:
            return checkLimit(value: txtAfterUpdate as String, limit: 10)
            
        case 8:
            return checkLimit(value: txtAfterUpdate as String, limit: 1000)
            
        case 9:
            return checkLimit(value: txtAfterUpdate as String, limit: 10)
            
        case 10:
            return checkLimit(value: txtAfterUpdate as String, limit: 10000)
            
        case 11:
            return checkLimit(value: txtAfterUpdate as String, limit: 1000000)
            
        case 12:
            return checkLimit(value: txtAfterUpdate as String, limit: 1000000)
            
        default:
            return false
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if tf_value.isHidden == false {
            hideTextField()
        }
        return true
    }
}
