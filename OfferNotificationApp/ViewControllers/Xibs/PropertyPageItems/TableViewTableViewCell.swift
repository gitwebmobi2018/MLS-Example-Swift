//
//  TableViewTableViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2018-01-02.
//  Copyright © 2018gitwebmobi2018 All rights reserved.
//

import UIKit

class TableViewTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    // MARK: Components
    @IBOutlet weak var myTable: UITableView!
    
    //MARK: Properties
    var parentVC = PropertyShowViewController()
    
    //MARK: Override Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myTable.isScrollEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: My Functions
    func initWithParent(parent: PropertyShowViewController) {
        parentVC = parent
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            parentVC.showingSchedulBtnAction()
        case 1:
            parentVC.phoneCallBtnAction()
        case 2:
            parentVC.unlikeBtnAction()
        default:
            break
        }
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
//        cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.imageView?.image = #imageLiteral(resourceName: "showing_schedule@x32.png")
            cell.textLabel?.text = "Schedule Appointment"
        case 1:
            cell.imageView?.image = #imageLiteral(resourceName: "call@x32.png")
            cell.textLabel?.text = "Call Agent"
        case 2:
            cell.imageView?.image = #imageLiteral(resourceName: "unlike@x32.png")
            cell.textLabel?.text = "Feedback"
        default:
            cell = UITableViewCell()
        }
        
        return cell
    }
    
}
