import Foundation

private let inputFile = "2024/day19.txt"


fileprivate class TowelTrie {
    
    var isTowel: Bool = false
    var isRoot: Bool = false
    var stripes = [Character: TowelTrie]()
}

private func parseInput() -> (TowelTrie, [[Character]]) {
    
    var isFirst = true
    var design = [[Character]]()
    var trie: TowelTrie!
    
    _ = FileReader.init(name: inputFile) { line in
        if (isFirst) {
            isFirst = false
            trie = buildTowelTrie(input: line)
            
            
        }
        else if (!line.isEmpty) {
            design.append(Array(line))
        }
    }
    
    return (trie, design)
}

fileprivate func buildTowelTrie(input: String) -> TowelTrie {
    let trie = TowelTrie()
    trie.isRoot = true
    let filterInput = input.components(separatedBy: [",", " "]).filter { t in
        !t.isEmpty
    }
    
    for towel in filterInput {
        var next: TowelTrie? = trie
        towel.forEach { s in
            let temp = next?.stripes[s] ?? TowelTrie()
            next?.stripes[s] = temp
            next = temp
        }
        next?.isTowel = true
    }
    
    return trie
}

class Aoc2024Day19 {
    
    
    private var cache = [String: Int]()
    
    
    func part1() -> Int {
        
        let input = parseInput()
        let towelTrie = input.0
        let designs = input.1
        
        var count = 0
        for design in designs {
            if (canMakeDesign(design: design,
                              index: 0,
                              current: towelTrie,
                              root: towelTrie) > 0) {
                count += 1
            }
            
        }
        
        return count
    }
    
    func part2() -> Int {
        
        let input = parseInput()
        let towelTrie = input.0
        let designs = input.1
        
        var count = 0
        for design in designs {
            count += canMakeDesign(design: design,
                                   index: 0,
                                   current: towelTrie,
                                   root: towelTrie)
        }
        
        return count
    }
    
    private func canMakeDesign(design: [Character], index: Int, current: TowelTrie, root: TowelTrie) -> Int {
        if (index >= design.count) {
            return current.isTowel ? 1 : 0
        }
        let stripe = design[index]
        guard let next = current.stripes[stripe] else {
            return 0
        }
        
        let start = design.index(design.startIndex, offsetBy: index)
        let key = String(design[start..<design.endIndex])
        let cacheValue = cache[key]
        if (current.isRoot && cacheValue != nil) {
            return cacheValue!
        }
        
        
        var startFromRootResult = 0
        if (next.isTowel) {
            startFromRootResult = canMakeDesign(design: design,
                                                index: index + 1,
                                                current: root,
                                                root: root)
        }
        
        let gotoNextResult = canMakeDesign(
            design: design,
            index: index + 1,
            current: next,
            root: root)
        
        
        let total = startFromRootResult + gotoNextResult
        
        if (current.isRoot) {
            cache[key] = total
        }
        
        return total
        
    }
}
