//
//  Utiles.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-12.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.
//

import UIKit

class Utiles: NSObject {

    public func getStringNumCommas(value: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let indexValue = value.index(value.startIndex, offsetBy: 1)
        let subStringIntValue = value[indexValue...]
        let resultString = numberFormatter.string(from: NSNumber(value: Int(subStringIntValue)!))
        return resultString!
    }
    
    public func convertImageToBlackAndWhite(image: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIPhotoEffectNoir") //original, noir, mono, tonal
        currentFilter!.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        let output = currentFilter!.outputImage
        let cgImg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgImg!)
        return processedImage
    }
    
    public func heightForString(text:String, fontSize: CGFloat, width:CGFloat) -> CGFloat{
        let font  = UIFont(name: "Helvetica", size: fontSize)
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    public func currentTimeString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func getDayFromDayMonth(dateStr:String) -> (String, String, String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.date(from: dateStr)
        let str = dateFormatter.string(from: date!)
        
        let fullDateStringArr = str.components(separatedBy: " ")
        
        let dayofweekStringArr = fullDateStringArr[0].components(separatedBy: ",")
        
        var monthString = ""
        var dayString = ""
        
        let stringArray1 = fullDateStringArr[1].components(separatedBy: ",")
        let stringArray2 = fullDateStringArr[2].components(separatedBy: ",")
        if stringArray1[0].count == 2 || stringArray1[0].count == 1 {
            dayString = stringArray1[0]
            monthString = stringArray2[0]
        } else {
            dayString = stringArray2[0]
            monthString = stringArray1[0]
        }
        
        let index = monthString.index(str.startIndex, offsetBy: 3)
        let monthSubstring = monthString.prefix(upTo: index)
        return (dayString, dayofweekStringArr[0], String(monthSubstring))
    }
    
    public func getMoreDayByValue(toDateStr: String, value: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let toDate = dateFormatter.date(from: toDateStr)
        
        let dateforCal = Calendar.current
        var dateIncreased = dateforCal.date(bySetting: .day, value: 1, of: toDate!)
        dateIncreased = dateforCal.date(byAdding: .day, value: value, to: toDate!)
        let dateforPay = dateFormatter.string(from: dateIncreased!)
        return dateforPay
    }
    
}
