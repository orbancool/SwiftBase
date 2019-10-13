import Foundation

enum engineStatus: String {
    case off = "Engine is off"
    case on = "Engine is on"
}

enum windowsStatus: String {
    case off = "Windows are close"
    case on = "Windows are open"
}

enum volumeOption {
    case add(Int)
    case subtract(Int)
}

struct Car {
    private var trunkVolume: Int = 0
    var model: String
    var year: Int
    var trunkVolumeLimit: Int
    var currentBodyVolume: Int {
        get {
            return trunkVolume
        }
    }
    var engine: engineStatus = .off
    var windows: windowsStatus = .off
    
    init(model: String, year: Int, trunkVolumeLimit: Int, engine: engineStatus, windows: windowsStatus){
        self.model = model
        self.year = year
        self.trunkVolumeLimit = trunkVolumeLimit
        self.engine = engine
        self.windows = windows
    }
    
    func info() {
        print("model : \(model), trunkVolume is : \(trunkVolume), year : \(year), engine is \(engine), windows are \(windows)")
    }
    
    func engineInfo() {
        switch engine {
        case .off:
            print(engine.rawValue)
        case .on:
            print(engine.rawValue)
        }
    }
    
    func windowsInfo() {
        switch windows {
        case .off:
            print(windows.rawValue)
        case .on:
            print(windows.rawValue)
        }
    }
    
    mutating func volumeChange(option: volumeOption) {
        switch option {
        case .add(let count):
            if (trunkVolume + count) > trunkVolumeLimit {
                print("maximum limit exceeded")
                return
            }
            trunkVolume += count
        case .subtract(let count):
            if (trunkVolume - count) < 0 {
                print("Volume can't be negative")
                return
            }
            trunkVolume -= count
        }
    }
}

struct Truck {
    var model: String
    var year: Int
    var bodyVolumeLimit: Int
    private var bodyVolume: Int = 0
    var currentBodyVolume: Int {
        get {
            return bodyVolume
        }
    }
    var engine: engineStatus = .off
    var windows: windowsStatus = .off
    
    init(model: String, year: Int, bodyVolumeLimit: Int, engine: engineStatus, windows: windowsStatus){
        self.model = model
        self.year = year
        self.bodyVolumeLimit = bodyVolumeLimit
        self.engine = engine
        self.windows = windows
    }
    
    func info() {
        print("model : \(model), bodyVolume is : \(bodyVolume), year : \(year), engine is \(engine), windows are \(windows)")
    }
    
    func engineInfo() {
        switch engine {
        case .off:
            print(engine.rawValue)
        case .on:
            print(engine.rawValue)
        }
    }
    
    func windowsInfo() {
        switch windows {
        case .off:
            print(windows.rawValue)
        case .on:
            print(windows.rawValue)
        }
    }
    
    mutating func volumeChange(option: volumeOption) {
        switch option {
        case .add(let count):
            if (bodyVolume + count) > bodyVolumeLimit {
                print("maximum limit exceeded")
                return
            }
            bodyVolume += count
        case .subtract(let count):
            if (bodyVolume - count) < 0 {
                print("Volume can't be negative")
                return
            }
            bodyVolume -= count
        }
    }
}

var opelOne = Car(model: "Opel", year: 2005, trunkVolumeLimit: 60, engine: .off, windows: .on)
opelOne.volumeChange(option: .add(40))
opelOne.volumeChange(option: .subtract(20))
opelOne.engineInfo()
opelOne.windowsInfo()
opelOne.info()

var kamaz = Truck(model: "Kamaz", year: 2000, bodyVolumeLimit: 1300, engine: .on, windows: .off)
kamaz.info()

