import Foundation


struct Aoc2024Day23 {
    
    private let inputFile = "2024/day23.txt"    
    
    func part1() -> Int  {
        
        var connections = [String: Set<String>]()
        var sets = [[String]]()
        
        _ = FileReader.init(name: test) { line in
            let pair = line.components(separatedBy: "-")
            let c1 = pair[0]
            let c2 = pair[1]
            
            var allC1Connections = connections[c1] ?? Set<String>()
            let c13connect = allC1Connections.map {c3 in
                [c1,c2,c3]
            }
            sets.append(contentsOf: c13connect)
            allC1Connections.insert(c2)
            connections[c1] = allC1Connections
            
            var allC2Connections = connections[c2] ?? Set<String>()
            let c23connect = allC2Connections.map {c3 in
                [c2, c3,c1]
            }
            sets.append(contentsOf: c23connect)
            allC2Connections.insert(c1)
            connections[c2] = allC2Connections
        }
        let cycles = sets.filter {c in
            let c1 = c[0]
            let c2 = c[1]
            let c3 = c[2]
            let containsT =  c1.starts(with: "t") || c2.starts(with: "t") || c3.starts(with: "t")
            return containsT && connections[c2]?.contains(c3) == true
        }.map {c in c.sorted()}
        
        return Set(cycles).count
    }
}
