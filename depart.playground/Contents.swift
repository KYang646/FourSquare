import UIKit


func findPrime(testRange: ClosedRange<Int>) -> [Int] {
    var returnArr = [Int]()
    var testAgainst = [2,3,5]
    for i in testRange {
        if testAgainst.contains(i) {
            returnArr.append(i)
        }
        if i % 2 != 0 && i % 3 != 0 && i % 5 != 0 && i != 1 {
            returnArr.append(i)
        }
    }
    return returnArr
}
var testRange = 1...100
print(findPrime(testRange: testRange))

func findBackwardsPrime(testRange: ClosedRange<Int>) -> [Any] {
    var returnArr = [Any]()
    var testAgainst = [2,3,5]
    for i in testRange {
        if i % 2 != 0 && i % 3 != 0 && i % 5 != 0 && i != 1 {
            returnArr.append(i)
            var string = String(i).reversed()
            var numReversed = Int(string)
        }
    }
    return returnArr
}
var testRange2 = 1...100
print(findBackwardsPrime(testRange: testRange2))
