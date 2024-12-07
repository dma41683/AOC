import Foundation

struct Aoc2024Day7 {
    

    private let inputFile = "2024/day7.txt"

    
    func part1() -> Int {
        let ops = [Operation.A,
                   Operation.M]
        
        return runWithOperations(ops: ops)
    }
    
    func part2() -> Int {
        let ops = [Operation.A,
                   Operation.M,
                   Operation.C]
        
        return runWithOperations(ops: ops)
        
    }
}


extension String {
    
    func splitToInt() -> Array<Int> {
        components(separatedBy: CharacterSet(charactersIn: " :"))
            .filter {!$0.isEmpty}
            .map {
                return Int($0) ?? -1
                
            }
    }
}

enum Operation {
    case A
    case M
    case C
}

extension Int {
    
    func countDigits() -> Int {
        return Int(log10(Double(self))) + 1
    }
}

extension Operation {

    func doMath(a: Int, b: Int) -> Int {
        switch(self) {
        case .A:
            return a + b
        case .M:
            return a * b
        case .C:
            //return Int("\(a)\(b)") ?? 0
            return a * Int(pow(Double(10), Double(b.countDigits()))) + b
        }
    }
}

extension Aoc2024Day7 {
    
    func runWithOperations(ops: Array<Operation>) -> Int {
       
        var sum: Int = 0
        _ = FileReader(name: inputFile) { line in
            if (!line.isEmpty) {
               let input = line.splitToInt()
                if (calc(input: input,
                         a: input[1],
                         index: 2,
                        ops: ops)) {
                    sum += input[0]
                }
                
            }
        }
        
        return sum
    }
    
    func calc(input: Array<Int>, a: Int, index: Int, ops: Array<Operation>) -> Bool {
        
        let ans = input[0]
        
        if (a > ans) {
            return false
        }
        
        if (index == input.count) {
            return ans == a

        }
        var isValid = false
        var opi = 0
        while(!isValid && opi < ops.count) {
            
            isValid = calc(
                input: input,
                a: ops[opi].doMath(a: a, b: input[index]),
                index: index + 1,
                ops: ops)
            opi += 1
        }
        
        return isValid
    }
}

