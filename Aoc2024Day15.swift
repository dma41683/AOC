
import Foundation

class Aoc2024Day15 {
    
    private let inputFile = "2024/day15.txt"
    
    private var map = [Point: Character]()
    private var currentLocation = Point(r: 0, c: 0)
    
    func part1() -> Int {
        let movments = parseInput()
        
        movments.forEach {m in
            if (canMove(move: m, position: currentLocation)) {
                currentLocation = getPostion(start: currentLocation, move: m)
            }
        }
        
        return map.keys.filter {map[$0] == "O" }.reduce(0) {r, p in r + 100 * p.r + p.c  }
    }
    
    private func canMove(move: Character, position: Point) -> Bool {
        let next = getPostion(start: position, move: move)
        var allow = false
        let obj = map[next]
        if (obj == nil || obj == "#") {
            allow = false
        }
        else if (obj == ".") {
            allow = true
        }
        else {
            allow = canMove(move: move, position: next)
        }
        
        if (allow) {
            let currentObj = map[position]
            map[position] = "."
            map[next] = currentObj
        }
        
        return allow
    }
    
    private func getPostion(start: Point, move: Character) -> Point {
        var r = start.r
        var c = start.c
        
        switch(move) {
        case "<":
            c = c - 1
        case ">":
            c = c + 1
        case "^":
            r = r  - 1
        case "v":
            r = r + 1
        default:
            break
        }
        
        return Point(r: r, c: c)
    }
    
    private func parseInput() -> [Character] {
        
        var movements = [Character]()
        map.removeAll()
        
        var readMovments = false
        var row = 0
        
        _ = FileReader.init(name: inputFile) { line in
            if (readMovments) {
                line.forEach {movements.append($0)}
            }
            else if (line.isEmpty) {
                readMovments = true
            }
            else {
                var col = 0
                line.forEach { c in
                    let p = Point(r: row, c: col)
                    if (c == "@") {
                        currentLocation = p
                        map[p] = "."
                    }
                    else {
                        map[p] = c
                    }
                    col += 1
                }
                row += 1
            }
          
        }
        
        return movements
    }
    
    private func printMap() {
        for row in 0...7 {
            var line = [Character]()
            for col in 0...7 {
                line.append(map[Point(r: row, c: col)] ?? "-")
            }
            print(String(line))
        }
    }
}
