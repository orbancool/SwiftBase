import Foundation

enum EngineUpgrade {
    case add(Double)
    case subtract(Double)
}

enum EngineStatus: String {
    case off = "Engine is off"
    case on = "Engine is on"
}

enum Tuning {
    case on, off
}

class Car {
    var mark: String
    var year: Int
    var engine: EngineStatus
    static var count = 0
    
    static func globalCount() {
        print(count)
    }
    
    func engineInfo() {
        switch engine {
        case .off:
            print(engine.rawValue)
        case .on:
            print(engine.rawValue)
        }
    }
    
    func info() {
        print("\(mark) \(year)")
    }
    
    init(mark: String, year: Int, engine: EngineStatus) {
        self.mark = mark
        self.year = year
        self.engine = .off
        Car.count += 1
    }
}

class SportCar: Car {
    
    var speed: Double
    var tuning: Tuning = .off
    var upgradeValue = 0.0
    
    func checkUpdates() {
        if (tuning == .on) {
            speed += 50
        }
    }
    
    func engeneUpgrade(by: EngineUpgrade) {
        switch by {
        case .add(let value):
            upgradeValue = value
            speed += value
        case .subtract(let value):
            if (speed > value) {
                speed -= value
                upgradeValue = value
            }
        }
    }
    
    init(speed: Double, mark: String, year: Int, engine: EngineStatus) {
        self.speed = speed
        super.init(mark: mark, year: year, engine: engine)
    }
    
    override func engineInfo() {
        print("speed : \(speed)")
    }
    
    override func info() {
        super.info()
        if upgradeValue > 0 {
            print("engine was changed by \(upgradeValue)")
        }
    }
}

var opel = SportCar(speed: 300, mark: "Opel", year: 2011, engine: .on)
opel.engineInfo()
opel.info()
opel.engeneUpgrade(by: .add(200))
print("upgrade value: \(opel.upgradeValue)")
opel.info()
opel.engineInfo()

opel.tuning = .on
opel.checkUpdates()
opel.info()
opel.engineInfo()


var vaz = Car(mark: "vaz", year: 1980, engine: .off)
vaz.engineInfo()
vaz.info()
print(Car.count)
print("\n")
var ls: [Car] = [opel, vaz]
for i in ls {
    i.info()
}
