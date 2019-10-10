//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport

                                            //1
                        //quadraticEquation : ax2 + bx + c = 0
//input data
let a: Double = 1
let b: Double = 12
let c: Double = 36

//search data
var x1: Double?
var x2: Double?

//decision
let discriminant = pow(b, 2) - 4 * a * c
var tempValueOne = (-b + sqrt(discriminant)) / (2 * a)
var tempValueTwo = (-b - sqrt(discriminant)) / (2 * a)
//print(discriminant)
if discriminant > 0 {
    x1 = tempValueOne
    x2 = tempValueTwo
} else if discriminant == 0 {
    x1 = tempValueOne
    x2 = nil
} else {
    x1 = nil
    x2 = nil
}
let out1 = x1 != nil ? String(x1!) : "nil"
let out2 = x2 != nil ? String(x2!) : "nil"
print("Task #1: \nx1 = \(out1) \nx2 = \(out2)\n")

                                            // 2
//input data
let cathetOne: Double = 3
let cathetTwo: Double = 4
//search data
var area = Double()
var perimeter = Double()
var hypotenuse = Double()

area = cathetOne * cathetTwo / 2.0
hypotenuse = sqrt(pow(cathetOne, 2) + pow(cathetTwo, 2))
perimeter = cathetOne + cathetTwo + hypotenuse
print("Task #2:\narea = \(area) \nhypotenuse = \(hypotenuse) \nperimeter = \(perimeter)\n")


                                            // 3
var money: Double = 1000
//var inputMoney = readLine()
//var money: Double = inputMoney != nil ? Double(inputMoney!)! : 0.0
let percent: Double = 10
let years = 10
var result = ""
for year in 1...years {
    money += money * percent / 100.0
    money = Double(Int(money * 100)) / 100.0
    //money = Double(String(format: "%.2f", money))!
    result += "\(year) year: \(money)\n"
}
print("Task #3: \n\(result)")
