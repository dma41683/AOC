import Foundation

struct Aoc2024Day10 {
    
    private let inputFile = "2024/day10.txt"
    
    func part1() -> Int {
        let input = parseInput()
        let startingPoints = getStartingPoints(input: input)
        let allowSteps = getAllowSeteps(input: input)
       
        var sum = 0
        for p in startingPoints {
            sum += Set(findTrails(p:p, steps: allowSteps, input: input)).count
        }
                
        return sum
        
    }
    
    func part2() -> Int {
        let input = parseInput()
        let startingPoints = getStartingPoints(input: input)
        let allowSteps = getAllowSeteps(input: input)
       
        var sum = 0
        for p in startingPoints {
            sum += findTrails(p:p, steps: allowSteps, input: input).count
        }
                
        return sum
        
    }
}

extension Aoc2024Day10 {
    
    fileprivate func findTrails(p: Point, steps:[Point:[Point]], input:[Point: Character]) -> [Point] {
        if (input[p] == "9") {
            return [p]
        }
        
        let s = steps[p]
        guard let s, s.count > 0 else  {
            return []
        }
        
        var allPoints = [Point]()
        
        s.forEach { st in
            allPoints += findTrails(p: st, steps: steps, input: input)
            
        }
        
        return allPoints
    }
    
    
    fileprivate func parseInput() -> Dictionary<Point, Character> {
        
        var input = Dictionary<Point,Character>()
        var r = 0
        _ = FileReader.init(name: inputFile) {line in
            for (c, v) in Array(line).enumerated() {
                input[Point(r: r, c: c)] = v
            }
            r += 1
        }
        
        return input
    }
    
    fileprivate func getStartingPoints(input: [Point: Character]) -> [Point] {
        
        var startingPoints = Array<Point>()
        
        for k in input.keys {
            if (input[k] == "0") {
                startingPoints.append(k)
            }
        }
        
        return startingPoints
    }
    
    func getAllowSeteps(input: [Point: Character]) -> [Point:[Point]] {
    
        var allowSteps = Dictionary<Point,Array<Point>>()

        for k in input.keys {
            allowSteps[k] = findValidNextPoints(at: k,
                                                input: input)
        }
        return allowSteps
    }
    
    fileprivate func findValidNextPoints(at point: Point, input: Dictionary<Point,Character>) -> Array<Point>? {
        
        guard let c = input[point] else {
            return nil
        }
        
        guard let value = charToIntMap[c] else {
            return nil
        }
        
        guard let char = intToCharMap[value + 1] else {
            return nil
        }
        
        let up = Point(x: point.x, y: point.y - 1)
        let down = Point(x: point.x, y: point.y + 1)
        let left = Point(x: point.x - 1, y: point.y)
        let right = Point(x: point.x + 1, y: point.y)
       
        return [up,down,left,right].filter { input[$0] == char }




        
    }
}
