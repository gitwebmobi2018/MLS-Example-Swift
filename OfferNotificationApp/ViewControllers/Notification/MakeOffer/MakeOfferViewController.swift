import UIKit
import MessageUI

class MakeOfferViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var earnestMoneyTextField: UITextField!
    @IBOutlet weak var closingDatePicker: UIDatePicker!
    
    var priceValue = String()
    var earnestMoneyValue = String()
    var closingDateValue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initKeyBoard()
        initDate()
        initNotification()
        //startLogoAnimation()
        modalPresentationCapturesStatusBarAppearance = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: My Functions
    
    func initNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
//        scrollView.isScrollEnabled = false
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top:0.0, left:0.0, bottom:keyboardSize.height, right:0.0)
            scrollView.contentInset = contentInsets
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: 0,
                                               right: 0)
    }
    
    func initDate() {
        closingDatePicker.minimumDate = Date()
        closingDatePicker.date = Date()
        closingDateValue = getDateValue(dateValue: Date())
    }
    
    func getDateValue(dateValue: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let resultString = formatter.string(from: dateValue)
        return resultString
    }
    
    func initKeyBoard() {
        let toolbarDone = UIToolbar.init()
        toolbarDone.barStyle = UIBarStyle.blackTranslucent
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(hideTextFieldKeyBoard))
        done.tintColor = UIColor.white
        
        let items = NSMutableArray()
        items.add(flexSpace)
        items.add(done)
        
        toolbarDone.items = items as? [UIBarButtonItem]
        toolbarDone.sizeToFit()
        priceTextField.inputAccessoryView = toolbarDone
        earnestMoneyTextField.inputAccessoryView = toolbarDone
    }
    
    @objc func hideTextFieldKeyBoard() {
        priceTextField.resignFirstResponder()
        earnestMoneyTextField.resignFirstResponder()
    }
    
    func startLogoAnimation() {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
//            self.logoImageViewXPositionConstraints.constant = self.view.frame.size.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func checkingValues() -> Bool{
        if priceValue.count == 0 || earnestMoneyValue.count == 0 {
            return false
        } else {
            return true
        }
    }
    
    //MARK: My Event Functions
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        closingDateValue = getDateValue(dateValue: closingDatePicker.date)
    }
    
    @IBAction func sendEmailAction(_ sender: Any) {
        if checkingValues() {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients([destinationEmailAddress])
                
                let strForTitleFieldCSS = "<div style='background-color: white;box-shadow: chocolate;border: 1px solid grey;margin: 5px; margin-bottom: 15px;padding-left: 10px;box-shadow: 0 6px 10px 0 rgba(0, 0, 0, 0.5), 0 12px 16px 0 rgba(0, 0, 0, 0.5);padding-bottom: 20px;'><h2 style='font-family: cursive;color: #a5af08;border-bottom: 1px solid #a5af08;text-align: center;margin-right: 10px;padding-bottom: 10px;font-size: 17px;'>"
                
                let strForNextSchedule = "<p align = 'center' style = 'color: grey; font-size: 17px'>Price : $ \(priceValue) <br> Earnest Money : $ \(earnestMoneyValue) <br> Closing Date : \(closingDateValue) </p>"
                
                mail.setMessageBody("<html><body>\(strForTitleFieldCSS) Offer Details </h2>\(strForNextSchedule)</div><div style=\"display: flex;align-items: center;justify-content: center;\"><img src=\"https://mlsdealanalyzer.com/wp-content/themes/mls-deal-analyzer/images/logo.png\"><div></body></html>", isHTML: true)
                present(mail, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Warning!", message: "You can not send email from your email client compose for now.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                present(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Warning!", message: "Price & Earnest Money are mandatory. Please input those.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        
        switch textField  {
        case self.priceTextField:
            priceValue = txtAfterUpdate as String
            break
        case self.earnestMoneyTextField:
            earnestMoneyValue = txtAfterUpdate as String
            break
        default:
            break
        }
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
