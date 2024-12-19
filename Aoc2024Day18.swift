import Foundation

struct Aoc2024Day18 {
    
    private let maxPoint = Point(x: 70, y: 70)
    private let maxCorruptedBytes = 1024
    private let inputFile = "2024/day18.txt"

    
    func part1() -> Int {
        
        var corruptedMemory = Set<Point>()
        
        _ = FileReader.init(name: inputFile) { line in
            
            if (!line.isEmpty && corruptedMemory.count < maxCorruptedBytes) {
                let cord = line.components(separatedBy: ",")
                let x = Int(cord[0]) ?? 0
                let y = Int(cord[1]) ?? 0
                corruptedMemory.insert(Point(x: x, y: y))
            }
        }
        
        var queue = [Point]()
        var visited = Set<Point>()
        let start = Point(x: 0, y:0)
        queue.append(start)
        visited.insert(start)
        var found = false
        var parent = [Point: Point]()
        
        while(!queue.isEmpty && !found) {
            let next = queue.removeFirst()
            for adj in getAdjacent(p: next).filter({p in !corruptedMemory.contains(p)}) {
                if (!visited.contains(adj)) {
                    visited.insert(adj)
                    queue.append(adj)
                    found = adj == maxPoint
                    parent[adj] = next
                }
            }
        }
        var end = maxPoint
        var steps = 0
        while (end != start) {
            steps += 1
            end = parent[end] ?? Point(x: -1, y: -1)
        }
        
        return steps
    }
    
    private func getAdjacent(p: Point) -> [Point] {
        return [
            Point(x: p.x, y: p.y - 1) ,// up
            Point(x: p.x, y: p.y + 1), //down
            Point(x: p.x - 1, y: p.y), //left
            Point(x: p.x + 1, y: p.y) //right
        ].filter {
            p in
            p.x >= 0 && p.y >= 0 && p.x <= maxPoint.x && p.y <= maxPoint.y
        }
    }
}

