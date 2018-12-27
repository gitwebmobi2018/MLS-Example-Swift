//
//  PropertyHomeImageTableViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-11.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.
//

import UIKit

class PropertyHomeImageTableViewCell: UITableViewCell {

    //MARK: Components
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bedNumLabel: UILabel!
    @IBOutlet weak var bathNumLabel: UILabel!
    @IBOutlet weak var noImageLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var newMarkLabel: UILabel!
    @IBOutlet weak var streetInfoLabel: UILabel!
    @IBOutlet weak var roiValueLabel: UILabel!
    
    var propertyItem : ExcelItem?
    let utiles = Utiles()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.layer.borderColor = UIColor.lightGray.cgColor
        bottomView.layer.borderWidth = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initWithData(property: ExcelItem) {
        propertyItem = property
        let index = Int(arc4random_uniform(31))
        roiValueLabel.text = "\(index)%"
        if property.identifyKey == "New" {
            newMarkLabel.isHidden = false
        } else {
            newMarkLabel.isHidden = true
        }
        if property.homeImageColor == nil {
            noImageLabel.isHidden = false
            homeImage.image = #imageLiteral(resourceName: "no_home_image.png")
        } else {
            noImageLabel.isHidden = true
            homeImage.image = propertyItem?.homeImageColor
        }
        
        let streetNum = property.street
        let streetName = property.streetName
        streetInfoLabel.text = "\(String(describing: streetNum)) \(String(describing: streetName))"
        
        priceLabel.text = "US$\(utiles.getStringNumCommas(value: (propertyItem?.listPrice)!))"
        bedNumLabel.text = propertyItem?.bedrooms
        bathNumLabel.text = propertyItem?.fullBaths
    }
    
}
