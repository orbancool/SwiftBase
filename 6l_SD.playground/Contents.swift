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
    var name: String { get set }
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

class Investor: SalaryCalculate, Business, Money {
    var spending: Int
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
    init(country: [String], salery: Double, name: String, spending: Int) {
        self.country = country
        self.salery = salery
        self.name = name
        self.spending = spending
    }
}

extension Investor: CustomStringConvertible {
    var description: String {
        return "Business owner"
    }
}
protocol Money {
    var spending: Int { get set }
}

struct Queue<T: Money > {
    private var collection = [T]()
    
    mutating func addObject(object: T) {
        collection.append(object)
    }
    
    mutating func deleteObject() -> T {
        return collection.removeFirst()
    }
    
    func count() -> Int {
        return collection.count
    }
    
    func getSpending() -> Int {
        var result = 0
        for collect in collection {
            result += collect.spending
        }
        return result
    }
    
    //////////////////////////////////////////// я не могу изменить траты (spending) таким образом ко всей коллекции? ////////////////////////
    mutating func changeSpending() {
        print(collection.filter { $0.spending % 1_500_000 == 0 })
        for element in collection {
            print(element.spending)
            //element.spending = 0 ////////////////////////
        }
    }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    func reduceSpending(by value: Int) -> Int {
        let reduceCollection = collection.map { $0.spending / value }
        return reduceCollection.reduce(0, +)// {$0+$1}
        //return collection.reduce(0) { $0.spending + $1.spending }
    }
    
    subscript(_ index: Int) -> T? {
        if index >= collection.count  {
            return nil
        }
        return collection[index]
    }
    
}
extension Queue {
    func info() {
        print(collection)
    }
}

var investorOne = Investor(country: ["Spain", "Usa", "Russia"], salery: 200_000, name: "Ivanov", spending: 1_000_000)
var investorTwo = Investor(country: ["Brazil", "Canada"], salery: 200_000, name: "Sidorov", spending: 3_000_000)
var admin = Worker(status: .admin, salery: 100_000)


var queue = Queue<Investor>()

queue.addObject(object: investorOne)
queue.addObject(object: investorTwo)
queue.info()
print(queue[2]?.country as Any)
print(queue[0]?.country as Any)



print(queue.getSpending())
print(queue.reduceSpending(by: 2))
queue.changeSpending()
print(queue.getSpending())
queue.count()
print(queue.deleteObject())
queue.count()
queue.info()
print(queue.self)


/*var ff = [investorOne, investorTwo]
 for i in ff {
 i.spending = 0
 }*/


