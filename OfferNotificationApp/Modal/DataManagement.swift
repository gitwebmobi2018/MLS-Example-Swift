import UIKit

class DataManagement: NSObject {
    
    static let sharedInstance = DataManagement ()
    
    public var dataArray : [ExcelItem]
    public var dataDicArray : [[String : String]]
    
    override init() {
        dataArray = [ExcelItem]()
        dataDicArray = [[String:String]]()
    }
    
    func saveShoppingList() {
        let defaults = UserDefaults.standard
        let itemsToSave = loadCellToExcelModel()
        let dataToSave = NSKeyedArchiver.archivedData(withRootObject: itemsToSave)
        defaults.set(dataToSave, forKey: "ITEMS")
    }
    
    func loadExcelList() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "ITEMS") as? NSData {
            dataArray = NSKeyedUnarchiver.unarchiveObject(with: savedData as Data) as! [ExcelItem]
            return
        } else {
            saveShoppingList()
            loadExcelList()
        }
    }
    
    func loadCellToExcelModel() -> [ExcelItem] {
        let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(excelPath)
        let worksheet: BRAWorksheet = spreadsheet.workbook.worksheets[0] as! BRAWorksheet
        
        var excelItemsArray = [ExcelItem]()
        
        for row in 3..<57 {
            
            let item = ExcelItem()
            
            item.index = row - 3
            
            for column in columnList {
                
                let cell = column + String(row)
                
                
                switch (column){
                case "A":
                    let itemData = worksheet.image(forCellReference: cell)
                    
                    if itemData != nil {
                        let image: UIImage = worksheet.image(forCellReference: cell).uiImage
                        item.homeImageColor = image
                    }
                    break
                case "B":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.mls = (itemData?.stringValue())!
                    break
                case "C":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.status = (itemData?.stringValue())!
                    break
                case "D":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.street = (itemData?.stringValue())!
                    break
                case "E":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.compassPoint = (itemData?.stringValue())!
                    break
                case "F":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.streetName = (itemData?.stringValue())!
                    break
                case "G":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.city = (itemData?.stringValue())!
                    break
                case "H":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.area = (itemData?.stringValue())!
                    break
                case "I":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.listPrice = (itemData?.stringValue())!
                    break
                case "J":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.zipCode = (itemData?.stringValue())!
                    break
                case "K":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.zestimate = (itemData?.stringValue())!
                    break
                case "L":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.zestimateRange = (itemData?.stringValue())!
                    break
                case "M":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.taxes = (itemData?.stringValue())!
                    break
                case "N":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.netCashFlow = (itemData?.stringValue())!
                    break
                case "O":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.cashOnCash = (itemData?.stringValue())!
                    break
                case "P":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.rentRatio = (itemData?.stringValue())!
                    break
                case "Q":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.debtCoverageRatio = (itemData?.stringValue())!
                    break
                case "R":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.breakEvenRatio = (itemData?.stringValue())!
                    break
                case "S":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.capitalizationRate = (itemData?.stringValue())!
                    break
                case "T":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.listingMarketTime = (itemData?.stringValue())!
                    break
                case "U":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.bedrooms = (itemData?.stringValue())!
                    break
                case "V":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.fullBaths = (itemData?.stringValue())!
                    break
                case "W":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.halfBaths = (itemData?.stringValue())!
                    break
                case "X":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.aC = (itemData?.stringValue())!
                    break
                case "Y":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.propertyType = (itemData?.stringValue())!
                    break
                case "Z":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.parking = (itemData?.stringValue())!
                    break
                case "AA":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.garageOnSite = (itemData?.stringValue())!
                    break
                case "AB":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.vacancyRate = (itemData?.stringValue())!
                    break
                case "AC":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.management = (itemData?.stringValue())!
                    break
                case "AD":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.potentialGrossRental = (itemData?.stringValue())!
                    break
                case "AE":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.vacancyAllowance = (itemData?.stringValue())!
                    break
                case "AF":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.effectiveGrossIncome = (itemData?.stringValue())!
                    break
                case "AG":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.managementFee = (itemData?.stringValue())!
                    break
                case "AH":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.insurance = (itemData?.stringValue())!
                    break
                case "AI":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.assessmentAssociationDues = (itemData?.stringValue())!
                    break
                case "AJ":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.propertyTaxesMonth = (itemData?.stringValue())!
                    break
                case "AK":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.totalExpenses = (itemData?.stringValue())!
                    break
                case "AL":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.noi = (itemData?.stringValue())!
                    break
                case "AM":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.totalDebtService = (itemData?.stringValue())!
                    break
                case "AN":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.netCashFlow1 = (itemData?.stringValue())!
                    break
                case "AO":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.mortgageAmount = (itemData?.stringValue())!
                    break
                case "AP":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.mortgageTerm = (itemData?.stringValue())!
                    break
                case "AQ":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.interestRate = (itemData?.stringValue())!
                    break
                case "AR":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.downPayment = (itemData?.stringValue())!
                    break
                case "AS":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.downPaymentAmount = (itemData?.stringValue())!
                    break
                case "AT":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.closingCostsFees = (itemData?.stringValue())!
                    break
                case "AU":
                    let itemData = worksheet.cell(forCellReference: cell)
                    item.remarks = (itemData?.stringValue())!
                    break
                    default:
                        break
                }
                
            }
            excelItemsArray.append(item)
        }
        return excelItemsArray
    }
    
    // Calculator
    
    var windowSize = CGSize.zero
    var expired = false
    
    var flipSubSliderViewCell = FlipSliderTableViewCell()
    
    var keyboardHide = true
    var viewMode_Flip = "Input"
    var viewMode_Cash = "Input"
    
    // MARK: Flip Calculator Data - PART 1
    
    func hideTextF() {
        flipSubSliderViewCell.hideTextField()
    }
    let flip_CalculationMode = [
        "Flip - Flip Max",
        "Flip - Cash Flow",
        "Auction - Flip Max",
        "Auction - Cash Flow",
        "Definitions",
        "Input"
    ]
    let flip_flipMax_InputTitleArray = [
        "ARV",
        "Hold Time",
        "Purchase Cost",
        "Finance Cost/mo",
        "Prop.Taxes/mo",
        "Ins./mo",
        "Rehab Cost",
        "Rehab Overrun",
        "Utilities Etc",
        "Commissions",
        "Closing,Attorney Etc",
        "Desired Profit"
    ]
    let flip_cashFlow_InputTitleArray = [
        "ARV",
        "Hold Time",
        "Purchase Cost",
        "Finance Cost/mo",
        "Prop.Taxes/mo",
        "Ins./mo",
        "Rehab Cost",
        "Rehab Overrun",
        "Utilities Etc",
        "Commissions",
        "Closing,Attorney Etc",
        "Desired Equity"
    ]
    
    var flip_ValueArray = [
        "200000","5","1500", "1200","380","50","41000","0","100","3","3000","26000"
    ]
    
    func valueSet(value: String, valueIndex: Int) -> String {
        var valueString = ""
        switch valueIndex {
        case 0:
            valueString = "$\(value)"
            break
        case 1:
            valueString = "\(value) months"
            break
        case 2:
            valueString = "$\(value)"
            break
        case 3:
            valueString = "$\(value)"
            break
        case 4:
            valueString = "$\(value)"
            break
        case 5:
            valueString = "$\(value)"
            break
        case 6:
            valueString = "$\(value)"
            break
        case 7:
            //            let numberFormatter = NumberFormatter()
            //            numberFormatter.maximumFractionDigits = 2
            //            numberFormatter.minimumIntegerDigits = 1
            //            let valueFloat = "\(String(describing: numberFormatter.string(from: NSNumber(value: (value as NSString).floatValue))!))"
            valueString = "\(value)%"
            break
        case 8:
            valueString = "$\(value)"
            break
        case 9:
            valueString = "\(value)%"
            break
        case 10:
            valueString = "$\(value)"
            break
        case 11:
            valueString = "$\(value)"
            break
        case 12:
            valueString = "$\(value)"
            break
            
        default:
            break
        }
        return valueString
    }
    
    
    let flip_Flipping_FlipMaxCalculator = [
        "After Repair Value",
        "Acquasition Costs",
        "Repair Costs",
        "Finance Cost",
        "Carrying Costs",
        "Cost Over Runs",
        "Selling Costs",
        "Desired Profit",
        "Total Cost",
        "Max Offer"
    ]
    var flip_Flipping_FlipMaxCalculator_Values = [String]()
    public func flip_Flipping_FlipMaxCalculator_GetValueArray() {
        self.flip_Flipping_FlipMaxCalculator_Values = AndrewFlippingCalculator_FlipMaxCalculator(array: self.flip_ValueArray)
    }
    
    let flip_Flipping_CashFlow = [
        "After Repair Value",
        "Acquasition Costs",
        "Repair Costs",
        "Finance Cost",
        "Carrying Costs",
        "Cost Over Runs",
        "Desired Equity",
        "Total Cost",
        "Max Offer"
    ]
    var flip_Flipping_CashFlow_Values = [String]()
    public func flip_Flipping_CashFlow_GetValueArray() {
        self.flip_Flipping_CashFlow_Values = AndrewFlippingCalculator_CashFlowCalculator(array: self.flip_ValueArray)
    }
    
    //    let flip_Auction_FlipMaxCalculator = [
    //        "After Repair Value",
    //        "Acquasition Costs",
    //        "Repair Costs",
    //        "Finance Cost",
    //        "Carrying Costs",
    //        "Auction Tax Costs",
    //        "Cost Over Runs",
    //        "Selling Costs",
    //        "Desired Profit",
    //        "Total Cost",
    //        "Max Offer"
    //    ]
    //    var flip_Auction_FlipMaxCalculator_Values = [String]()
    //    public func flip_Auction_FlipMaxCalculator_GetValueArray() {
    //        self.flip_Auction_FlipMaxCalculator_Values = AndrewAuctionCalculator_FlipMaxCalculator(array: self.flip_ValueArray)
    //    }
    //
    //    let flip_Auction_CashFlow = [
    //        "After Repair Value",
    //        "Acquasition Costs",
    //        "Repair Costs",
    //        "Finance Cost",
    //        "Carrying Costs",
    //        "Auction Tax Costs",
    //        "Cost Over Runs",
    //        "Desired Equity",
    //        "Total Cost",
    //        "Max Offer"
    //    ]
    //    var flip_Auction_CashFlow_Values = [String]()
    //    public func flip_Auction_CashFlow_GetValueArray() {
    //        self.flip_Auction_CashFlow_Values = AndrewAuctionCalculator_CashFlowCalculator(array: self.flip_ValueArray)
    //    }
    
    let flip_Definitions_Tilte = [
        "After Repair Value(ARV)",
        "Total Hold Time",
        "Purchase Related Costs",
        "Finance Cost",
        "Property Taxes Per Month",
        "Insurance Per Month",
        "Rehab Costs",
        "Rehab Overrun",
        "Other Expenses Per Monthly Expenses",
        "Commissions Cost For Selling",
        "Closing Costs",
        "Desired Profit",
        "Rental Equity",
        
        "Capitalization Rate",
        "Cash Flow(Annual)",
        "Debt Service",
        "Effective Gross Income",
        "Gross Income",
        "Net Operating Income",
        "Operating Expenses",
        "Vacancy Rate",
        "Return On Investment",
        "Gross Rent Multiplier",
        "Breakeven Point(%)",
        "Debt Coverage Ratio"
    ]
    let flip_Definitions_content = [
        "Current market value after rehab is done. ",
        "Flip - How long do you intend to take to rehab       and resell the property or have it rented and refinanced.This value is entered in # of months. Cashflow – How long to rehab, rent and refinance",
        "Purchase related attorney or title expenses or any other expenses you are going to incur.(Typical $2000)",
        "What do you expect your monthly finance cost to be.\n Even if you are paying cash do you want to pay yourself something for using your own capital.(Typical 12% per month)",
        "What is your monthly Tax Burden.",
        "Your monthly costs for insurance.",
        "How much rehab do you expect to do.",
        "0 - 35% (Our suggestion is unless you are 100% certain about your numbers at least use a 10% as default rehab overruns cost.)",
        "utilities, HOA fees.",
        "What do you expect to pay for commission this should be a minimum of 2.5% to 6% depending on how much you will pay the agent.",
        "This should included any transfer taxes or fees, title charges, attorney fees or other misc costs.",
        "What would you like to make in terms of profit.(**Per $ 100K invested net profit of $ 15k for a 6 month time frame is a good start)",
        "After purchase and rehab how much equity would you like to have.(Typical 15% of ARV)",
        
        "NOI/Sales Price.     [If you paid all cash, what return would you make?]",
        "NOI - debt service",
        "Monthly mortgage payment X 12",
        "Income - (vacancy rate % X income)",
        "All income, including rents(fully occupied), fees, vending machine sales, late fees, etc.",
        "Eff. Gross Income - Operating Expenses   [Waht is left after expenses to pay the mortgage]",
        "Taxes, insurance, utilities, management fees, payroll, landscaping, maintenance, supplies, repairs.    Excludes mortgage payments or interest expense.",
        "Number of vacancies X the number of units.",
        "Net proft(including all expenses and debt service)/cash invested in the deal",
        "Purchase Price / Effective Gross Income",
        "(Operating expenses + annual mortgage payments)/gross potential income",
        "NOI/Debt Service"
    ]
    
    func AndrewFlippingCalculator_FlipMaxCalculator(array:[String]) -> [String] {
        
        let first = (array[0] as NSString).integerValue
        let second = (array[2] as NSString).integerValue
        let third = (array[6] as NSString).integerValue
        let forth = (array[1] as NSString).integerValue*(array[3] as NSString).integerValue
        let fifth = (array[1] as NSString).integerValue*((array[4] as NSString).integerValue+(array[5] as NSString).integerValue+(array[8] as NSString).integerValue)
        let sixth = Int(roundf((array[6] as NSString).floatValue*(array[7] as NSString).floatValue)/100)
        let seventh = Int(roundf((array[0] as NSString).floatValue*(array[9] as NSString).floatValue)/100)
        let eighth = (array[11] as NSString).integerValue
        let ninth = second+third+forth+fifth+sixth+seventh+eighth
        let tenth = first-ninth
        
        let resultArray = [
            "\(first)","\(second)","\(third)","\(forth)","\(fifth)","\(sixth)","\(seventh)","\(eighth)","\(ninth)","\(tenth)"
        ]
        return resultArray
    }
    func AndrewFlippingCalculator_CashFlowCalculator(array:[String]) -> [String] {
        
        let first = (array[0] as NSString).integerValue
        let second = (array[2] as NSString).integerValue
        let third = (array[6] as NSString).integerValue
        let forth = (array[1] as NSString).integerValue*(array[3] as NSString).integerValue
        let fifth = (array[1] as NSString).integerValue*((array[4] as NSString).integerValue+(array[5] as NSString).integerValue+(array[8] as NSString).integerValue)
        let sixth = Int(roundf((array[6] as NSString).floatValue*(array[7] as NSString).floatValue)/100)
        //        let seventh = (array[12] as NSString).integerValue
        let seventh = (array[11] as NSString).integerValue
        let eighth = second+third+forth+fifth+sixth+seventh
        let ninth = first-eighth
        
        let resultArray = [
            "\(first)","\(second)","\(third)","\(forth)","\(fifth)","\(sixth)","\(seventh)","\(eighth)","\(ninth)"
        ]
        
        return resultArray
    }
    //    func AndrewAuctionCalculator_FlipMaxCalculator(array:[String]) -> [String] {
    //
    //        let first = (array[0] as NSString).floatValue
    //        let second = (array[2] as NSString).floatValue*2.5
    //        let third = (array[6] as NSString).floatValue
    //        let forth = (array[1] as NSString).floatValue*(array[3] as NSString).floatValue
    //        let fifth = (array[1] as NSString).floatValue*((array[4] as NSString).floatValue+(array[5] as NSString).floatValue+(array[8] as NSString).floatValue)
    //        let sixth = (array[4] as NSString).floatValue*12
    //        let seventh = (array[6] as NSString).floatValue*(array[7] as NSString).floatValue
    //        let eighth = (array[0] as NSString).floatValue*(array[9] as NSString).floatValue / 100
    //        let ninth = (array[11] as NSString).floatValue
    //        let tenth = second+third+forth+fifth+sixth+seventh+eighth+ninth
    //        let eleventh = first-tenth
    //
    //        let resultArray = [
    //            "\(first)","\(second)","\(third)","\(forth)","\(fifth)","\(sixth)","\(seventh)","\(eighth)","\(ninth)","\(tenth)","\(eleventh)",
    //        ]
    //
    //        return resultArray
    //    }
    //    func AndrewAuctionCalculator_CashFlowCalculator(array:[String]) -> [String] {
    //
    //        let first = (array[0] as NSString).floatValue
    //        let second = (array[2] as NSString).floatValue*2.5
    //        let third = (array[6] as NSString).floatValue
    //        let forth = ((array[1] as NSString).floatValue*(array[3] as NSString).floatValue) + 2500
    //        let fifth = (array[1] as NSString).floatValue*((array[4] as NSString).floatValue+(array[5] as NSString).floatValue+(array[8] as NSString).floatValue)
    //        let sixth = (array[4] as NSString).floatValue*12
    //        let seventh = (array[6] as NSString).floatValue*(array[7] as NSString).floatValue
    //        let eighth = (array[12] as NSString).floatValue
    //        let ninth = second+third+forth+fifth+sixth+seventh+eighth
    //        let tenth = first-ninth
    //
    //        let resultArray = [
    //            "\(first)","\(second)","\(third)","\(forth)","\(fifth)","\(sixth)","\(seventh)","\(eighth)","\(ninth)","\(tenth)"
    //        ]
    //
    //        return resultArray
    //    }
    
    // MARK: PART 2 - Cash Flow Calculator
    
    var cashSliderCell = CashFlowSliderTableViewCell()
    
    func cashHideTextF() {
        cashSliderCell.hideTextField()
    }
    
    let cash_input_titleArray = [
        
        "Financial Data:",
        "Purchase Price",
        "Rehab. Cost",
        "Estimated ARV",
        "LTV",
        "Interest Rate",
        "Loan Term/yr",
        
        "Gross Income:",
        "Rent",
        "Vacancy",
        
        "Operating Expenses:",
        "Prop.Taxes/yr",
        "Insurance/yr",
        "Repairs(Annual)",
        "HOA",
        "Mgmt Fee/mo",
        "Inflation Rate",
        
        "Loan Details:"
    ]
    
    var cash_valueArray = [
        "section1","120000", "0", "170000", "75", "4", "30",
        "section2","1350", "0",
        "section3","600", "12", "0", "400", "0", "3"
    ]
    
    let cash_first_titleArray = [
        "Mortgage Amount:", "Cash in Deal:", "Mortgage Payment(monthly)", "Gross Income(annual):", "Vacancy Rate:", "Occupancy Rate:", "Effective Gross Income:", "Association Fees(Annual):", "Management Fees(Annual):", "Total Operating Expenses:"
    ]
    var cash_first_valueArray = [String]()
    public func cash_first_GetValueArray() {
        let first = roundf(((cash_valueArray[1] as NSString).floatValue+(cash_valueArray[2] as NSString).floatValue)<((cash_valueArray[3] as NSString).floatValue*(cash_valueArray[4] as NSString).floatValue/100) ? ((cash_valueArray[1] as NSString).floatValue+(cash_valueArray[2] as NSString).floatValue) : ((cash_valueArray[3] as NSString).floatValue*(cash_valueArray[4] as NSString).floatValue/100))
        let second = Int(roundf((cash_valueArray[1] as NSString).floatValue+(cash_valueArray[2] as NSString).floatValue-first))
        let third = roundFloatValue(value: "\(pmt(rate: ((cash_valueArray[5] as NSString).doubleValue/12)/100, nper: (cash_valueArray[6] as NSString).doubleValue*12, pv: Double(first)))")
        
        let forth = (cash_valueArray[8] as NSString).floatValue*12
        let fifth = (cash_valueArray[9] as NSString).floatValue
        let sixth = (1 - fifth)*100
        let seventh = Int(roundf(forth*sixth/100))
        
        let eighth = (cash_valueArray[14] as NSString).floatValue*12
        let ninth = roundFloatValue(value: "\((cash_valueArray[15] as NSString).floatValue*12/100)")
        
        let tenth = (cash_valueArray[11] as NSString).floatValue+(cash_valueArray[12] as NSString).floatValue+(cash_valueArray[13] as NSString).floatValue+eighth+(ninth as NSString).floatValue
        cash_first_valueArray = [
            "\(Int(first))","\(second)", third,"\(Int(forth))","\(fifth)","\(sixth)","\(seventh)","\(eighth)", ninth,"\(tenth)",
        ]
    }
    let cash_summary_titleArray = [
        "NOI(annual, w/o loan):", "NOI(monthly,w/o laon):", "Princial+Interest", "Net Cash Flow", "Cash On Cash Return:", "Cap Rate:", "Cash Flow(annual):", "Cash Flow(monthly):", "Years to  Earn back Down Pm", "Breakeven Point:", "Debt Coverage Ratio:", "Andrew's (75%)Formula", "CashFlow as % of Rent(25%)"
    ]
    var cash_summary_valueArray = [String]()
    public func cash_summary_GetValueArray() {
        let first = (cash_first_valueArray[6] as NSString).floatValue - (cash_first_valueArray[9] as NSString).floatValue
        let second = first/12
        let third = round(pmt(rate: ((cash_valueArray[5] as NSString).doubleValue/12)/100, nper: (cash_valueArray[6] as NSString).doubleValue*12, pv: (cash_first_valueArray[0] as NSString).doubleValue))
        let forth = roundf((cash_valueArray[8] as NSString).floatValue-(Float(third)+((cash_first_valueArray[9] as NSString).floatValue/12)))
        let fifth = (cash_first_valueArray[1] as NSString).floatValue>0 ? (first-(cash_first_valueArray[2] as NSString).floatValue*12)/(cash_first_valueArray[1] as NSString).floatValue : 0.0
        let sixth = roundFloatValue(value: "\(first/((cash_valueArray[1] as NSString).floatValue+(cash_valueArray[2] as NSString).floatValue)*100)")
        
        let seventh = Int(roundf((second-(cash_first_valueArray[2] as NSString).floatValue)*12))
        let eighth = Int(roundf(second-(cash_first_valueArray[2] as NSString).floatValue))
        
        let ninth = (cash_first_valueArray[1] as NSString).floatValue>0 ? 1/fifth : 0.0
        let tenth = Int(roundf(((cash_first_valueArray[9] as NSString).floatValue+(cash_first_valueArray[2] as NSString).floatValue*12)/(cash_first_valueArray[3] as NSString).floatValue*100))
        
        let eleventh = roundFloatValue(value: "\(first/((cash_first_valueArray[2] as NSString).floatValue*12))")
        let twelfth = Int(roundf((Float(third)+((cash_first_valueArray[9] as NSString).floatValue/12))/(cash_valueArray[8] as NSString).floatValue*100))
        let thirteenth = Int(roundf(forth/(cash_valueArray[8] as NSString).floatValue*100))
        
        cash_summary_valueArray = [
            "\(Int(first))","\(Int(second))","\(Int(third))","\(Int(forth))","\(fifth)", sixth,"\(seventh)","\(eighth)","\(ninth)","\(tenth)", eleventh,"\(twelfth)","\(thirteenth)"
        ]
    }
    public func cash_projection_getValue(intialValue: String) -> [String] {
        if intialValue == "Intial Value" {
            let salePrice = "\(Int(roundf((cash_valueArray[3] as NSString).floatValue)))"
            let sellingCosts = Int(roundf((salePrice as NSString).floatValue*0.07))
            let profitFromSale = (salePrice as NSString).integerValue - Int(roundf((cash_valueArray[1] as NSString).floatValue)) - Int(roundf((cash_valueArray[2] as NSString).floatValue)) - sellingCosts
            let resultArray = [
                intialValue,"\(salePrice)", "\(sellingCosts)", "0", "\(profitFromSale)", "\(profitFromSale)"
            ]
            return resultArray
        } else {
            let salePrice = round(fv(rate: 0.03, nper: (intialValue as NSString).doubleValue, pmt : 0.0, pv : (cash_valueArray[3] as NSString).doubleValue))
            let sellingCosts = Int(roundf(Float(salePrice)*0.07))
            let netCashFlow = Int(roundf((cash_summary_valueArray[3] as NSString).floatValue))*((intialValue as NSString).integerValue*12-6)
            let profitFromSale = Int(salePrice) - (cash_valueArray[1] as NSString).integerValue - (cash_valueArray[2] as NSString).integerValue - Int(sellingCosts)
            let totalProfit = netCashFlow+profitFromSale
            let resultArray = [
                intialValue,"\(Int(salePrice))","\(sellingCosts)","\(netCashFlow)","\(profitFromSale)","\(totalProfit)"
            ]
            return resultArray
        }
    }
    
    let loan_input_titleArray = [
        "Loan amount",
        "Anual interest rate",
        "Loan period in years",
        "Start date of loan",
        "Optional extra payment"
    ]
    var loan_valueArray = [
        "120000","4","30","01/01/2015","326"
    ]
    func loan_getValueArray() {
        cash_first_GetValueArray()
        cash_summary_GetValueArray()
        let first = cash_first_valueArray[0]
        let second = cash_valueArray[5]
        let third = cash_valueArray[6]
        let forth = loan_valueArray[3]
        let fifth = cash_summary_valueArray[3]
        loan_valueArray = [
            first, second, third, forth, fifth
        ]
    }
    let loan_first_titleArray = [
        "Scheduled monthly payment", "Scheduled number of payments", "Actual number of payments", "Total of early payments", "Total interest"
    ]
    var valuesOfArrays = [[String]()]
    func loan_first_sumOfInterest() -> String {
        loan_table_first_getValue()
        valuesOfArrays = [
            loan_table_fristValue
        ]
        var sum : Float = 0.0
        for index in 2...178 {
            valuesOfArrays.append(loan_table_getValueArray(array:valuesOfArrays[index - 2]))
            sum = sum + (valuesOfArrays[index - 2][7] as NSString).floatValue
        }
        return roundFloatValue(value: "\(sum)")
    }
    var loan_first_value = [String]()
    func loan_first_getValueArray() {
        let first = roundFloatValue(value: "\(pmt(rate: (loan_valueArray[1] as NSString).doubleValue/100/12, nper: (loan_valueArray[2] as NSString).doubleValue*12, pv: (loan_valueArray[0] as NSString).doubleValue))")
        let second = (loan_valueArray[2] as NSString).integerValue*12
        let third = second
        let forth = roundFloatValue(value: "\((loan_valueArray[4] as NSString).floatValue*177)")
        let fifth = loan_first_sumOfInterest()
        loan_first_value = [
            first, "\(second)", "\(third)", roundFloatValue(value: "\(forth)"), roundFloatValue(value: "\(fifth)")
        ]
    }
    
    var loan_table_fristValue = [String]()
    func loan_table_first_getValue() {
        
        let second = loan_valueArray[3]
        let third = roundFloatValue(value: "\((loan_valueArray[0] as NSString).floatValue)")
        let forth = roundFloatValue(value: "\(pmt(rate: (loan_valueArray[1] as NSString).doubleValue/100/12, nper: (loan_valueArray[2] as NSString).doubleValue*12, pv: (loan_valueArray[0] as NSString).doubleValue))")
        let fifth = roundFloatValue(value: "\((loan_valueArray[4] as NSString).floatValue)")
        let sixth = roundFloatValue(value: "\((forth as NSString).floatValue + (fifth as NSString).floatValue)")
        let eighth = roundFloatValue(value: "\((third as NSString).floatValue*((loan_valueArray[1] as NSString).floatValue/12)/100)")
        let seventh = roundFloatValue(value: "\((sixth as NSString).floatValue - (eighth as NSString).floatValue)")
        let ninth = roundFloatValue(value: "\((third as NSString).floatValue - (seventh as NSString).floatValue)")
        loan_table_fristValue = [
            "1", second, third, forth, fifth, sixth,seventh ,eighth,ninth
        ]
    }
    
    func loan_table_getValueArray(array:[String]) -> [String]{
        let num = (array[0] as NSString).intValue + 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let toDate = dateFormatter.date(from: array[1])
        let dateforCal = Calendar.current
        var dateIncreased = dateforCal.date(bySetting: .month, value: 1, of: toDate!)
        dateIncreased = dateforCal.date(byAdding: .month, value: 1, to: toDate!)
        let dateforPay = dateFormatter.string(from: dateIncreased!)
        
        let beg_bal = array[8]
        let sch_pay = array[3]
        let ext_pay = array[4]
        let tot_pay = array[5]
        let interest = roundFloatValue(value: "\((beg_bal as NSString).floatValue*((loan_valueArray[1] as NSString).floatValue/100/12))")
        let princ = roundFloatValue(value: "\((tot_pay as NSString).floatValue - (interest as NSString).floatValue)")
        let end_bal = roundFloatValue(value: "\((beg_bal as NSString).floatValue - (princ as NSString).floatValue)")
        
        let resultArray = [
            "\(num)",dateforPay,beg_bal,sch_pay,ext_pay,tot_pay,princ,interest,end_bal
        ]
        return resultArray
    }
    
    func roundFloatValue(value: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        let valueFloat = "\(String(describing: numberFormatter.string(from: NSNumber(value: (value as NSString).floatValue))!))"
        return valueFloat
    }
    
    func fv(rate : Double, nper : Double, pmt : Double, pv : Double) ->Double {
        return pv*pow((1 + rate), nper)
    }
    
    func pmt(rate : Double, nper : Double, pv : Double, fv : Double = 0, type : Double = 0) -> Double {
        return ((pv * pvif(rate: rate, nper: nper) + fv) / ((1.0 + rate * type) * fvifa(rate: rate, nper: nper)))
    }
    
    func pow1pm1(x : Double, y : Double) -> Double {
        return (x <= -1) ? pow((1 + x), y) - 1 : exp(y * log(1.0 + x)) - 1
    }
    
    func pow1p(x : Double, y : Double) -> Double {
        return (abs(x) > 0.5) ? pow((1 + x), y) : exp(y * log(1.0 + x))
    }
    
    func pvif(rate : Double, nper : Double) -> Double {
        return pow1p(x: rate, y: nper)
    }
    
    func fvifa(rate : Double, nper : Double) -> Double {
        return (rate == 0) ? nper : pow1pm1(x: rate, y: nper) / rate
    }
    let cash_definition_titleArray = [
        "Capitalization Rate", "Cash Flow(Annual)", "Debt Service", "Effective Gross Income", "Gross Income", "Net Operating Income", "Operating Expenses", "Vacancy Rate", "Return On Investment", "Gross Rent Multiplier", "Breakeven Point(%)", "Debt Coverage Ratio"
    ]
    
}
