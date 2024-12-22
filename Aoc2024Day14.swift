import Foundation

struct Aoc2024Day14 {
    
    private let inputFile = "2024/day14.txt"
    
    private let width = 101
    private let height = 103
    
    private var middleX: Int {
        width / 2
    }
    
    private var middleY: Int {
        height / 2
    }
    
    func part1() -> Int {
        
        var q1 = 0
        var q2 = 0
        var q3 = 0
        var q4 = 0
        
        _ = FileReader.init(name: inputFile) {line in
            let parts = line.components(separatedBy: [" ", "="])
            let p = parts[1]
            let v = parts[3]
            let result = normalizedRobot(p: p, v: v)
            let newPosition = calculatePosition(robot: result, time: 100)
            let newX = newPosition.0
            let newY = newPosition.1
            if (!(newX == middleX  || newY == middleY)) {
                if (newX < middleX && newY < middleY) {
                    q1 += 1
                }
                else if (newX > middleX && newY < middleY) {
                    q2 += 1
                }
                else if (newX < middleX && newY > middleY) {
                    q3 += 1
                }
                else {
                    q4 += 1
                }
            }
        }
        
        return q1 * q2 * q3 * q4
    }
    
    func part2() -> Int  {
        
        var robots = [(Point, Point)]()
        _ = FileReader.init(name: inputFile) {line in
            let parts = line.components(separatedBy: [" ", "="])
            let p = parts[1]
            let v = parts[3]
            let result = normalizedRobot(p: p, v: v)
            robots.append(result)
        }
        
        
        var set = Set<Point>()
        var time = 0
        while (set.count < 500) {
            time += 1
            let result = timePass(robots: robots, time: time)
            set = Set(result.map{$0.0})
        }
        printGrid(s: set)
        
        return time
    }
    
    private func timePass(robots: [(Point, Point)], time: Int) -> [(Point, Point)] {
        return robots.map {r in
            let pos = calculatePosition(robot: r, time: time)
            
            return (Point(x: pos.0, y: pos.1), r.1)
        }
    }
    
    private func printGrid(s: Set<Point>) {
        for y in 0..<height {
            var line = [Character]()
            for x in 0..<width {
                if (s.contains(Point(x: x, y: y))) {
                    line.append("0")
                }
                else {
                    line.append(".")
                }
            }
            print(String(line))
        }
    }
    
    
    func calculatePosition(robot: (Point, Point), time: Int) -> (Int, Int) {
        
        let newX = (robot.0.x + time * robot.1.x) % width
        let newY = (robot.0.y + time * robot.1.y) % height
        
        return (newX, newY)
    }
    
    func normalizedRobot(p: String, v: String) -> (Point,Point)  {
        let position = p.components(separatedBy: ",").map {Int($0) ?? 0}
        let velocity = v.components(separatedBy: ",").map {Int($0) ?? 0}
        
        let robot = Point(x: position[0], y: position[1])
        
        var vx = velocity[0] % width
        var vy = velocity[1] % height
        
        if (vx < 0) {
            vx = width + vx
        }
        
        if (vy < 0) {
            vy = height + vy
        }
        
        return (robot, Point(x: vx, y: vy))
    }
}

