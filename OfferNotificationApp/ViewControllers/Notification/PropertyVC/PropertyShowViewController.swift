import UIKit
import MessageUI

class PropertyShowViewController: UIViewController, UITableViewDelegate, MFMailComposeViewControllerDelegate {

    //MARK: Properties
    var closingDate = ""
    
    let utiles = Utiles()
    var propertyItemData = ExcelItem()
    
    var isStatusBarStyleDefault = false
    var isSelectedMoreButton = false
    
    //MARK: Components
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initComponents()
        setStatusBarStyleAndNavigationbar(isDefault: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK:ScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y < 195 {
            setStatusBarStyleAndNavigationbar(isDefault: false)
        } else {
            setStatusBarStyleAndNavigationbar(isDefault: true)
        }
    }
    
    //MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        let (titleString, valueString) = getValueForRow(index: indexPath.row)
//
//        let fontTitle  = UIFont(name: "Helvetica", size: 17)
//        let heightTitle = self.heightForView(text: titleString, font: fontTitle!, width: self.view.frame.size.width - 16)
//
//        let fontValue  = UIFont(name: "Helvetica", size: 15)
//        let heightValue = self.heightForView(text: valueString, font: fontValue!, width: self.view.frame.size.width - 24)
//
//        if indexPath.row == columnTitleList.count - 1 {
//            return (67 + heightTitle + heightValue)
//        } else if indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 9 {
//            return (40 + heightTitle + heightValue)
//        } else {
//            return (21 + heightTitle + heightValue)
//        }
        
        switch indexPath.row {
        case 0:
            return 250
        case 1:
            if isSelectedMoreButton {
                let heightValue = utiles.heightForString(text: propertyItemData.remarks, fontSize: 12, width: self.view.frame.size.width - 36)
                return 185 + heightValue
            } else {
                return 145
            }
        case 2:
            return 150
        case 3:
            return 132
        default:
            return 40
        }
        
    }
    
    //MARK: MFMailComposeViewControllerDelegate
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: My Button Functions
    
    @IBAction func makeOfferBtnAction(_ sender: Any) {
        sendEmail(subject: "My Offer", emailAddress: "mrjavaman@hotmail.com", content: "\(closingDate)")
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popToViewController((self.navigationController?.viewControllers.first)!, animated: true)
    }    
    
    //MARK: My Functions
    
    func showingSchedulBtnAction() {
        sendEmail(subject: "My Schedule", emailAddress: "mrjavaman@hotmail.com", content: "")
    }
    
    func phoneCallBtnAction() {
        guard let number = URL(string: "tel://1234567890") else { return }
        UIApplication.shared.open(number)
    }
    
    func unlikeBtnAction() {
        sendEmail(subject: "I don't like it...", emailAddress: "mrjavaman@hotmail.com", content: "it is not my favor.")
    }
    
    func setClosingDate(value : String) {
        closingDate = value
    }
    
    func sendEmail(subject: String, emailAddress: String, content:String) {
        if MFMailComposeViewController.canSendMail() {
            let mailController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setSubject(subject)
            mailController.setToRecipients([emailAddress])
            mailController.setMessageBody(content, isHTML: false)
            present(mailController, animated: true, completion: nil)
        }
    }
    
    func initComponents() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func updateMyTable() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func setStatusBarStyleAndNavigationbar(isDefault: Bool) {
        
        if isDefault {
            UIApplication.shared.statusBarStyle = .default
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            self.navigationController?.navigationBar.shadowImage = nil
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.tintColor = UIColor.black
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }
    }
    
    func getValueForRow(index:Int) -> (String, String) {
        switch index {
        case 0:
            return (title:columnTitleList[index], value:(propertyItemData.mls))
            
        case 1:
            return (title:columnTitleList[index], value:(propertyItemData.status))
            
        case 2:
            return (title:columnTitleList[index], value:(propertyItemData.compassPoint))
            
        case 3:
            return (title:columnTitleList[index], value:(propertyItemData.area))
            
        case 4:
            return (title:columnTitleList[index], value:(propertyItemData.zipCode))
            
        case 5:
            return (title:columnTitleList[index], value:(propertyItemData.zestimate))
            
        case 6:
            return (title:columnTitleList[index], value:(propertyItemData.zestimateRange))
            
        case 7:
            return (title:columnTitleList[index], value:(propertyItemData.taxes))
            
        case 8:
            return (title:columnTitleList[index], value:(propertyItemData.netCashFlow))
            
        case 9:
            return (title:columnTitleList[index], value:(propertyItemData.cashOnCash))
            
        case 10:
            return (title:columnTitleList[index], value:(propertyItemData.rentRatio))
            
        case 11:
            return (title:columnTitleList[index], value:(propertyItemData.debtCoverageRatio))
            
        case 12:
            return (title:columnTitleList[index], value:(propertyItemData.breakEvenRatio))
            
        case 13:
            return (title:columnTitleList[index], value:(propertyItemData.capitalizationRate))
            
        case 14:
            return (title:columnTitleList[index], value:(propertyItemData.listingMarketTime))
            
        case 15:
            return (title:columnTitleList[index], value:(propertyItemData.bedrooms))
            
        case 16:
            return (title:columnTitleList[index], value:(propertyItemData.fullBaths))
            
        case 17:
            return (title:columnTitleList[index], value:(propertyItemData.halfBaths))
            
        case 18:
            return (title:columnTitleList[index], value:(propertyItemData.aC))
            
        case 19:
            return (title:columnTitleList[index], value:(propertyItemData.propertyType))
            
        case 20:
            return (title:columnTitleList[index], value:(propertyItemData.parking))
            
        case 21:
            return (title:columnTitleList[index], value:(propertyItemData.garageOnSite))
            
        case 22:
            return (title:columnTitleList[index], value:(propertyItemData.vacancyRate))
            
        case 23:
            return (title:columnTitleList[index], value:(propertyItemData.management))
            
        case 24:
            return (title:columnTitleList[index], value:(propertyItemData.potentialGrossRental))
            
        case 25:
            return (title:columnTitleList[index], value:(propertyItemData.vacancyAllowance))
            
        case 26:
            return (title:columnTitleList[index], value:(propertyItemData.effectiveGrossIncome))
            
        case 27:
            return (title:columnTitleList[index], value:(propertyItemData.managementFee))
            
        case 28:
            return (title:columnTitleList[index], value:(propertyItemData.insurance))
            
        case 29:
            return (title:columnTitleList[index], value:(propertyItemData.assessmentAssociationDues))
            
        case 30:
            return (title:columnTitleList[index], value:(propertyItemData.propertyTaxesMonth))
            
        case 31:
            return (title:columnTitleList[index], value:(propertyItemData.totalExpenses))
            
        case 32:
            return (title:columnTitleList[index], value:(propertyItemData.noi))
            
        case 33:
            return (title:columnTitleList[index], value:(propertyItemData.totalDebtService))
            
        case 34:
            return (title:columnTitleList[index], value:(propertyItemData.netCashFlow1))
            
        case 35:
            return (title:columnTitleList[index], value:(propertyItemData.mortgageAmount))
            
        case 36:
            return (title:columnTitleList[index], value:(propertyItemData.mortgageTerm))
            
        case 37:
            return (title:columnTitleList[index], value:(propertyItemData.interestRate))
            
        case 38:
            return (title:columnTitleList[index], value:(propertyItemData.downPayment))
            
        case 39:
            return (title:columnTitleList[index], value:(propertyItemData.downPaymentAmount))
            
        case 40:
            return (title:columnTitleList[index], value:(propertyItemData.closingCostsFees))
            
        case 41:
            return (title:columnTitleList[index], value:(propertyItemData.remarks))
            
        default:
            return ("", "")
        }
    }
    
    
}

extension PropertyShowViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = Bundle.main.loadNibNamed("DynamicHeightTableViewCell", owner: self, options: nil)?.first as! DynamicHeightTableViewCell
//
//        let (titleString, valueString) = getValueForRow(index: indexPath.row)
//        cell.initWithData(title: titleString, value: valueString)
//
//        return cell
        switch indexPath.row {
        case 0:
            let cell = Bundle.main.loadNibNamed("PropertyHomeImageTableViewCell", owner: self, options: nil)?.first as! PropertyHomeImageTableViewCell
            cell.initWithData(property: propertyItemData)
            return cell
        case 1:
            let cell = Bundle.main.loadNibNamed("MoreHeightTableViewCell", owner: self, options: nil)?.first as! MoreHeightTableViewCell
            cell.initWithData(parent: self, remark: propertyItemData.remarks, isSelectedMore: isSelectedMoreButton)
            return cell
        case 2:
            let cell = Bundle.main.loadNibNamed("ClosingDateScrollViewHorizontalTableViewCell", owner: self, options: nil)?.first as! ClosingDateScrollViewHorizontalTableViewCell
            cell.initWithData(parent: self)
            return cell
        case 3:
            let cell = Bundle.main.loadNibNamed("TableViewTableViewCell", owner: self, options: nil)?.first as! TableViewTableViewCell
            cell.initWithParent(parent: self)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
