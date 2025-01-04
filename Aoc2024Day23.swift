import Foundation


class Aoc2024Day23 {
    
    private let inputFile = "2024/day23.txt"
    
    private var max: Set<String>? = nil
    
    func part1() -> Int  {
        
        let connections = buildAdjacencyList()
        print(connections.count)
        let sets = connections.keys
            .filter{ $0.starts(with: "t") }
            .map {
                let s: Set<String> = [$0]
                return s
            }
        let clique2 = findClique(connections: connections, existing: Set(sets))
        let clique3 = findClique(connections: connections, existing: clique2)
        return clique3.count
    }
    
    func part2() -> String  {
        
        let connections = buildAdjacencyList2()
        let r = Set<String>()
        let p = Set(connections.keys)
        let x = Set<String>()
        bk(r: r, p: p, x: x, connections: connections)
        
        guard let max = max else {
            return ""
        }
        return max.sorted().joined(separator: ",")

    }
    
    
    private func bk(r: Set<String>, p: Set<String>, x: Set<String>,
                    connections: [String: Set<String>]) {
        if (p.isEmpty) {
            if (r.count > (max?.count ?? 0)) {
                max = r
            }
        }
        else {
            var x1 = x
            p.forEach {v in
                let r1 = r.union(Set([v]))
                let p1 = p.intersection(connections[v] ?? Set()).subtracting(x1)
                bk(r: r1, p: p1, x: x1, connections: connections)
                x1.insert(v)
                
            }
        }
    }
    
    private func findClique(connections: [String: Set<String>],
                            existing: Set<Set<String>>) -> Set<Set<String>>  {
        var clique = Set<Set<String>>()
        var seen = Set<Set<String>>()
        
        for k in connections.keys {
            let adjList = connections[k] ?? []
            for e in existing {
                if (!e.contains(k) && e.count + 1 <= adjList.count) {
                    let c = e.union(Set([k]))
                    if (!seen.contains(c)) {
                        seen.insert(c)
                        let intersection = c.intersection(adjList)
                        if (intersection == c) {
                            clique.insert(c)
                        }
                    }
                }
            }
        }
        
        return clique
    }
    
    private func isAllConnected(clique:[String], connections: Set<String>) -> Bool {
        
        var isConnected = true
        var i = 0
        while (isConnected && i < clique.count) {
            isConnected = connections.contains(clique[i])
            i += 1
        }
        
        return isConnected
    }
    
    private func buildAdjacencyList() -> [String: Set<String>] {
        
        var connections = [String: Set<String>]()
        
        _ = FileReader.init(name: inputFile) { line in
            let pair = line.components(separatedBy: "-")
            let c1 = pair[0]
            let c2 = pair[1]
            
            var c1Connections: Set<String> = connections[c1] ?? [c1]
            c1Connections.insert(c2)
            connections[c1] = c1Connections
            
            var c2Connections: Set<String> = connections[c2] ?? [c2]
            c2Connections.insert(c1)
            connections[c2] = c2Connections
        }
        return connections
    }
    
    private func buildAdjacencyList2() -> [String: Set<String>] {
        
        var connections = [String: Set<String>]()
        
        _ = FileReader.init(name: inputFile) { line in
            let pair = line.components(separatedBy: "-")
            let c1 = pair[0]
            let c2 = pair[1]
            
            var c1Connections: Set<String> = connections[c1] ?? []
            c1Connections.insert(c2)
            connections[c1] = c1Connections
            
            var c2Connections: Set<String> = connections[c2] ?? []
            c2Connections.insert(c1)
            connections[c2] = c2Connections
        }
        return connections
    }

}
