

import Foundation

struct Point: Hashable, CustomStringConvertible {
    let r: Int
    let c: Int
    
    var x: Int {
        return c
    }
    
    var y: Int {
        return r
    }
    
    init(x: Int, y: Int) {
        self.r = y
        self.c = x
    }
    
    init(r: Int, c: Int) {
        self.r = r
        self.c = c
    }
    var description: String {
        return "(\(c),\(r))"
    }
}



extension Int {
    func isEven() -> Bool {
        return self % 2 == 0
    }
            
        func countDigits() -> Int {
            return Int(log10(Double(self))) + 1
        }
}

let charToIntMap: Dictionary<Character,Int> = [
    "0" : 0,
    "1" : 1,
    "2" : 2,
    "3" : 3,
    "4" : 4,
    "5" : 5,
    "6" : 6,
    "7" : 7,
    "8" : 8,
    "9" : 9
]

let intToCharMap: Dictionary<Int,Character> = [
    0 : "0",
    1 : "1",
    2 : "2",
    3 : "3",
    4 : "4",
    5 : "5",
    6 : "6",
    7 : "7",
    8 : "8",
    9 : "9"
]

extension Dictionary {

    func printKeyValues() {
        for (k,v) in self {
            print("\(k) -> \(v)")
        }
    }
}

func parseInput(file: String) -> Dictionary<Point, Character> {
    
    var input = Dictionary<Point,Character>()
    var r = 0
    _ = FileReader.init(name: file) {line in
        for (c, v) in Array(line).enumerated() {
            input[Point(r: r, c: c)] = v
        }
        r += 1
    }
    
    return input
}

