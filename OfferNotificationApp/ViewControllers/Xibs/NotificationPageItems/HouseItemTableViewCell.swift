//
//  HouseItemTableViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-08.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.
//

import UIKit

class HouseItemTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var streetNameLabel: UILabel!
    @IBOutlet weak var bednumLabel: UILabel!
    @IBOutlet weak var bathNumLabel: UILabel!
    @IBOutlet weak var squareLabel: UILabel!
    @IBOutlet weak var cityZipCodeLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    
    var propertyItem : ExcelItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initValues() {
        if propertyItem?.homeImageBlack == nil {
            noImageLabel.isHidden = false
            imgView.image = #imageLiteral(resourceName: "no_home_image.png")
        } else {
            noImageLabel.isHidden = true
            imgView.image = propertyItem?.homeImageColor
            
        }
        
        bednumLabel.text = propertyItem?.bedrooms
        bathNumLabel.text = propertyItem?.fullBaths
        
        let utiles = Utiles()
        let priceTxt = utiles.getStringNumCommas(value: (propertyItem?.listPrice)!)
        priceLabel.text = priceTxt
        
        let streetNum = propertyItem?.street
        let streetName = propertyItem?.streetName
        streetNameLabel.text = "\(String(describing: streetNum!)) \(String(describing: streetName!))"
        
        cityZipCodeLabel.text = "\(String(describing: (propertyItem?.city)!)), \(String(describing: (propertyItem?.zipCode)!))"
        
        if propertyItem?.identifyKey == "New" {
            newLabel.isHidden = false
        } else {
            newLabel.isHidden = true
        }
    }
    
    func initWithData(item: ExcelItem) {
        propertyItem = item
        initValues()
    }
    
}
