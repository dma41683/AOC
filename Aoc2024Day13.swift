import Foundation



fileprivate struct Machine {
    
    let buttonA: Point
    let buttonB: Point
    let prize: Point
    
    func part2() -> Machine {
        return Machine(buttonA: buttonA,
                       buttonB: buttonB,
                       prize: Point(x: prize.x + 10000000000000,
                                    y: prize.y + 10000000000000))
    }
}

fileprivate extension Machine {
    
    
    func didGetPrize(move: (Int, Int)) -> Bool {
        
        return move.0 * buttonA.x + move.1 * buttonB.x == prize.x &&
        move.0 * buttonA.y + move.1 * buttonB.y == prize.y
    }
    
    func solveA() -> (Int, Int) {
        
        let X = prize.x
        let Y = prize.y
        let C = buttonA.x
        let D = buttonA.y
        let E = buttonB.x
        let F = buttonB.y
        
        let A = (E * Y - F * X) / (D * E - F * C)
        let B = (X - A * C) / E

        return (A,B)
    }
    
    func solveB() -> (Int, Int) {
        
        let X = prize.x
        let Y = prize.y
        let C = buttonA.x
        let D = buttonA.y
        let E = buttonB.x
        let F = buttonB.y
        
        let B = (-1 * C * Y + D * X) / (E * D - F * C)
        let A = (X - B * E) / C

        return (A,B)
    }
}

struct Aoc2024Day13 {
    
    private let inputFile = "2024/day13.txt"

    
    func part1() -> Int {
        
        var butonPresses = [(Int, Int)]()
        
        parseInput().forEach {m in
          let presses = [m.solveA(), m.solveB()]
                .filter {m.didGetPrize(move: $0)}
                .sorted { tokensUsed(move: $0) < tokensUsed(move: $1)}.first
            
            if let presses {
                butonPresses.append(presses)
            }
        }
        
        return butonPresses.reduce(0) {$0 + tokensUsed(move: $1)}
    }
    
    func part2() -> Int {
        
        var butonPresses = [(Int, Int)]()
        
        parseInput()
            .map {m in m.part2() }.forEach {m in
          let presses = [m.solveA(), m.solveB()]
                .filter {m.didGetPrize(move: $0)}
                .sorted { tokensUsed(move: $0) < tokensUsed(move: $1)}.first
            
            if let presses {
                butonPresses.append(presses)
            }
        }
        
        return butonPresses.reduce(0) {$0 + tokensUsed(move: $1)}
    }
    
    func tokensUsed(move: (Int, Int)) -> Int {
        
        return 3 * move.0 + move.1
    }
    
    private func parseInput() -> [Machine] {
        
        var list = [Machine]()
        var buttonA: Point? = nil
        var buttonB: Point? = nil
        var prize: Point? = nil
        
        _ = FileReader.init(name: inputFile) { line in
            
            if (line.isEmpty) {
                return
            }
            
            let info = line
                .components(separatedBy: [":", "X", "Y", "+", "=", ",", " "])
                .filter {!$0.isEmpty && $0 != "Button"}
            let value = info.first ?? ""
            let x = Int(info[1]) ?? 0
            let y = Int(info[2]) ?? 0
            if (value.starts(with: "A")) {
                buttonA = Point(x: x, y: y)
            }
            else if (value.starts(with: "B")) {
                buttonB = Point(x: x, y: y)
            }
            
            else {
                prize = Point(x: x, y: y)
            }
            
            if let a = buttonA, let b = buttonB, let p = prize {
                let m = Machine(buttonA: a, buttonB: b, prize: p)
                list.append(m)
                buttonA = nil
                buttonB = nil
                prize = nil
            }
        }
         
        return list
    }
}
