import Foundation

class NewDataModel {
    var isAProperty: Bool
    var name: String
    var surname: String
    var tennantID: String
    var address: String
    var numberOfUnits: String
    var numberOfUnitsOccupied: String
    var buildingNumber: String
    var unitID: String
    var company: String
    var position: String
    var monthlyIncome: String
    
    init(isAProperty: Bool = false,
         name: String = "",
         surname: String = "",
         tennantID: String = "",
         address: String = "",
         numberOfUnits: String = "",
         numberOfUnitsOccupied: String = "",
         buildingNumber: String = "",
         unitID: String = "",
         company: String = "",
         position: String = "",
         monthlyIncome: String = "") {
        self.isAProperty = isAProperty
        self.name = name
        self.surname = surname
        self.tennantID = tennantID
        self.address = address
        self.numberOfUnits = numberOfUnits
        self.numberOfUnitsOccupied = numberOfUnitsOccupied
        self.buildingNumber = buildingNumber
        self.unitID = unitID
        self.company = company
        self.position = position
        self.monthlyIncome = monthlyIncome
    }
}
