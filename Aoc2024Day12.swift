

import Foundation


class Aoc2024Day12 {
    
    private let inputFile = "2024/day12.txt"
    
    private var plots: Set<Point>!
    
    func part1() -> Int {
        
        let input = parseInput(file: inputFile)
        plots = Set(input.keys)
        var results = [(Int, Int)]()
        
        while(!plots.isEmpty) {
            if let point = plots.first {
                let r =  measure(point: point, input: input)
                results.append(r)
            }
        }
        
        return results.map {r in r.0 * r.1}.reduce(0, +)
    }
    
    // (area, perimeter/sides)
    func measure(point: Point, input: [Point: Character]) -> (Int, Int) {
        
        if (!plots.contains(point)) {
            return (0,0)
        }
        plots.remove(point)
        
        let directions = [
            Point(r: point.r, c: point.c - 1), // up
            Point(r: point.r, c: point.c + 1), // down
            Point(r: point.r - 1, c: point.c), //left
            Point(r: point.r + 1, c: point.c) // rigt
        ]
        
        let plot = input[point]
        let perimeter = directions.map {input[$0] == plot  ? 0 : 1}.reduce(0) {$0 + $1}
        
        let m = directions
            .filter {d in input[d] == plot }
            .map { measure(point: $0, input: input) }
            .reduce((0,0)) {($0.0 + $1.0, $0.1 + $1.1)}
        
        return (m.0 + 1, m.1 + perimeter)
    }
}
