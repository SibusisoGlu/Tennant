import Foundation
import SwiftUI

class PropertiesViewModel: ObservableObject {
    let repository: RealmRepository
    let manager: PropertiesManager
    var propertyType: PropertyOptions = .multipleUnits
    
    @Published var newData: NewDataModel = NewDataModel()
    @Published var properties: [Property] = []
    @Published var selectedProperty = Property()
    
    @Published var selectedTenant = Tennant()
    @Published var tenants: [TenantCardModel] = []
    
    @Published var allUnits: [SingleUnit] = []
    @Published var selectedUnit = SingleUnit()
    
    @Published var shouldShowAddProperty: Bool = false
    @Published var shouldAddPropertyOptions: Bool = false
    @Published var showTennantView: Bool = false
    
    @Published var uploadStatus: String = ""
    @Published var showUploadStatus: Bool = false
    @Published var showPropertyDetailView: Bool = false
    
    @Published var showAlert: Bool = false
    
    init() {
        self.repository = RealmRepository()
        self.manager = PropertiesManager(repository: repository)
        self.refreshData()
    }
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func addProperty() {
        selectedProperty = Property()
        manager.createProperty(newData: newData) { success in
            if success {
                self.showAlert = true
                self.setUpStatus(message: "Property saved successfully.")
                self.clearData()
            } else {
                self.setUpStatus(message: "Something went wrong.")
                self.clearData()
            }
        }
    }
    
    func selectedProperty(_ property: Property) {
        selectedProperty = property
        let units = manager.fetchPropertyUnits(property.buildingID)
        tenants = manager.getTenantCardData(units: units)
        showPropertyDetailView = true
    }
    
    func managePropertyOptions(_ selectedOption: Int) {
        if selectedOption == 1 {
            propertyType = .singleUnit
        } else {
            propertyType = .multipleUnits
        }
        
        shouldShowAddProperty = true
    }
    
    private func setUpStatus(message: String) {
        uploadStatus = message
        showUploadStatus = true
    }
    
    private func clearData() {
        newData = NewDataModel()
    }
    
    func refreshData() {
        properties = manager.fetchProperties()
    }
    
    func delete(_ propertyId: String) {
        selectedProperty = Property()
        properties.removeAll(where: { $0.buildingID == propertyId })
        manager.deleteProperty(propertyId)
    }
    
    func addTenant(_ tenant: Tennant) {
        manager.tenantManager.addTenant(propertyID: selectedProperty.buildingID,
                                unitID: selectedUnit.id,
                                tenant: tenant) { tenantId in
            self.manager.unitManager.dataProvider.update(id: self.selectedUnit.id, tenantId: tenantId)
        }
    }
    
    func getTenant(with id: String, completion: (Tennant) -> Void) {
        if let tenant = manager.tenantManager.fetchTenant(from: id) {
            completion(tenant)
        }
    }
}
// "26DFCE83-5291-4BC8-8DCB-9FF1B60201F8"
