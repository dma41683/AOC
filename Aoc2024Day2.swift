
import Foundation


struct Diff {
    let isSafe: Bool
    let isIncreasing: Bool
    
    init(isSafe: Bool, isIncreasing: Bool) {
        self.isSafe = isSafe
        self.isIncreasing = isIncreasing
    }
}

extension String {
    func splintWhitespaceToInt() -> Array<Int?> {
        components(separatedBy: .whitespaces)
            .map {Int($0)}
    }
}

func calcualteDiff(v1: Int, v2: Int) -> Diff {
    let diff = v1 - v2
    let absDiff = abs(diff)
    let isIncreasing = diff > 0
    let isSafe = absDiff >= 1 && absDiff <= 3
    
    return Diff(
                isSafe: isSafe,
                isIncreasing: isIncreasing)
}

private func isDiffSafe(d1: Diff?, d2: Diff) -> Bool {
    
    guard let d1 = d1 else {
        return d2.isSafe
    }
    
    return d1.isSafe && d2.isSafe &&
        d1.isIncreasing == d2.isIncreasing
    
}
struct Aoc2024Day2Results {
    let safe: Array<String>
    let unsafe: Array<String>
    
    init(safe: Array<String>, unsafe: Array<String>) {
        self.safe = safe
        self.unsafe = unsafe
    }
}

class Aoc2024Day2 {
    
    
    private let inputFile = "2024/day2.txt"
    
    
    func part1() -> Aoc2024Day2Results {
     
        var safe = Array<String>()
        var unsafe = Array<String>()

        _ = FileReader(name: inputFile)  {line in
            if !line.isEmpty && checkIsSafe(values: line.splintWhitespaceToInt()) {
                safe.append(line)
            }
            else {
                unsafe.append(line)
            }
        }
        
        return Aoc2024Day2Results.init(safe: safe, unsafe: unsafe)
    }
    
    func part2() -> Aoc2024Day2Results {
        
        var safe = Array<String>()
        var unsafe = Array<String>()


        _ = FileReader(name: inputFile)  {line in
            if !line.isEmpty && checkIsSafe2(values: line.splintWhitespaceToInt()) {
                safe.append(line)
            }
            else {
                unsafe.append(line)
            }
        }
        
        return Aoc2024Day2Results.init(safe: safe, unsafe: unsafe)
    }
    
    func checkIsSafe(values: Array<Int?>) -> Bool {
            
        var isSafe = true
        let end = values.count - 1
        var start = 0
        var prevDiff: Diff? = nil
        while (isSafe && start < end) {
            if let current = values[start], let next = values[start + 1] {
                
                let diff = calcualteDiff(v1: current, v2: next)
                
                isSafe = isDiffSafe(d1: prevDiff, d2: diff)
                prevDiff = diff
                
            } else {
                isSafe = false
            }
            start += 1
        }
        
        return isSafe
    }
    
    func checkIsSafe2(values: Array<Int?>) -> Bool {
        
        var isSafe = true
        var start = 0
        var prevDiff: Diff? = nil
        var indexToDrop: Int? = nil
        
        while (isSafe && start < values.count - 1) {
            if let current = values[start], let next = values[start + 1] {
                
                let diff = calcualteDiff(v1: current, v2: next)
                
                isSafe = isDiffSafe(d1: prevDiff, d2: diff)
                if (isSafe) {
                    prevDiff = diff
                    start += 1
                }
                else if (indexToDrop == nil) {
                    indexToDrop = start
                }
                
            } else {
                isSafe = false
            }
        }
        
        if (!isSafe) {
            if let indexToDrop = indexToDrop {
                var values2 = values
                values2.remove(at: indexToDrop)
                
                var values3 = values
                values3.remove(at: indexToDrop + 1)
                
                isSafe = checkIsSafe(values: values2) || checkIsSafe(values: values3)
                
                if (!isSafe && indexToDrop - 1 >  -1) {
                    var values0 = values
                    values0.remove(at: indexToDrop - 1)
                    isSafe = checkIsSafe(values: values0)
                }
                
            }
        }
        
        return isSafe
    }
}
