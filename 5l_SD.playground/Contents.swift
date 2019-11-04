import Foundation

enum WorkerStatus {
    case admin, manager, director
}

protocol SalaryCalculate {
    var salery: Double { get set}
    var saleryLevel: Double { get }
    
    func calculateSalary() -> Double
}

extension SalaryCalculate {
    mutating func addBonus() {
        self.salery *= 1.1
    }
}

protocol Business {
    var country: [String] { get }
    func info()
}

class Worker: SalaryCalculate {
    var salery: Double
    var status: WorkerStatus
    var saleryLevel: Double {
        switch status {
        case .manager: return 1.1
        case .admin: return 1.4
        case .director: return 3
        }
    }
    
    init(status: WorkerStatus, salery: Double) {
        self.status = status
        self.salery = salery
    }
    
    func calculateSalary() -> Double {
        return saleryLevel * salery
    }
}

extension Worker: CustomStringConvertible {
    var description: String {
        return "worker class"
    }
}

class Investor: SalaryCalculate, Business {
    var country: [String]
    var salery: Double
    var saleryLevel: Double = 5
    var name: String
    func calculateSalary() -> Double {
        return saleryLevel * salery * Double(country.count)
    }
    func info() {
        var result : String = ""
        for i in country {
            result += " \(i)"
        }
        print("\(name) have \(calculateSalary()) salery, and have business in\(result)")
    }
    init(country: [String], salery: Double, name: String) {
        self.country = country
        self.salery = salery
        self.name = name
    }
}

extension Investor: CustomStringConvertible {
    var description: String {
        return "Business owner"
    }
}

var investorOne = Investor(country: ["Spain", "Usa", "Russia"], salery: 200_000, name: "Ivanov")
investorOne.info()
print(investorOne)

var admin = Worker(status: .admin, salery: 100_000)
var manager = Worker(status: .manager, salery: 50_000)
var director = Worker(status: .director, salery: 200_000)
print(director.calculateSalary())
director.addBonus()
print(director.calculateSalary())
var personal: [SalaryCalculate] = [admin, manager, director]

var monthSalary = 0.0
for person in personal {
    monthSalary += person.calculateSalary()
}
print(monthSalary)
print(director)
