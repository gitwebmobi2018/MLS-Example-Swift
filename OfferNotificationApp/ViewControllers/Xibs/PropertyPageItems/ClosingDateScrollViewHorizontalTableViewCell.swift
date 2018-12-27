//
//  ClosingDateScrollViewHorizontalTableViewCell.swift
//  OfferNotificationApp
//
//  Created by gitwebmobi2018 on 2017-12-12.
//  Copyright © 2017 gitwebmobi2018 All rights reserved.
//

import UIKit

class ClosingDateScrollViewHorizontalTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Components
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // MARK: Properties
    
    var cellSelectionInfoArray = Array(repeating: false, count:15)
    
    var dateLabel = UILabel()
    var dayofweekLabel = UILabel()
    var monthLabel = UILabel()
    
    var parentVC = PropertyShowViewController()
    
    //MARK: Override Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myCollectionView.register(UINib(nibName: "ClosingDateFSPagerViewCell", bundle: nil), forCellWithReuseIdentifier: "ClosingDateFSPagerViewCell")
        myCollectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        cellSelectionInfoArray[0] = true
        let (dayStr, dayofweekStr, monthStr) = getClosingDateWithIndexRow(indexRow: 0)
        parentVC.setClosingDate(value:"\(monthStr) \(dayofweekStr) : \(dayStr)")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: MY FUNCTIONS
    
    func initWithData(parent: PropertyShowViewController) {
        parentVC = parent
    }
    
    func replaceSelectedCellInfoArray(index: Int) {
        let indexArray = 0...14
        for i in indexArray {
            cellSelectionInfoArray[i] = false
        }
        cellSelectionInfoArray[index] = true
    }
    
    func getClosingDateWithIndexRow(indexRow: Int) -> (String, String, String) {
        let utileTool = Utiles()
        let todayStr = utileTool.currentTimeString()
        let moreDay = utileTool.getMoreDayByValue(toDateStr: todayStr, value: indexRow+1)
        let (dayStr, dayofweekStr, monthStr) = utileTool.getDayFromDayMonth(dateStr: moreDay)
        return (dayStr, dayofweekStr, monthStr)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let (dayStr, dayofweekStr, monthStr) = getClosingDateWithIndexRow(indexRow: indexPath.row)
        parentVC.setClosingDate(value:"\(monthStr) \(dayofweekStr) : \(dayStr)")
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        let cell = collectionView.cellForItem(at: indexPath) as! ClosingDateFSPagerViewCell
        cell.selectedCellAction(isSelected: true)
        replaceSelectedCellInfoArray(index: indexPath.row)
        myCollectionView.reloadData()
    }
    
    //MARK: UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClosingDateFSPagerViewCell", for: indexPath) as! ClosingDateFSPagerViewCell
        let (dayStr, dayofweekStr, monthStr) = getClosingDateWithIndexRow(indexRow: indexPath.row)
        cell.initWithData(parent: self, isSelected: cellSelectionInfoArray[indexPath.row], dayString: dayStr, monthString: monthStr, dayofweekString: dayofweekStr)
        return cell
    }
    
}
