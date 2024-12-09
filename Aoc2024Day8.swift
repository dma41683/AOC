
import Foundation

struct Aoc2024Day8 {
    
    private let inputFile = "2024/day8.txt"

    
    func part1() -> Int {
        
        var antennas = Dictionary<Character,Array<Point>>()
        var antinodes = Set<Point>()
        var maxX = 0
        var maxY = 0
        var r = 0
        _ = FileReader.init(name: inputFile) {line in
            maxY = r
            for (c, char) in Array(line).enumerated() {
                maxX = max(maxX, c)
                if (char != ".") {
                    let p = Point(r: r, c: c)
                    var list = antennas[char] ?? Array<Point>()
                    antinodes = antinodes.union(calcAllAntinodesLocation(p: p, list: list))
                    list.append(p)
                    antennas[char] = list
                }
            }
            r += 1
        }
        return antinodes.filter {$0.x > -1 && $0.y > -1 && $0.x <= maxX && $0.y <= maxY}.count
    }
    
    
    func part2() -> Int {
        
        var input = Array<Array<Character>>()
        _ = FileReader.init(name: inputFile) {line in
            input.append(Array(line))
        }
        let maxPoint = Point(r: input.count - 1,
                             c: input[0].count - 1)
        var antennas = Dictionary<Character,Array<Point>>()
        var antinodes = Set<Point>()
        var r = 0
        
        while(r < input.count) {
            var c = 0
            while(c < input[r].count) {
                let char = input[r][c]
                if (char != ".") {
                    let p = Point(r: r, c: c)
                    var list = antennas[char] ?? Array<Point>()
                    antinodes = antinodes.union(calcAllAntinodesLocation2(p: p, list: list, maxPoint: maxPoint))
                    list.append(p)
                    antennas[char] = list
                    
                }
                c += 1
            }
            r += 1
        }
        return antinodes.count
    }
}

extension Point {
    
    func isInRange(min: Point = Point(x:0,y:0), max: Point) -> Bool {
        let x = self.x
        let y = self.y
        
        return x >= min.x && x <= max.x &&
        y >= min.y && y <= max.y
        
    }
    
    func isEqual(p: Point) -> Bool {
        return self.x == p.x && self.y == p.y
    }
}

extension Aoc2024Day8 {
    
    
    func calcAllAntinodesLocation2(p: Point, list:Array<Point>, maxPoint: Point) -> Array<Point> {
        var antinodes = Array<Point>()
        
        for p2 in list {
            antinodes.append(contentsOf:calcAllAntinodesOnLine(p1: p, p2: p2, maxPoint: maxPoint))
        }
        
        return antinodes
    }
    
    func calcAllAntinodesOnLine(p1: Point, p2: Point, maxPoint: Point) -> Array<Point> {
        
        var antinodes = Array<Point>()
        let m = calcSlope(p1: p1, p2: p2)
        
        var nextPoint = p2
        while(nextPoint.isInRange(max: maxPoint)) {
            
            antinodes.append(nextPoint)
             nextPoint =  Point(x: nextPoint.x + m.x,
                           y: nextPoint.y + m.y)
        }
        
        nextPoint = p2
        while(nextPoint.isInRange(max: maxPoint)) {
            antinodes.append(nextPoint)
             nextPoint =  Point(x: nextPoint.x - m.x,
                           y: nextPoint.y - m.y)
        }
        
        return antinodes
    }
    
    func calcSlope(p1: Point, p2: Point) -> Point {
        return Point(r:p2.y - p1.y, c:p2.x - p1.x)

    }
    
    func isOnSameLine(p1: Point, p2: Point, p3: Point) -> Bool {
        
        let m1 = calcSlope(p1: p1, p2: p2)
        let m2 = calcSlope(p1: p1, p2: p3)
        
        return m1.y * m2.x == m1.x * m2.y
    }
    
    func calcManhattanDistance(p1: Point, p2: Point) -> Int {
        return abs(p1.x - p2.x) + abs(p1.y - p2.y)
    }
    
    func calcAllAntinodesLocation(p: Point, list:Array<Point>) -> Array<Point> {
        var antinodes = Array<Point>()
        
        for m in list {
            antinodes.append(calcAntinodesLocation(p: p, m: m))
            antinodes.append(calcAntinodesLocation(p: m, m: p))
        }
        
        return antinodes
    }
    
    func calcAntinodesLocation(p: Point, m: Point) -> Point {
        let x = 2 * m.x - p.x
        let y = 2 * m.y - p.y
        
        return Point.init(x: x, y: y)
    }
}
