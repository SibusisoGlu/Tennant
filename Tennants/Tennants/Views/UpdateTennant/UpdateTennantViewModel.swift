import Foundation
import RealmSwift

class UpdateTennantViewModel: ObservableObject, TennantRepository {
    var realmRepository: RealmRepository
    var newTennants = [Tennant]()
    
    @Published var amountAdded: String = ""
    @Published var selectedTennant = Tennant()
    
    init(realmRepository: RealmRepository = RealmRepository()) {
        self.realmRepository = realmRepository
        mapTennantsToArray()
        getTennantByMostDebt()
    }
    
    func mapTennantsToArray() {
        newTennants = self.realmRepository.tennants.map({ Tennant(buildingNumber: $0.buildingNumber,
                                                            flatNumber: $0.flatNumber,
                                                            name: $0.name,
                                                            surname: $0.surname,
                                                            company: $0.company,
                                                            position: $0.position,
                                                            monthlyIncome: $0.monthlyIncome,
                                                            balance: $0.balance,
                                                            amountDue: $0.amountDue,
                                                            startDate: $0.startDate,
                                                            endDate: $0.endDate,
                                                            fullPayments: $0.fullPayments) })
    }
    
    func updateTennant() {
        let index = newTennants.firstIndex(where: { $0.id == selectedTennant.id}) ?? 0
        newTennants[index] = selectedTennant
        
//        try? realmRepository.update(insertions: newTennants)
    }
    
    func deleteTennant() {
        try? realmRepository.delete(selectedTennant)
    }
    
    func getTennantByMostDebt() {
        let sortedTennants = realmRepository.tennants.sorted(by: {$0.amountDue > $1.amountDue})
        if let sortedTennant = sortedTennants.first {
            selectedTennant = sortedTennant
        }
    }
    
    func addTennant() {
        realmRepository.add(selectedTennant)
    }
}
