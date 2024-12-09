

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

