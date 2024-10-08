import Foundation
//import RealmSwift

class UpdateTennantViewModel: ObservableObject {
    var tenant: Tennant
    var unitNumber: String
    var newTennants = [Tennant]()
    var rentAmount: Int = 1500
    
    @Published var amountAdded: String = ""
    @Published var selectedTennant = Tennant()
    @Published var numberOfMonthsPassed: Int = 0
    @Published var endDate: Date
    
    init(tenant: Tennant, unitNumber: String) {
        self.endDate = Date.now
        self.tenant = tenant
        self.unitNumber = unitNumber
//        mapTennantsToArray()
//        getTennantByMostDebt()
    }
    
    func getNumberOfMonthsPassed(startDate: String, endDate: Date) {
        let calandar = Calendar.current
        #warning("Make sure start date is not ahead of current date")
        let components = calandar.dateComponents([.month], from: startDate.getStringAsDate(), to: endDate)
        guard let monthsPassed = components.month else { return }
        numberOfMonthsPassed = monthsPassed
    }
    
    #warning("Add and create tests")
    func isAFutureDate(startDate: Date, endDate: Date) -> Bool {
        if startDate > endDate {
            return true
        } else {
            return false
        }
    }
    
    func getPaymentHistoryPercentage(numberOfMonthsPassed: Int, numberOfFullPayments: Int) -> Double {
        let paymentHistoryPercentage = Double(numberOfFullPayments) / Double(numberOfMonthsPassed)
        let roundedPaymentHistoryPercentage = (round(10 * paymentHistoryPercentage) / 10)
        return roundedPaymentHistoryPercentage
    }
    
    func getPercentage(percentageDouble: Double) -> String {
        if percentageDouble == 0.0 {
            let percentageString = Int(percentageDouble * 100)
            return "\(percentageString)%"
        } else {
            return "0%"
        }
    }
    
    func paidInFull() {
        if var payment = Int(selectedTennant.fullPayments) {
            payment += 1
            selectedTennant.fullPayments = String(payment)
        }
    }
    
    func notPaidInFull(with amount: Double) {
        selectedTennant.amountDue += amount
    }
}
