//
//  MoreHeightTableViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-11.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.
//

import UIKit

class MoreHeightTableViewCell: UITableViewCell {

    //MARK: Components
    @IBOutlet weak var remarktxtView: UITextView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var subTextView: UITextView!
    @IBOutlet weak var subTextView1: UIView!
    
    //MARK: Constraints
    
    @IBOutlet weak var subTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var subTextHeightContstraint: NSLayoutConstraint!
    
    
    
    var remark_test = ""
    //MARK: Properties
    var parentVController = PropertyShowViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreView.layer.borderColor = UIColor.lightGray.cgColor
        moreView.layer.borderWidth = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: My Functions
    public func initWithData(parent: PropertyShowViewController, remark: String, isSelectedMore: Bool) {
        parentVController = parent

        self.remarktxtView.text = remark
        self.remark_test = remark
        animationEffect(isSelecteMore: isSelectedMore)

    }
    
    func animationEffect(isSelecteMore: Bool) {
        if isSelecteMore {
            self.subTextViewHeightConstraint.constant = 35
            self.subTextHeightContstraint.constant = 38
            self.subTextView.isHidden = false
            self.subTextView1.isHidden = false
        } else {
            self.subTextView1.isHidden = true
            self.subTextHeightContstraint.constant = 1
            self.subTextView.isHidden = true
            self.subTextViewHeightConstraint.constant = 1
        }
    }
    
    //MARK: My Action
    @IBAction func moreAction(_ sender: Any) {
        if moreBtn.titleLabel?.text == "More"  {
            moreBtn.setTitle("Less", for: .normal)
            parentVController.isSelectedMoreButton = true
        } else {
            moreBtn.setTitle("More", for: .normal)
            parentVController.isSelectedMoreButton = false
            self.layoutIfNeeded()
        }
        animationEffect(isSelecteMore: parentVController.isSelectedMoreButton)
        
        DispatchQueue.main.async {
            self.parentVController.updateMyTable()
        }
        
    }
    
}
