//
//  FlipMainViewController.swift
//  FinacialAnalyzingApp
//
//  Created by gitwebmobi2018 on 2017-12-02.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.

import UIKit

class FlipMainViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var view_payResult: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lb_maxOfferValue: UILabel!
    @IBOutlet weak var segment_mode: UISegmentedControl!
    @IBOutlet weak var lb_maxOfferTitle: UILabel!
    @IBOutlet weak var view_tableView: UIView!
    @IBOutlet weak var lb_moreParameters: UILabel!
    
    var moreParameters = false
    var tableViewHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Flip Max"
        
        let dismissKeyboardTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardTapGesture)
        view_tableView.addSubview(lb_moreParameters)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardDidShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        configure_ViewPayResult()
        configure_scrollView()
        configure_ViewTableView()
        configure_TableView()
        configure_maxOfferTitle()
        configure_maxOfferValue()
        configure_moreParameters()
        
        showMaxOfferValue()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: My functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !moreParameters {
                scrollView.isScrollEnabled = true
            }
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            scrollView.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if moreParameters == false {
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
    
    @objc func dismissKeyboard() {
        if DataManagement.sharedInstance.keyboardHide {
            return
        } else {
            DataManagement.sharedInstance.hideTextF()
            view.endEditing(true)
            DataManagement.sharedInstance.keyboardHide = true
        }
    }
    
    func configure_maxOfferTitle() {
        lb_maxOfferTitle.layer.shadowColor = UIColor.white.cgColor
        lb_maxOfferTitle.layer.shadowOffset = CGSize(width: 0, height: 2)
        lb_maxOfferTitle.layer.shadowOpacity = 1
        lb_maxOfferTitle.layer.shadowRadius = 1
    }
    func configure_maxOfferValue() {
        lb_maxOfferValue.layer.shadowColor = UIColor.white.cgColor
        lb_maxOfferValue.layer.shadowOffset = CGSize(width: 0, height: 2)
        lb_maxOfferValue.layer.shadowOpacity = 1
        lb_maxOfferValue.layer.shadowRadius = 1
    }
    func configure_scrollView() {
        scrollView.frame = CGRect(x: 0, y: view_payResult.frame.origin.y + view_payResult.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height-49-(view_payResult.frame.origin.y+view_payResult.frame.size.height))
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height)
    }
    
    func configure_ViewPayResult() {
        view_payResult.layer.shadowColor = UIColor.black.cgColor
        view_payResult.layer.shadowRadius = 3
        view_payResult.layer.shadowOffset = CGSize(width: 0.5, height: 2.5)
        view_payResult.layer.shadowOpacity = 0.5
    }
    func configure_ViewTableView() {
        
        view_tableView.frame = CGRect(x: 10, y: 14, width: scrollView.frame.size.width - 20, height: scrollView.frame.size.height - 28)
        
        view_tableView.clipsToBounds = true
        view_tableView.layer.masksToBounds = false
        view_tableView.layer.cornerRadius = 10
        view_tableView.layer.shadowOffset = CGSize.zero
        view_tableView.layer.shadowColor = UIColor.black.cgColor
        view_tableView.layer.shadowRadius = 3
        view_tableView.layer.shadowOpacity = 0.5
    }
    func configure_TableView() {
        tableView.isScrollEnabled = false
//        tableViewHeight = view_tableView.frame.size.height - 100 - 40
        tableViewHeight = self.view.frame.size.height - 49 - view_payResult.frame.origin.y - view_payResult.frame.size.height - 28 - 100
        tableView.frame = CGRect(x: 0, y: 60, width: view_tableView.frame.size.width, height: tableViewHeight)
        tableView.contentSize = CGSize(width: tableView.frame.size.width, height: tableView.frame.size.height)
    }
    func configure_moreParameters() {
        lb_moreParameters.frame = CGRect(x: view_tableView.frame.size.width/2.0 - lb_moreParameters.frame.size.width/2.0, y: view_tableView.frame.size.height - 40, width: view_tableView.frame.size.width, height: 40)
        lb_moreParameters.layer.cornerRadius = 10
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(moreParamAct))
        tapGesture.numberOfTapsRequired = 1
        lb_moreParameters.addGestureRecognizer(tapGesture)
    }
    func cellCounts() -> Int {
        if moreParameters == false {
            
            scrollView.contentInset = UIEdgeInsets.zero
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            configure_ViewTableView()
            lb_moreParameters.frame = CGRect(x: view_tableView.frame.size.width/2.0 - lb_moreParameters.frame.size.width/2.0, y: view_tableView.frame.size.height - 40, width: lb_moreParameters.frame.size.width, height: lb_moreParameters.frame.size.height)

            scrollView.isScrollEnabled = false
            return Int(tableViewHeight/44.0)
        } else {
            scrollView.isScrollEnabled = true
            scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: CGFloat(scrollView.frame.size.height + CGFloat((12-tableViewHeight/44)*44)+20))
            view_tableView.frame = CGRect(x: 10, y: 14, width: scrollView.frame.size.width - 20, height: scrollView.frame.size.height + CGFloat((12-tableViewHeight/44)*44)-8)
            lb_moreParameters.frame = CGRect(x: view_tableView.frame.size.width/2.0 - lb_moreParameters.frame.size.width/2.0, y: view_tableView.frame.size.height - 40, width: view_tableView.frame.size.width, height: 40)
            
            tableView.contentSize = CGSize(width: tableView.frame.size.width,
                                           height: CGFloat(tableViewHeight) + CGFloat((12-tableViewHeight/44)*44))
            scrollView.contentOffset = CGPoint(x: 0, y: Int((12-tableViewHeight/44) * 44)+20)
            tableView.frame.size = tableView.contentSize
            
            let rowCount = DataManagement.sharedInstance.flip_flipMax_InputTitleArray.count
            return rowCount
        }
    }
    func reloadTableView() {
        UIView.transition(with: tableView, duration: 0.4, options: UIViewAnimationOptions(rawValue: 5), animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }
    @objc func moreParamAct() {
        if lb_moreParameters.text == "More parameters" {
            lb_moreParameters.text = "Less parameters"
            moreParameters = true
        } else {
            moreParameters = false
            lb_moreParameters.text = "More parameters"
            tableView.frame.size = CGSize(width: tableView.frame.size.width,
                                         height: tableView.frame.size.height-CGFloat((12-tableViewHeight/44)*44))
        }
        reloadTableView()
    }
    func showMaxOfferValue() {
        if segment_mode.selectedSegmentIndex == 0 {
            DataManagement.sharedInstance.flip_Flipping_FlipMaxCalculator_GetValueArray()
            lb_maxOfferValue.text = "$ \(DataManagement.sharedInstance.flip_Flipping_FlipMaxCalculator_Values[9])"
        } else {
            DataManagement.sharedInstance.flip_Flipping_CashFlow_GetValueArray()
            lb_maxOfferValue.text = "$ \(DataManagement.sharedInstance.flip_Flipping_CashFlow_Values[8])"
        }
    }
    
    //MARK: My Event Functions
    
    @IBAction func settingAct(_ sender: Any) {
        print("hello flip")
    }
    @IBAction func segmentValueChaned(_ sender: Any) {
        showMaxOfferValue()
        if segment_mode.selectedSegmentIndex == 0 {
             self.navigationItem.title = "Flip Max"
        } else {
            self.navigationItem.title = "Cash Flow"
        }
        let contentOffSetOfScrollview = scrollView.contentOffset
        tableView.reloadData()
        scrollView.contentOffset = contentOffSetOfScrollview
    }

    //MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableViewHeight/(tableViewHeight/44))
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

//MARK: UITableViewDataSource

extension FlipMainViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCounts()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FlipSliderTableViewCell
        var title = ""
        if segment_mode.selectedSegmentIndex == 0 {
            title = DataManagement.sharedInstance.flip_flipMax_InputTitleArray[indexPath.row]
        } else {
            title = DataManagement.sharedInstance.flip_cashFlow_InputTitleArray[indexPath.row]
        }
        let value = DataManagement.sharedInstance.flip_ValueArray[indexPath.row]
        cell.initWithData(parent: self, title: title, value: value, value_index: indexPath.row)
        return cell
    }
    
}
