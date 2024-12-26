import Foundation


class Aoc2024Day24 {
    
    private let inputFile = "2024/day24.txt"

    
    private var wires = [String: Bool]()
    private var equations = [String:[String]]()
    
    
    func part1() -> Int {
        
        var isInput = true
        
        _ = FileReader(name: inputFile) {line in
            if (line.isEmpty && isInput) {
                isInput = false
            }
            else {
                if (isInput) {
                    let componets = line.components(separatedBy: [":", " "])
                    let wire = componets.first ?? ""
                    let output = componets.last == "1"
                    wires[wire] = output
                }
                else {
                    let parts = line.components(separatedBy: ["-", ">", " "])
                    let key = parts.last ?? ""
                    equations[key] = parts
                }
            }
        }
        for k in equations.keys {
            _ = solveEquation(wire: k)
        }
        
        
        return wires.keys
            .filter { k in k.starts(with: "z")}
            .sorted()
            .map {k in wires[k] == true ? 1 : 0}
            .enumerated()
            .reduce(0) {
                return $0 + $1.1 * Int(pow(Double(2), Double($1.0)))
            }
    }
    
    private func doOp(in1: Bool, op: String, in2: Bool) -> Bool {
        var result = false
        switch(op) {
        case "AND":
            result = in1 && in2
        case "OR":
            result = in1 || in2
        case "XOR":
            result = in1 != in2
        default:
            result = false
        }
        
        return result
    }
    
    private func solveEquation(wire: String) -> Bool {
        if let result = wires[wire] {
            return result
        }
        
        if let eq = equations[wire] {
            let in1 = solveEquation(wire:eq[0])
            let op = eq[1]
            let in2 = solveEquation(wire: eq[2])
            
            let result = doOp(in1: in1, op: op, in2: in2)
            wires[wire] = result
            
            return result
        }
        return false
    }
}

