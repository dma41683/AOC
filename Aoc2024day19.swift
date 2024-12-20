import Foundation

private let inputFile = "2024/day19.txt"


fileprivate class TowelTrie {
    
    var isTowel: Bool = false
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

struct Aoc2024Day19 {
    
    
    func part1() -> Int {
        let input = parseInput()
        let towelTrie = input.0
        let designs = input.1
        
        var count = 0
        for design in designs {
            if (canMakeDesign(design: design,
                              index: 0,
                              current: towelTrie,
                              root: towelTrie)) {
                count += 1
            }
        
        }
        
        return count
    }
    
    private func canMakeDesign(design: [Character], index: Int, current: TowelTrie, root: TowelTrie) -> Bool {
        if (index >= design.count) {
            return current.isTowel
        }
        let stripe = design[index]
        guard let next = current.stripes[stripe] else {
            return false
        }
      
        var startFromRootResult = false
        if (next.isTowel) {
            startFromRootResult = canMakeDesign(design: design,
                                 index: index + 1,
                                 current: root,
                                root: root)
        }
       
        return startFromRootResult || canMakeDesign(
            design: design,
                             index: index + 1,
                             current: next,
                             root: root)
        
        
    }
}
