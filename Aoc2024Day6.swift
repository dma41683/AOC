

import Foundation




class Aoc2024Day6 {
    
    private let inputFile = "2024/day6.txt"
    
    
    func part1() -> Int {
        
        var row = 0
        var guardPosition = (-1,-1)
        var map = Array<Array<Character>>()
        
        _ = FileReader(name:inputFile) {line in
            
            let r = Array(line)
            if let col = r.firstIndex(of: "^") {
                guardPosition = (row,col)
            }
            map.append(r)
            row += 1
        }
        
        return traverse(map: map, start: guardPosition)
    }
    
    func part2() -> Int {
        
        var row = 0
        var guardPosition = (-1,-1)
        var map = Array<Array<Character>>()
        
        _ = FileReader(name: inputFile) {line in
            
            let r = Array(line)
            if let col = r.firstIndex(of: "^") {
                guardPosition = (row,col)
            }
            map.append(r)
            row += 1
        }
        var count = 0
        map.indices.forEach {r in
            map[r].indices.forEach { c in
                let o = map[r][c]
                if (o != "^" && o != "#") {
                    map[r][c] = "#"
                    if (traverse(map: map, start: guardPosition) == -1) {
                        count += 1
                    }
                    map[r][c] = "."
                    
                }
            }
        }
        return count
    }
}

enum Direction {
    case UP
    case DOWN
    case LEFT
    case RIGHT
}

/*
            UP(-1,0)
   LEFT(0,-1)  ^   RIGHT(0,1)
            DOWN(1,0)
 */
extension Direction {
    
    func getLabel() -> String {
       
        switch(self) {
        case .UP:
            return "U"
        case .RIGHT:
            return "R"
        case .DOWN:
            return "D"
        case .LEFT:
            return "L"
        }
    }
    
    
    func getMove() -> (Int,Int) {
       
        switch(self) {
        case .UP:
            return (-1,0)
        case .RIGHT:
            return (0,1)
        case .DOWN:
            return (1,0)
        case .LEFT:
            return (0,-1)
        }
    }
    
    func turnRight() -> Direction {
        switch(self) {
        case .UP:
            return .RIGHT
        case .RIGHT:
            return .DOWN
        case .DOWN:
            return .LEFT
        case .LEFT:
            return .UP
        }
    }
}

extension Aoc2024Day6 {
    
    func move(d: Direction, pos: (Int, Int)) -> (Int, Int) {
        let m = d.getMove()
        return (pos.0 + m.0, pos.1 + m.1)
    }
    
    func didLeaveMap(map: Array<Array<Character>>, pos: (Int, Int)) -> Bool {
        return pos.0 < 0 ||
        pos.0 >= map.count ||
        pos.1 < 0 ||
        pos.1 >= map[pos.0].count
    }
    
    func isobstacle(map: Array<Array<Character>>, pos: (Int,Int)) -> Bool {
        return map[pos.0][pos.1] == "#"
    }

    
    func traverse(map: Array<Array<Character>>, start: (Int, Int)) -> Int {
       
        var direction = Direction.UP
        var pos = start
        var gone = false
        var visted = Set<String>()
        var hasCycle = false
        var vistedWithDirection = Set<String>()
        while(!gone && !hasCycle) {
            let s = "(\(pos.0),\(pos.1))"
            visted.insert(s)
            let nextMove = move(d: direction, pos: pos)
            gone = didLeaveMap(map: map, pos: nextMove)
            if (!gone) {
                if (isobstacle(map: map, pos: nextMove)) {
                    let node = "\(s)\(direction.getLabel())"
                    hasCycle = vistedWithDirection.contains(node)
                    vistedWithDirection.insert(node)
                    direction = direction.turnRight()
        
                } else {
                    pos = nextMove
                }
            }
        }
        
        if (!hasCycle) {
         return visted.count
        }
        else {
            return -1
        }
        
    }
    
}

