import UIKit
import UserNotifications

class NotificationViewController: UIViewController, UITableViewDelegate, UNUserNotificationCenterDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemsNumLabel: UILabel!
    @IBOutlet weak var numberOfCellTopView: UIView!
    @IBOutlet weak var scrollTopBtn: UIButton!
    
    var refresher: UIRefreshControl!
    
    var dataArray = [ExcelItem]()
    var showingNumber = 1
    var numOfCells = 0
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.notificationViewController = self
        
        UNUserNotificationCenter.current().delegate = self
        
        UIApplication.shared.statusBarStyle = .default
        self.tabBarController?.tabBar.tintColor = UIColor(red: 12/255, green: 19/255, blue: 118/255, alpha: 1)
        
        tableView.flashScrollIndicators()
        
        initRefreshController()
        initLayout()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIApplication.shared.statusBarStyle = .default
        
        showingNumber = 1
        loadViewArray()
        if DataManagement.sharedInstance.dataArray.count == 0 {
            self.showLoadingBar()
            
            DispatchQueue.main.async {
                self.perform(#selector(self.loadAndHideIndicator), with: nil, afterDelay: 3)
            }
        }
        
        tableViewReload()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    // MARK: My Functions
    
    func initLayout() {
        numberOfCellTopView.layer.borderWidth = 0.5
        numberOfCellTopView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func initRefreshController() {
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
//        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.tintColor = UIColor.lightGray
        refresher.addTarget(self, action: #selector(self.completeBoroghArray), for: .valueChanged)
    }
    
    @objc func completeBoroghArray() {
        showingNumber += 1
        tableViewReload()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(endRefreshController), userInfo: nil, repeats: false)
    }
    
    @objc func endRefreshController() {
        refresher.endRefreshing()
    }
    
    @objc func loadAndHideIndicator() {
        DataManagement.sharedInstance.loadExcelList()
        self.hideLoadingBar()
    }
    
    func saveViewArray() {
        let dataToSave = NSKeyedArchiver.archivedData(withRootObject: dataArray)
        UserDefaults.standard.set(dataToSave, forKey: saveKeyForNotificationViewArrayData)
    }
    
    func loadViewArray() {
        if let savedData = UserDefaults.standard.object(forKey: saveKeyForNotificationViewArrayData) as? NSData {
            dataArray = NSKeyedUnarchiver.unarchiveObject(with: savedData as Data) as! [ExcelItem]
            return
        }
    }
    
    func showLoadingBar() {
        overlayView = UIView(frame: view.frame)
        overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0.8
        
        activityIndicator.frame = CGRect(x: (overlayView.frame.size.width)/2-25, y: (overlayView.frame.size.height)/2-25, width: 50, height: 50)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        overlayView.addSubview(activityIndicator)
        view.addSubview(overlayView)
        activityIndicator.startAnimating()
    }
    
    func hideLoadingBar() {
        activityIndicator.stopAnimating()
        overlayView.removeFromSuperview()
    }
    
    func tableViewReload() {
        
        if dataArray.count == 0 {
            tableView.isHidden = true
        } else {
            sortViewArray()
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    func insertNewItemToViewArray() {
        
        if dataArray.count < 54 {
            let item = DataManagement.sharedInstance.dataArray[dataArray.count]
//            item.generatedTime = currentTimeString()
            dataArray.insert(item, at: 0)
        } else {
            let index = Int(arc4random_uniform(54))
            let item = dataArray[index]
//            item.generatedTime = currentTimeString()
            item.identifyKey = "New"
            dataArray.remove(at: index)
            dataArray.insert(item, at: 0)
        }
        saveViewArray()
    }
    
    func replaceOldItem(index: Int) {
        let item = dataArray[index]
        item.identifyKey = ""
        dataArray[index] = item
        saveViewArray()
    }
    
    func sortViewArray() {
        var newItemsArray = [ExcelItem]()
        var oldItemsArray = [ExcelItem]()
        
        for item in dataArray {
            if item.identifyKey == "New" {
                newItemsArray.append(item)
            } else {
                oldItemsArray.append(item)
            }
        }
        
        var sortedArray = [ExcelItem]()
        var indexArray = [Int]()
        
        for item in oldItemsArray {
            indexArray.append(item.index)
        }
        indexArray.sort()
        
        for row in indexArray {
            for item in oldItemsArray {
                if item.index == row {
                    sortedArray.append(item)
                }
            }
        }
        
        newItemsArray.append(contentsOf: sortedArray)
        dataArray.removeAll()
        dataArray = newItemsArray
        saveViewArray()
    }
    
    //MARK: My Touch Event Functions
    
    @IBAction func scrollToTopTouch(_ sender: Any) {
        let indexpathForbottom = IndexPath(item: 0, section: 0)
        tableView.scrollToRow(at: indexpathForbottom, at: .top, animated: true)
    }
    // MARK: UserNotificationsDelegate
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        insertNewItemToViewArray()
        tableViewReload()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y > tableView.contentSize.height/3 {
            self.scrollTopBtn.alpha = 1
        } else {
            self.scrollTopBtn.alpha = 0
        }
    }
    
    // MARK: UITableViewDelegate
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 252
        default:
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            replaceOldItem(index: indexPath.row)
            performSegue(withIdentifier: "PropertySegue", sender: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let propertyVC = segue.destination as! PropertyShowViewController
        let selectedIndex = (tableView.indexPathForSelectedRow?.row)!
        propertyVC.propertyItemData = dataArray[selectedIndex]
    }
    
}

// MARK: UITableViewDataSource

extension NotificationViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if showingNumber * 10 >= dataArray.count {
                numOfCells = dataArray.count
            } else {
                numOfCells = showingNumber * 10
            }
            itemsNumLabel.text = "\(numOfCells) open sales."
            return numOfCells
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = Bundle.main.loadNibNamed("PropertyHomeImageTableViewCell", owner: self, options: nil)?.first as! PropertyHomeImageTableViewCell
            cell.initWithData(property: dataArray[indexPath.row])
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "RowNumberCell")
            cell.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
            cell.textLabel?.text = "\(numOfCells) listed"
            cell.textLabel?.textColor = UIColor.darkGray
            cell.selectionStyle = .none
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
