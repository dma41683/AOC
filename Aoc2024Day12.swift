

import Foundation


class Aoc2024Day12 {
    
    private let inputFile = "2024/day12.txt"
    
    private var plots: Set<Point>!
    
    func part1() -> Int {
        
        let input = parseInput(file: inputFile)
        plots = Set(input.keys)
        var results = [(Int, [(String, Point)])]()
        
        while(!plots.isEmpty) {
            if let point = plots.first {
                let r =  measure(point: point, input: input)
                results.append(r)
            }
        }
        
        return results.map {r in r.0 * r.1.count}.reduce(0, +)
    }
    
    func part2() -> Int {
        
        let input = parseInput(file: test)
        plots = Set(input.keys)
        var results = [(Int, [(String, Point)])]()
        
        while(!plots.isEmpty) {
            if let point = plots.first {
                let r =  measure(point: point, input: input)
               
                results.append(r)
            }
        }
        
        return results.map {r in r.0 * countSides(edges: r.1, plot: input[r.1[0].1] ?? "-")}.reduce(0, +)
    }
    
    // (area, perimeter/sides)
    func measure(point: Point, input: [Point: Character]) -> (Int, [(String, Point)]) {
        
        if (!plots.contains(point)) {
            return (0,[])
        }
        plots.remove(point)
        
        
       let up = Point(r: point.r, c: point.c - 1) // up
       let down = Point(r: point.r, c: point.c + 1) // down
       let left = Point(r: point.r - 1, c: point.c) //left
       let right = Point(r: point.r + 1, c: point.c) // rigt
        
        let directions = [up,down, left,right]
        let dict = [
            up: ("H", up),
            down: ("H", down),
            left: ("V", left),
            right: ("V", right)
        
        ]
        
        let plot = input[point]
        let perimeter = directions.filter { input[$0] != plot }.map {
            dict[$0] ?? ("-", Point(x: -2, y: -2))
        }
        
        let m = directions
            .filter {d in input[d] == plot }
            .map { measure(point: $0, input: input) }
            .reduce((0,[])) {($0.0 + $1.0, $0.1 + $1.1)}
        
        return (m.0 + 1, m.1 + perimeter)
    }
    
    func countSides(edges: [(String,Point)], plot: Character) -> Int {
        
        let H = edges.filter {$0.0 == "H"}.sorted { p1, p2 in
            p1.1.c < p2.1.c || p1.1.c == p2.1.c && p1.1.r < p2.1.r
        }
        let V = edges.filter{$0.0 == "V"}.sorted {p1, p2 in
            p1.1.r < p2.1.r || p1.1.r == p2.1.r && p1.1.r < p2.1.r
            
        }
        
        var sides = countSides2(edges: H)
        print(V)
        sides += countSides2(edges: V)
     
        return sides
    }
    
    private func countSides2(edges: [(String,Point)]) -> Int {
        
        var current: (String,Point)? = nil
        var sides = 0
        for e in edges {
            if (current?.1.c == e.1.c && current?.1.r == e.1.r + 1) {}
            else if (current?.1.r == e.1.r && current?.1.c == e.1.c + 1) { }

            else {
                sides += 1
            }
            current = e
        }
        return sides
    }
}
