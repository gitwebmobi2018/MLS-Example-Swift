import UIKit

let excelName = "Addison"
let excelPath = Bundle.main.path(forResource: excelName, ofType: "xlsx")

let columnList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU"]
let columnTitleList = ["MLS#", "Status", "Compass Point", "Area", "Zip Code", "Zestimate", "Zestimate Range", "Taxes", "Net Cash Flow(NOI-Total Debt Service)", "Cash-onCash % (Annual Income/Cash Invested)", "Rent Ratio%(Potential Gross Rent/ List Price)", "Debt Coverage Ratio(NOI/ Total Debt Service)", "Break-even Ratio %(Expenses + Total Debt Service)/ Effective Gross Income", "Capitalization Rate%", "Listing Market Time", "#Bedrooms", "#Full Baths", "#Half Baths", "A/C", "Property Type", "Parking", "Garage On-Site", "Vacancy Rate%", "Management%", "Potential Gross Rent", "Vacancy Allowance", "Effective Gross Income(Potential Gross Rent-Vacancy Allowance)", "Management Fee", "Insurance", "Assessment/Association Dues", "Property Taxes/Month", "Total Expenses", "Net Operating Income or NOI(Effective Gross Income-Total Expenses)", "Total Debt Service(Principal + Interest)", "Net Cash Flow(NOI_Total Debt Service)", "Mortgage Amount", "Mortgage Term", "Interest Rate%", "Down Payment%", "Down Payment Amount", "Closing Costs Fees%", "Remarks"]

let itemPricePreString = "Price : "

//MARK: TableView's Contants
let saveKeyForNotificationViewArrayData = "NotificationViewArraySaveKey"
let notificationTableViewCellIdentifyKey = "NotificationTableViewCell"

let dynamicTableViewCellIdentifyKey = "DynamicHeightCell"

let propertyTableViewCellIdentifyKey = "PropertyTableViewCell"

//MARK: Send email address
let destinationEmailAddress = "mrjavaman@hotmail.com"
