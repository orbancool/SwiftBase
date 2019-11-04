import Foundation

enum Color {
    case ramp
    case red, gree, blue
}

enum ConnectError: String, Error {
    case connection = "Connection error! Check ip, router or pay for internet"
    case login = "Login is wrong"
    case password = "Password is wrong"
}

enum PropertyError: Error {
    case type
    case powerHz
}

enum LampPower: String {
    case low = "40hz"
    case middle = "50hz"
    case high = "100hz"
}

enum Mat {
    case matte, transparency
}

struct Server {
    var adress = "192.168..."
    var name = "Performance Server"
}

protocol Connect {
    var login: String {get set}
    var password: String {get set}
    var ip: String {get set}
    func sendSignal(color: Color, animation: Bool)
}

extension Connect {
    func sendSignal(color: Color, animation: Bool) {
        // connect to server and send signal
        print("Connected")
    }
}

class Lamp: CustomStringConvertible, Connect {
    func sendSignal(color: Color, animation: Bool) throws {
        guard login.count > 0 && password.count > 0 else {
            throw ConnectError.login
        }
        let serverAdress = Server()
        if ip != serverAdress.adress {
            throw ConnectError.connection
        }
        
        print("Connected")
    }
    
    var login: String
    var password: String
    var ip: String
    var type: String
    var power: LampPower
    var material: Mat
    
    var description: String {
        return "\(self.type) \(material) lamp"
    }
    
    init(login: String, password: String, ip: String, type: String, power: LampPower, material: Mat) {
        self.login = login
        self.password = password
        self.ip = ip
        self.type = type
        self.power = power
        self.material = material
    }
}

struct Queue<T: Connect> {
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

    mutating func changeIp(ip: String) {
        for index in 0..<collection.count {
            self.collection[index].ip = ip
        }
    }
    
    mutating func changeLogin(login: String) {
        for index in 0..<collection.count {
            self.collection[index].login = login
        }
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

var lamp1 = Lamp(login: "", password: "qwerty", ip: "192", type: "Led", power: .high, material: .matte)
//print(lamp1)

var lamp2 = Lamp(login: "Den", password: "qwerty", ip: "192...", type: "Led", power: .high, material: .matte)

var collection = Queue<Lamp>()
collection.addObject(object: lamp1)
collection.addObject(object: lamp2)
print(collection)
//print(collection[0]?.ip)
//collection.changeIp(ip: "111")
//print(collection[0]?.ip)
print("\nbefore:")
for lamp in 0..<collection.count() {
    do {
        try collection[lamp]?.sendSignal(color: .ramp, animation: true)
    } catch ConnectError.connection {
        print(ConnectError.connection.rawValue)
    } catch ConnectError.login {
        print(ConnectError.login.rawValue)
    }
}
print("\nafter:")
collection.changeIp(ip: "192.168...")
collection.changeLogin(login: "Guest")

for lamp in 0..<collection.count() {
    do {
        try collection[lamp]?.sendSignal(color: .ramp, animation: true)
    } catch ConnectError.connection {
        print(ConnectError.connection.rawValue)
    } catch ConnectError.login {
        print(ConnectError.login.rawValue)
    }
}
/*
do {
    try lamp1.sendSignal(color: .ramp, animation: true)
} catch ConnectError.connection {
    print(ConnectError.connection.rawValue)
} catch ConnectError.login {
    print(ConnectError.login.rawValue)
}


print(lamp2)
do {
    try lamp2.sendSignal(color: .ramp, animation: true)
} catch ConnectError.connection {
    print(ConnectError.connection.rawValue)
} catch ConnectError.login {
    print(ConnectError.login.rawValue)
}
*/




