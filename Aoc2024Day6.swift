

import Foundation




class Aoc2024Day6 {
    
    private let inputFile = "2024/day6.txt"
    
    
    func part1() -> Int {
        
        var row = 0
        var guardPosition = Point(r: -1, c: -1)
        var map = Array<Array<Character>>()
        
        _ = FileReader(name:inputFile) {line in
            
            let r = Array(line)
            if let col = r.firstIndex(of: "^") {
                guardPosition = Point(r: row,c: col)
            }
            map.append(r)
            row += 1
        }
        
        return traverse(map: map, start: guardPosition)?.count ?? 0
    }
    
    func part2() -> Int {
        
        var row = 0
        var guardPosition = Point(r: -1, c: -1)
        var map = Array<Array<Character>>()
        
        _ = FileReader(name: inputFile) {line in
            
            let r = Array(line)
            if let col = r.firstIndex(of: "^") {
                guardPosition = Point(r: row,c: col)
            }
            map.append(r)
            row += 1
        }
        var count = 0
        let visited = traverse(map: map, start: guardPosition)
        
        visited?.forEach {point in
            let r = point.r
            let c = point.c
            let o = map[r][c]
            if (o != "^" && o != "#") {
                    map[r][c] = "#"
                    if (traverse(map: map, start: guardPosition) == nil) {
                        count += 1
                    }
                    map[r][c] = "."
                    
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
    
    
    func getMove() -> Point {
       
        switch(self) {
        case .UP:
            return Point(r: -1, c: 0)
        case .RIGHT:
            return Point(r: 0,c: 1)
        case .DOWN:
            return Point(r:1, c:0)
        case .LEFT:
            return Point(r:0,c:-1)
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
    
    func move(d: Direction, pos: Point) -> Point {
        let m = d.getMove()
        return Point(r: pos.r + m.r,
                     c: pos.c + m.c)
    }
    
    func didLeaveMap(map: Array<Array<Character>>, pos: Point) -> Bool {
        return pos.r < 0 ||
        pos.r >= map.count ||
        pos.c < 0 ||
        pos.c >= map[pos.r].count
    }
    
    func isobstacle(map: Array<Array<Character>>, pos: Point) -> Bool {
        return map[pos.r][pos.c] == "#"
    }

    
    func traverse(map: Array<Array<Character>>, start: Point) -> Set<Point>? {
       
        var direction = Direction.UP
        var pos = start
        var gone = false
        var visted = Set<Point>()
        var hasCycle = false
        var vistedWithDirection = Set<String>()
        while(!gone && !hasCycle) {
            visted.insert(pos)
            let nextMove = move(d: direction, pos: pos)
            gone = didLeaveMap(map: map, pos: nextMove)
            if (!gone) {
                if (isobstacle(map: map, pos: nextMove)) {
                    let node = "\(pos.r),\(pos.c)\(direction.getLabel())"
                    hasCycle = vistedWithDirection.contains(node)
                    vistedWithDirection.insert(node)
                    direction = direction.turnRight()
        
                } else {
                    pos = nextMove
                }
            }
        }
        
        if (!hasCycle) {
         return visted
        }
        else {
            return nil
        }
        
    }
    
}

