//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport
import Foundation
                            // 1 & 2 & 3 & 4
print("1 & 2 & 3 & 4 task __________________ \n")
func returnEvenOrNot(_ number: Int) -> Bool {
    return number % 2 == 0
}

func isDividedByThree(_ number: Int) -> Bool {
    return number % 3 == 0
}

func arrayCondition(_ number: Int) -> Bool {
        return number % 2 == 0 || number % 3 != 0
}


var increasingArray01 = [Int]()
for i in 0..<100 {
    increasingArray01.append(i)
}

var increasingArray02 = [Int](stride(from: 0, to: 100, by: 1))
var increasingArray03 = increasingArray02
var increasingArray04 = increasingArray02
var increasingArray05 = increasingArray02
var copyIncreasingArray05 = increasingArray02
var increasingArray06 = increasingArray02
var increasingArray07 = increasingArray02

// filter
increasingArray01 = increasingArray01.filter { !(returnEvenOrNot($0) || !isDividedByThree($0)) }
print("increasingArray01 : \(increasingArray01)\n")

increasingArray02 = increasingArray02.filter { !arrayCondition($0) }
print("increasingArray02 : \(increasingArray02)\n")


// нашел такой способ но пока не совсем его понимаю (closures?)
increasingArray03.removeAll(where: { arrayCondition($0) })
print("increasingArray03 : \(increasingArray03)\n")

increasingArray04.removeAll(where: { returnEvenOrNot($0) || !isDividedByThree($0) })
print("increasingArray04 : \(increasingArray04)\n")


// вариант с дублированием массива
for value in copyIncreasingArray05 {
    if arrayCondition(value) {
        while increasingArray05.contains(value){
            for (indexJ, valueJ) in increasingArray05.enumerated() {
                if valueJ == value {
                    increasingArray05.remove(at: indexJ)
                }
            }
        }
    }
}
print("increasingArray05 : \(increasingArray05)\n")

//еще вариант, вроде работает)
var count = 0
while count < increasingArray06.count {
    //print(increasingArray06.count)
    if (arrayCondition(increasingArray06[count]) && count >= 0) {
        increasingArray06.remove(at: count)
        count -= 1
    }
    count += 1
}
print("increasingArray06 : \(increasingArray06)\n")

// и тут тоже работает
var forCount = 0
for _ in 0..<increasingArray07.count {
    if arrayCondition(increasingArray07[forCount]) {
        increasingArray07.remove(at: forCount)
        forCount -= 1
    }
    forCount += 1
}
print("increasingArray07 : \(increasingArray07)\n")


                                // 5
//
print("5 task  __________________\n")
var array = [Int]()

func pushFibArray(array: inout [Int], count: Int){
    var f0 = 0
    var f1 = 1
    array.append(f0)
    array.append(f1)
    var res = 0
    var check = 0
    let center = (count-1) / 2
    for i in 1..<count-1 {
        if  i == center {
            check = 1
            f0 = 0
            f1 = 1
        }
        if check == 0 {
            res = f0 + f1
            f0 = f1
            f1 = res
        } else {
            res = f1 - f0
            f1 = f0
            f0 = res
        }
        array.append(res)
    }
}
pushFibArray(array: &array, count: 100)
print(array)
print("\(array.count)\n")


// это видимо плохой вариант
var array02 = [Int]()
func pushFibArray02(_ count: Int) -> Int {
    return count <= 1 ? 1 : (pushFibArray02(count - 1) + pushFibArray02(count - 2))

}

                                // 6
print("6 task  __________________\n")
var n = 100
var boolArray =  [Bool](repeatElement(true, count: n))
boolArray[0] = false
boolArray[1] = false
var i = 2

while  i * i <= n {
    if (boolArray[i] == true){
        var j = 2
        var count = 0
        while j <= n {
            j = i * i + i * count
            if (j >= n) {
                break
            }
            boolArray[j] = false
            count += 1
        }
    }
    i += 1
}

var simpleNumbersArray = [Int]()
for i in 2..<n {
    if (boolArray[i] == true){
        simpleNumbersArray.append(i)
    }
}
print(simpleNumbersArray)
