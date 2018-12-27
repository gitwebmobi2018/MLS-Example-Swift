//
//  CashMainViewController.swift
//  FinacialAnalyzingApp
//
//  Created by gitwebmobi2018 on 2017-12-02.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.

import UIKit

class CashMainViewController: UIViewController, UITableViewDelegate{

    @IBOutlet weak var paymentImageView: UIView!
    @IBOutlet weak var andrewVal_lb: UILabel!
    @IBOutlet weak var debtVal_lb: UILabel!
    @IBOutlet weak var cashFlow_ValLb: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view_tableView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var moreParameters_lb: UILabel!
    
    var datePickerForDismiss = UIDatePicker()
    var pickerForDismiss = UIPickerView()
    
    var cash_moreParameters = false
    var tableViewHeight : CGFloat = 0.0
    
    var sliderValueChangedRightNow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissKeyboardTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardTapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardDidShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        configure_detailComponents()
        configure_scrollView()
        configure_tableView_View()
        configure_tableView()
        configure_moreParameters()
        configure_ratioValues()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Configure Functions
    
    @objc func dismissKeyboard() {
        datePickerForDismiss.removeFromSuperview()
        pickerForDismiss.removeFromSuperview()
        scrollView.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
        if DataManagement.sharedInstance.keyboardHide {
            return
        } else {
            DataManagement.sharedInstance.cashHideTextF()
            view.endEditing(true)
            DataManagement.sharedInstance.keyboardHide = true
        }
        
    }
    
    func configure_detailComponents() {        
        paymentImageView.layer.shadowColor = UIColor.black.cgColor
        paymentImageView.layer.shadowRadius = 3
        paymentImageView.layer.shadowOffset = CGSize(width: 0.5, height: 2.5)
        paymentImageView.layer.shadowOpacity = 0.5
    }
    func configure_ratioValues() {
        DataManagement.sharedInstance.cash_first_GetValueArray()
        DataManagement.sharedInstance.cash_summary_GetValueArray()
        
        cashFlow_ValLb.text = "$\(DataManagement.sharedInstance.cash_summary_valueArray[7])"
        
        andrewVal_lb.text = "\(DataManagement.sharedInstance.cash_summary_valueArray[9])%"
        if (andrewVal_lb.text! as NSString).floatValue > 75 {
            andrewVal_lb.textColor = UIColor.red
        } else {
            andrewVal_lb.textColor = UIColor.green
        }
        
        debtVal_lb.text = DataManagement.sharedInstance.cash_summary_valueArray[10]
        if (debtVal_lb.text! as NSString).floatValue > 1.25 {
            debtVal_lb.textColor = UIColor.green
        } else {
            debtVal_lb.textColor = UIColor.red
        }
    }
    func configure_scrollView() {
        scrollView.frame = CGRect(x: 0, y: paymentImageView.frame.origin.y + paymentImageView.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height-49-(paymentImageView.frame.origin.y+paymentImageView.frame.size.height))
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
        
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        
        scrollView.isScrollEnabled = true
    }
    func configure_tableView_View() {
        
        view_tableView.frame = CGRect(x: 10, y: 14, width: scrollView.frame.size.width - 20, height: scrollView.frame.size.height - 28)
        
        view_tableView.clipsToBounds = true
        view_tableView.layer.masksToBounds = false
        view_tableView.layer.cornerRadius = 10
        view_tableView.layer.shadowOffset = CGSize.zero
        view_tableView.layer.shadowColor = UIColor.black.cgColor
        view_tableView.layer.shadowRadius = 3
        view_tableView.layer.shadowOpacity = 0.5
    }
    func configure_tableView() {
        tableView.isScrollEnabled = false
        tableViewHeight = self.view.frame.size.height - 49 - paymentImageView.frame.origin.y - paymentImageView.frame.size.height - 28 - 100
        tableView.frame = CGRect(x: 0, y: 60, width: view_tableView.frame.size.width, height: tableViewHeight)
        tableView.contentSize = CGSize(width: tableView.frame.size.width, height: tableView.frame.size.height)
    }
    func configure_moreParameters() {
        moreParameters_lb.frame = CGRect(x: 0, y: view_tableView.frame.size.height - 40, width: view_tableView.frame.size.width, height: 40)
        moreParameters_lb.layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(moreParametersAct))
        moreParameters_lb.addGestureRecognizer(tapGesture)
        moreParameters_lb.isUserInteractionEnabled = true
    }
//    func configure_headerComponents() {
//        headerImage.frame = CGRect(x: 0, y: 0, width: view_tableView.frame.size.width, height: 60)
//        roundCorners(radius: 10, view: headerImage)
//        
//        cashMode_lb.frame = CGRect(x: 0, y: 0, width: view_tableView.frame.size.width/2, height: 62)
//        loanMode_lb.frame = CGRect(x: view_tableView.frame.size.width/2, y: 0, width: view_tableView.frame.size.width/2, height: 62)
//        
//        roundCorners(radius: 10, view: cashMode_lb)
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cashModeAct))
//        tapGesture.numberOfTapsRequired = 1
//        cashMode_lb.addGestureRecognizer(tapGesture)
//        cashMode_lb.isUserInteractionEnabled = true
//        
//        roundCorners(radius: 10, view: loanMode_lb)
//        loanMode_lb.backgroundColor = UIColor.clear
//        let tapGestureLoan = UITapGestureRecognizer(target: self, action: #selector(loanModeAct))
//        tapGestureLoan.numberOfTapsRequired = 1
//        loanMode_lb.addGestureRecognizer(tapGestureLoan)
//        loanMode_lb.isUserInteractionEnabled = true
//    }
    // MARK: sometimes call functions
    func roundCorners(radius: Float, view: UIView) {
        let path = UIBezierPath(roundedRect:view.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
    func reloadTableView() {
        UIView.transition(with: tableView, duration: 0.4, options: UIViewAnimationOptions(rawValue: 5), animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }
    func cellCounts() -> Int {
        if !cash_moreParameters {
            scrollView.contentInset = UIEdgeInsets.zero
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            configure_tableView_View()
            configure_tableView()
            configure_moreParameters()            
            scrollView.isScrollEnabled = false
            return Int(tableViewHeight/44.0)
        } else {
            scrollView.isScrollEnabled = true
            view_tableView.frame = CGRect(x: 10, y: 14, width: scrollView.frame.size.width - 20, height: tableViewHeight + 100 + CGFloat((22-tableViewHeight/44)*44)+20)
            
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: CGFloat(scrollView.frame.size.height + (22-tableViewHeight/44) * 44)+20)
            configure_moreParameters()
            
            tableView.contentSize = CGSize(width: tableView.frame.size.width,
                                           height: CGFloat(tableViewHeight) + CGFloat((22-tableViewHeight/44)*44))
            if !sliderValueChangedRightNow {
                scrollView.contentOffset = CGPoint(x: 0, y: (22-tableViewHeight/44) * 44+20)
            }
            tableView.frame.size = tableView.contentSize
            
            return 22
        }
    }
    func whiteShadowOnLabel(label: UILabel) {
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 1)
        label.layer.shadowOpacity = 1
        label.layer.shadowRadius = 1
    }
    // MARK: Event Functions
    
    @objc func moreParametersAct() {
        datePickerForDismiss.removeFromSuperview()
        if !cash_moreParameters {
            sliderValueChangedRightNow = false
            moreParameters_lb.text = "Less parameters"
            cash_moreParameters = true
        } else {
            cash_moreParameters = false
            moreParameters_lb.text = "More parameters"
        }
        reloadTableView()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        datePickerForDismiss.removeFromSuperview()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !cash_moreParameters {
                scrollView.isScrollEnabled = true
            }
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            scrollView.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if cash_moreParameters == false {
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            scrollView.isScrollEnabled = false
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 0,
                                                   bottom: 0,
                                                   right: 0)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
extension CashMainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCounts()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerTableViewCell
            DataManagement.sharedInstance.loan_getValueArray()
            cell.initWithData(value: DataManagement.sharedInstance.loan_valueArray[3], title: DataManagement.sharedInstance.loan_input_titleArray[3], parent: self, valueIndex: 3)
            return cell
        } else if indexPath.row == 1 || indexPath.row == 8 || indexPath.row == 11 || indexPath.row == 18 {
            let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
            cell.textLabel?.text = DataManagement.sharedInstance.cash_input_titleArray[indexPath.row - 1]
            return cell
        } else if indexPath.row < 18 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath) as! CashFlowSliderTableViewCell
            cell.initWithData(value: DataManagement.sharedInstance.cash_valueArray[indexPath.row - 1], title: DataManagement.sharedInstance.cash_input_titleArray[indexPath.row - 1], parent: self, value_index: indexPath.row - 1)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as! PickerTableViewCell
            DataManagement.sharedInstance.loan_getValueArray()
            cell.initWithData(value: DataManagement.sharedInstance.loan_valueArray[indexPath.row - 19], title: DataManagement.sharedInstance.loan_input_titleArray[indexPath.row - 19], parent: self, valueIndex: indexPath.row - 19)
            return cell
        }
    }
}
extension CashMainViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.datePickerForDismiss.removeFromSuperview()
        self.scrollView.contentInset = UIEdgeInsets(top: 0,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0)
        self.sliderValueChangedRightNow = false
    }
}
