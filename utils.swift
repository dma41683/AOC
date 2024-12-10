

import Foundation

struct Point: Hashable {
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
}

extension Int {
    func isEven() -> Bool {
        return self % 2 == 0
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

