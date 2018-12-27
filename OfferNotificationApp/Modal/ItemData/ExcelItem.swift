import UIKit
import CoreData

class ExcelItem: NSObject, NSCoding{
    
    var homeImageColor : UIImage?
    var homeImageBlack : UIImage?
    var identifyKey = ""
    var index : Int = 0
    var mls = ""
    var status = ""
    var street = ""
    var compassPoint = ""
    var streetName = ""
    var city = ""
    var area = ""
    var listPrice = ""
    var zipCode = ""
    var zestimate = ""
    var zestimateRange = ""
    var taxes = ""
    var netCashFlow = ""
    var cashOnCash = ""
    var rentRatio = ""
    var debtCoverageRatio = ""
    var breakEvenRatio = ""
    var capitalizationRate = ""
    var listingMarketTime = ""
    var bedrooms = ""
    var fullBaths = ""
    var halfBaths = ""
    var aC = ""
    var propertyType = ""
    var parking = ""
    var garageOnSite = ""
    var vacancyRate = ""
    var management = ""
    var potentialGrossRental = ""
    var vacancyAllowance = ""
    var effectiveGrossIncome = ""
    var managementFee = ""
    var insurance = ""
    var assessmentAssociationDues = ""
    var propertyTaxesMonth = ""
    var totalExpenses = ""
    var noi = ""
    var totalDebtService = ""
    var netCashFlow1 = ""
    var mortgageAmount = ""
    var mortgageTerm = ""
    var interestRate = ""
    var downPayment = ""
    var downPaymentAmount = ""
    var closingCostsFees = ""
    var remarks = ""
    
    var generatedTime = ""
    
    override init() {
        homeImageColor = nil
        homeImageBlack = nil
        identifyKey = "New"
        mls = ""
        status = ""
        street = ""
        compassPoint = ""
        streetName = ""
        city = ""
        area = ""
        listPrice = ""
        zipCode = ""
        zestimate = ""
        zestimateRange = ""
        taxes = ""
        netCashFlow = ""
        cashOnCash = ""
        rentRatio = ""
        debtCoverageRatio = ""
        breakEvenRatio = ""
        capitalizationRate = ""
        listingMarketTime = ""
        bedrooms = ""
        fullBaths = ""
        halfBaths = ""
        aC = ""
        propertyType = ""
        parking = ""
        garageOnSite = ""
        vacancyRate = ""
        management = ""
        potentialGrossRental = ""
        vacancyAllowance = ""
        effectiveGrossIncome = ""
        managementFee = ""
        insurance = ""
        assessmentAssociationDues = ""
        propertyTaxesMonth = ""
        totalExpenses = ""
        noi = ""
        totalDebtService = ""
        netCashFlow1 = ""
        mortgageAmount = ""
        mortgageTerm = ""
        interestRate = ""
        downPayment = ""
        downPaymentAmount = ""
        closingCostsFees = ""
        remarks = ""
        generatedTime = ""
    }
    
    required init(coder decoder: NSCoder){
        homeImageColor = decoder.decodeObject(forKey: "homeImageColor") as? UIImage ?? nil
        homeImageBlack = decoder.decodeObject(forKey: "homeImageBlack") as? UIImage ?? nil
        let indexNumber = decoder.decodeObject(forKey: "indexNum") as! NSNumber
        index = indexNumber as? Int ?? 0
        identifyKey = decoder.decodeObject(forKey: "identifyKey") as! String
        mls = decoder.decodeObject(forKey: "mls") as! String
        status = decoder.decodeObject(forKey: "status") as! String
        street = decoder.decodeObject(forKey: "street") as! String
        compassPoint = decoder.decodeObject(forKey: "compassPoint") as! String
        streetName = decoder.decodeObject(forKey: "streetName") as! String
        city = decoder.decodeObject(forKey: "city") as! String
        area = decoder.decodeObject(forKey: "area") as! String
        listPrice = decoder.decodeObject(forKey: "listPrice") as! String
        zipCode = decoder.decodeObject(forKey: "zipCode") as! String
        zestimate = decoder.decodeObject(forKey: "zestimate") as! String
        zestimateRange = decoder.decodeObject(forKey: "zestimateRange") as! String
        taxes = decoder.decodeObject(forKey: "taxes") as! String
        netCashFlow = decoder.decodeObject(forKey: "netCashFlow") as! String
        cashOnCash = decoder.decodeObject(forKey: "cashOnCash") as! String
        rentRatio = decoder.decodeObject(forKey: "rentRatio") as! String
        debtCoverageRatio = decoder.decodeObject(forKey: "debtCoverageRatio") as! String
        breakEvenRatio = decoder.decodeObject(forKey: "breakEvenRatio") as! String
        capitalizationRate = decoder.decodeObject(forKey: "capitalizationRate") as! String
        listingMarketTime = decoder.decodeObject(forKey: "listingMarketTime") as! String
        bedrooms = decoder.decodeObject(forKey: "bedrooms") as! String
        fullBaths = decoder.decodeObject(forKey: "fullBaths") as! String
        halfBaths = decoder.decodeObject(forKey: "halfBaths") as! String
        aC = decoder.decodeObject(forKey: "aC") as! String
        propertyType = decoder.decodeObject(forKey: "propertyType") as! String
        parking = decoder.decodeObject(forKey: "parking") as! String
        garageOnSite = decoder.decodeObject(forKey: "garageOnSite") as! String
        vacancyRate = decoder.decodeObject(forKey: "vacancyRate") as! String
        management = decoder.decodeObject(forKey: "management") as! String
        potentialGrossRental = decoder.decodeObject(forKey: "potentialGrossRental") as! String
        vacancyAllowance = decoder.decodeObject(forKey: "vacancyAllowance") as! String
        effectiveGrossIncome = decoder.decodeObject(forKey: "effectiveGrossIncome") as! String
        managementFee = decoder.decodeObject(forKey: "managementFee") as! String
        insurance = decoder.decodeObject(forKey: "insurance") as! String
        assessmentAssociationDues = decoder.decodeObject(forKey: "assessmentAssociationDues") as! String
        propertyTaxesMonth = decoder.decodeObject(forKey: "propertyTaxesMonth") as! String
        totalExpenses = decoder.decodeObject(forKey: "totalExpenses") as! String
        noi = decoder.decodeObject(forKey: "noi") as! String
        totalDebtService = decoder.decodeObject(forKey: "totalDebtService") as! String
        netCashFlow1 = decoder.decodeObject(forKey: "netCashFlow1") as! String
        mortgageAmount = decoder.decodeObject(forKey: "mortgageAmount") as! String
        mortgageTerm = decoder.decodeObject(forKey: "mortgageTerm") as! String
        interestRate = decoder.decodeObject(forKey: "interestRate") as! String
        downPayment = decoder.decodeObject(forKey: "downPayment") as! String
        downPaymentAmount = decoder.decodeObject(forKey: "downPaymentAmount") as! String
        closingCostsFees = decoder.decodeObject(forKey: "closingCostsFees") as! String
        remarks = decoder.decodeObject(forKey: "remarks") as! String
        generatedTime = decoder.decodeObject(forKey: "generatedTime") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(homeImageColor, forKey: "homeImageColor")
        coder.encode(homeImageBlack, forKey: "homeImageBlack")
        let indexNum = NSNumber(value: index)
        coder.encode(indexNum, forKey: "indexNum")
        coder.encode(identifyKey, forKey: "identifyKey")
        coder.encode(mls, forKey: "mls")
        coder.encode(status, forKey: "status")
        coder.encode(street, forKey: "street")
        coder.encode(compassPoint, forKey: "compassPoint")
        coder.encode(streetName, forKey: "streetName")
        coder.encode(city, forKey: "city")
        coder.encode(area, forKey: "area")
        coder.encode(listPrice, forKey: "listPrice")
        coder.encode(zipCode, forKey: "zipCode")
        coder.encode(zestimate, forKey: "zestimate")
        coder.encode(zestimateRange, forKey: "zestimateRange")
        coder.encode(taxes, forKey: "taxes")
        coder.encode(netCashFlow, forKey: "netCashFlow")
        coder.encode(cashOnCash, forKey: "cashOnCash")
        coder.encode(rentRatio, forKey: "rentRatio")
        coder.encode(debtCoverageRatio, forKey: "debtCoverageRatio")
        coder.encode(breakEvenRatio, forKey: "breakEvenRatio")
        coder.encode(capitalizationRate, forKey: "capitalizationRate")
        coder.encode(listingMarketTime, forKey: "listingMarketTime")
        coder.encode(bedrooms, forKey: "bedrooms")
        coder.encode(fullBaths, forKey: "fullBaths")
        coder.encode(halfBaths, forKey: "halfBaths")
        coder.encode(aC, forKey: "aC")
        coder.encode(propertyType, forKey: "propertyType")
        coder.encode(parking, forKey: "parking")
        coder.encode(garageOnSite, forKey: "garageOnSite")
        coder.encode(vacancyRate, forKey: "vacancyRate")
        coder.encode(management, forKey: "management")
        coder.encode(potentialGrossRental, forKey: "potentialGrossRental")
        coder.encode(vacancyAllowance, forKey: "vacancyAllowance")
        coder.encode(effectiveGrossIncome, forKey: "effectiveGrossIncome")
        coder.encode(managementFee, forKey: "managementFee")
        coder.encode(insurance, forKey: "insurance")
        coder.encode(assessmentAssociationDues, forKey: "assessmentAssociationDues")
        coder.encode(propertyTaxesMonth, forKey: "propertyTaxesMonth")
        coder.encode(totalExpenses, forKey: "totalExpenses")
        coder.encode(noi, forKey: "noi")
        coder.encode(totalDebtService, forKey: "totalDebtService")
        coder.encode(netCashFlow1, forKey: "netCashFlow1")
        coder.encode(mortgageAmount, forKey: "mortgageAmount")
        coder.encode(mortgageTerm, forKey: "mortgageTerm")
        coder.encode(interestRate, forKey: "interestRate")
        coder.encode(downPayment, forKey: "downPayment")
        coder.encode(downPaymentAmount, forKey: "downPaymentAmount")
        coder.encode(closingCostsFees, forKey: "closingCostsFees")
        coder.encode(remarks, forKey: "remarks")
        coder.encode(generatedTime, forKey: "generatedTime")
    }
}
