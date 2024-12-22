import Foundation

struct Aoc2024Day22 {
    
    private let inputFile = "2024/day22.txt"

    
    func part1() -> Int {
        
        var sum = 0
        _ = FileReader(name: inputFile) {line in
            if (!line.isEmpty) {
                sum += nthSecret(current: Int(line) ?? 0, term: 2000)
            }
        }
       
        return sum
    }
    
    func nthSecret(current: Int, term: Int) -> Int  {
        var secret = current
        for _ in 0..<term {
            secret = nextSecret(current: secret)
        }
        
        return secret
    }
    
    func nextSecret(current: Int) -> Int {
        
        let prune = 16777216
        var secret = ((current * 64) ^ current) % prune
        secret = ((secret / 32) ^ secret) % prune
        secret  = ((secret * 2048) ^ secret) % prune
       
        /*
         This solution is slower in Swift
         
        let prune = 0xFFFFFF
        var secret = ((current << 6) ^ current) & prune
        secret = ((secret >> 5) ^ secret) & prune
        secret  = ((secret << 11) ^ secret) & prune
         */
         
        
        return secret
    }
}
