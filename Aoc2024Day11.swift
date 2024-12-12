import Foundation

class Aoc2024Day11 {
    
    private let inputFile = "2024/day11.txt"
    
    private var cache = [Point: Int]()
    
    func part1() -> Int {
        
        var input = [Int?]()
        _ = FileReader.init(name: inputFile) { line in
            input = line.splintWhitespaceToInt()
        }
        var count = 0
        
        input.forEach {stone in
            if let stone = stone {
                count += countStones(stone: stone, blinks: 25)
            }
        }
        
        return count
    }
    
    func part2() -> Int {
        var input = [Int?]()
        _ = FileReader.init(name: inputFile) { line in
            input = line.splintWhitespaceToInt()
        }
        var count = 0
        
        input.forEach {stone in
            if let stone = stone {
                count += countStones(stone: stone, blinks: 75)
            }
        }
        
        return count
    }
    
    func blink(stone: Int) -> [Int] {
        if (stone == 0) {
            return [1]
        }
        else if (stone.countDigits().isEven()) {
            return stone.splitNumber()
        }
        else {
            return [stone * 2024]
        }
    }
    
    func countStones(stone: Int, blinks: Int) -> Int {

        if let value = cache[Point(x:stone, y:blinks)] {
            return value
        }
        
        if (blinks == 0) {
            return 1
        }
        
        let stones = blink(stone: stone)
        let nextBlinks = blinks - 1
        let countFirst = countStones(stone: stones[0], blinks: nextBlinks)
        cache[Point(x: stones[0], y: nextBlinks)] = countFirst
        
        var countSecond = 0
        if (stones.count > 1) {
            countSecond = countStones(stone: stones[1], blinks: nextBlinks)
            cache[Point(x: stones[1], y: nextBlinks)] = countSecond
            
        }
        
        return countFirst + countSecond
    }
}

extension Int {
    fileprivate func splitNumber() -> [Int] {
        let y = countDigits() / 2
        let factor = Int(pow(Double(10), Double(y)))
        
        return [self / factor, self % factor]
    }
}
