import Foundation

class LandingDataProvider {
//    func setUpView(isAProperty: Bool) {
//        if isAProperty {
//            viewTitle = "Add a Property"
////            buttonTitle =
//        }
//    }
//    
//    func addData() {
//        if newData.isAProperty {
//            addNewProperty()
//        } else {
//            addNewTennant()
////            addNewTenantsToPropertyUnits()
//        }
//    }
    
//    func clearData() {
//        newData = NewDataModel()
//    }
//    
//    private func addNewProperty() {
//        let buildingID = UUID().uuidString
//        newProperty = Property(buildingID: buildingID,
//                                    buildingName: newData.name,
//                                    buildingAddress: newData.address,
//                                    numberOfUnits: newData.numberOfUnits,
//                                    numberOfUnitsOccupied: newData.numberOfUnitsOccupied)
//        setUpUnitsForNewProperty(numberOfUnits: Int(newData.numberOfUnits) ?? 1, buildingID: buildingID)
////        newProperty.units.append(objectsIn: newPropertyUnits)
//        newProperty.units.append(objectsIn: [""])
//        
////        try! realmRepository.update(insertions: [newPropoerty])
//        properties.append(newProperty)
//        clearData()
//    }
    
//    private func addNewTennant() {
//        let date = Date.now
//        #warning("Make sure ID is 13 digits outide of view")
//        newTennant = Tennant(buildingNumber: newData.buildingNumber,
//                             unitID: newData.unitID,
//                                 tennantID: newData.tennantID,
//                                name: newData.name,
//                                surname: newData.surname,
//                                 currentAddress: newData.address,
//                                 company: newData.company,
//                                position: newData.position,
//                                monthlyIncome: Int(newData.monthlyIncome) ?? 0,
//                                balance: 0.0,
//                                amountDue: 0.0,
//                                startDate: getCurrentDate(date: date),
//                                endDate: getEndDate(date: date),
//                                fullPayments: 0)
//        
////        try! realmRepository.update(insertions: [newTennant])
//        tennants.append(newTennant)
//        clearData()
//    }
    
//    func addNewTenantsToPropertyUnits() {
//        guard let index = newProperty.flats.firstIndex(where: { flat in
//            flat.id == newTennant.flatID
//        }) else { return }
//
//        newProperty.flats[index].tennantID = newTennant.tennantID
//        print(newProperty)
//    }
    
//    func setUpFlatModel() {
//        availableUnits = newPropertyFlats.map { flat in
//            flat.id
//        }
//    }
    
//    private func setUpUnitsForNewProperty(numberOfUnits: Int, buildingID: String) {
//        #warning("Find out how to set the unit availability")
//        for unit in 0..<numberOfUnits {
////            newPropertyFlats.append(Flat(UnitNumber: unit, buildingID: buildingID, isAvailable: <#Bool#>))
//        }
//    }
//    
//    private func getCurrentDate(date: Date) -> String {
//        return date.getDateAsString()
//    }
//    
//    private func getEndDate(date: Date) -> String {
//        let dateInOneYear = Calendar.current.date(byAdding: .year, value: 1, to: date)
//        return dateInOneYear?.getDateAsString() ?? date.getDateAsString()
//    }
}
