import Cocoa

var str = "Hello, playground"


/* type inference and checking */
let typeInferred = 3

let d0 = 3.1415
type(of: d0)

let d1: Double = 3
let d2 = 3 as Double
let d3 = Double(3)

// type check:
type(of: d1) == type(of: d2) &&
    type(of: d1) == type(of: d3) &&
    type(of: d2) == type(of: d3)


/* Convert a number to english words */
class Num2Word {
    static let numberMap = [
        0: "zero",
        1: "one",
        2: "two",
        3: "three",
        4: "four",
        5: "five",
        6: "six",
        7: "seven",
        8: "eight",
        9: "nine",
        10: "ten",
        11: "eleven",
        12: "twelve",
        13: "thirteen",
        14: "fourteen",
        15: "fifteen",
        16: "sixteen",
        17: "seventeen",
        18: "eighteen",
        19: "nineteen"
    ]

    static let tensMap = [
        2: "twenty",
        3: "thirty",
        4: "forty",
        5: "fifty",
        6: "sixty",
        7: "seventy",
        8: "eighty",
        9: "ninety"
    ]

    static let unitMap = [
        1: "thousand",
        2: "million",
        3: "billion",
        4: "trillion"
    ]
    
    static func apply(_ n: Int) -> String {
        // parse digits
        var num = n
        var digits: [Int] = []
        while num > 0 {
            let d = num % 10
            digits.insert(d, at: 0)
            num = num / 10
        }
        
        // group
        var nums = digits
        var groups: [[Int]] = []
        while nums.count > 0 {
            let group = nums.suffix(3)
            groups.insert(Array(group), at: 0)
            
            if nums.count >= 3 {
                nums.removeLast(3)
            } else {
                nums.removeAll()
            }
        }
        
        var words = [String]()
        
        for (idx, group) in groups.enumerated() {
            
            switch(group.count) {
            case 1:
                let num = group[0]
                let word = numberMap[num]
                words.append(word!)
            case 2:
                let num = group[0]
                if num == 1 {
                    let wholeNum = Int("1" + String(group[1]))
                    let word = numberMap[wholeNum!]
                    words.append(word!)
                } else {
                    let unitNum = group[0]
                    let word1 = tensMap[unitNum]!
                    words.append(word1)
                    
                    let onesPlace = group[1]
                    if onesPlace > 0 {
                        let word2 = numberMap[onesPlace]!
                        words.append(word2)
                    }
                }
            case _:
                let unitNum = group[0]
                let word100 = numberMap[unitNum]! + " hundred"
                words.append(word100)
                
                let tensNum = group[1]
                
                if tensNum == 1 {
                    let wholeNum = Int("1" + String(group[2]))
                    let word = numberMap[wholeNum!]
                    words.append(word!)
                } else {
                    let unitNum = group[1]
                    let word1 = tensMap[unitNum]!
                    words.append(word1)
                    
                    let onesPlace = group[2]
                    if onesPlace > 0 {
                        let word2 = numberMap[onesPlace]!
                        words.append(word2)
                    }
                }
            }
            
            let unitNum = groups.count - idx - 1
            let unit = unitMap[unitNum]
            if unit != nil {
                words.append(unit!)
            }
        }
        
        return words.joined(separator: " ")
    }
}

// function type
let num2word = Num2Word.apply

type(of: num2word)


assert(
    num2word(1234) ==
    "one thousand two hundred thirty four")
