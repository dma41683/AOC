import Foundation

struct Aoc2024Day11 {
    
    private let inputFile = "2024/day11.txt"
    
    func part1() -> Int {
        return blinks(blinks: 25)
    }
    
    func part2() -> Int {
        return blinks(blinks: 75)
    }
}

extension Aoc2024Day11 {
    
    
     func blinks(blinks: Int) -> Int {
        var input = [Int?]()
        _ = FileReader.init(name: inputFile) { line in
            input = line.splintWhitespaceToInt()
        }
        
        var sum = 0
        input.forEach {  num in
            if let num = num {
                sum += calcStonesAfterBlink(startValue: num,
                                            blinks: blinks).count
                
            }
        }
        
        return sum
    }
    
    
    func calcStonesAfterBlink(startValue: Int, blinks: Int) -> [Int] {
        
        var start = [startValue]
        for _ in 1...blinks {
            var next = [Int]()
            for e in start {
                if (e == 0) {
                    next.append(1)
                }
                else if (e.countDigits().isEven()) {
                    next.append(contentsOf: e.splitNumber())
                }
                else {
                    next.append(e * 2024)
                }
            }
            start = next
        }
        return start
    }
    
}

extension Int {
    fileprivate func splitNumber() -> [Int] {
        let y = countDigits() / 2
        let factor = Int(pow(Double(10), Double(y)))
        
        return [self / factor, self % factor]
    }
}
