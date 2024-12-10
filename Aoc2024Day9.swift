
import Foundation

struct Aoc2024Day9 {
    
    private let inputFile = "2024/day9.txt"
    
    func part1() -> Int {
        
        let output = parseInput()
        var files = output.0
        let freeBlocks = output.1
        
        var disk = Array<Int>()
        var freeSpace = 0
        var first = 0
        var last = files.count - 1
        
        while (last >= first) {
            
            if (freeSpace == 0) {
                let size = files[first]
                disk.append(contentsOf: [Int](repeating:first, count: size))
                if (first < freeBlocks.count) {
                    freeSpace = freeBlocks[first]
                }
                first += 1
            }
            else if (freeSpace >= files[last]) {
                let size = files[last]
                disk.append(contentsOf: [Int](repeating: last, count: size))
                freeSpace = freeSpace - size
                last = last  - 1
            }
            else {
                let size = files[last]
                disk.append(contentsOf: [Int](repeating: last, count: freeSpace))
                files[last] = size - freeSpace
                freeSpace = 0
            }
        }
        var sum = 0
        for (index, fid) in disk.enumerated() {
            sum += index * fid
        }
        return sum
    }
    
    func part2() -> Int {
        return 0
    }
}




extension Aoc2024Day9 {
    
  func parseInput() -> (Array<Int>, Array<Int>) {
            
            var files = Array<Int>()
            var freeBlocks = Array<Int>()
            var i = 0
            _ = FileReader.init(name: test) {line in
                Array(line).forEach {c in
                    let size = charToIntMap[c] ?? 0
                    if (i.isEven()) {
                        files.append(size)
                    } else {
                        freeBlocks.append(size)
                    }
                    i += 1
                }
            }
            return (files, freeBlocks)
        }
}





