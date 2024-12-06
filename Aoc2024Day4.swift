
import Foundation

 /*
    A B C
    D * E
    F G H
  */


class Aoc2024Day4 {
    
    
    private let inputFile = "2024/day4.txt"
    private let xmas = Array("XMAS")
    
    
    func part1() -> Int {
        var input = Array<Array<Character>>()
        _ = FileReader(name: inputFile) { line in
            input.append(Array(line))
        }
        
        
        var count = 0
        let rows = input.count
        var r = 0
        while (r < rows) {
            let columns = input[r].count
            var c = 0
            while (c < columns) {
                count += findAll(r: r, c: c, input: input)
                c += 1
                
            }
            r += 1
        }
        
        return count
    }
    
    func findAll(r: Int, c: Int, input:Array<Array<Character>>) -> Int {
        
        var count = 0
        let diffs = Array<Int>(arrayLiteral: -1, 0, 1)
        diffs.forEach {dr in
            diffs.forEach {dc in
                count += find(r: r,
                              c: c,
                              diffR: dr,
                              diffC: dc,
                              input: input)
            }
        }
        
        return count
        
    }
    
    
    func find(r: Int, c: Int, diffR: Int, diffC: Int, input:Array<Array<Character>>) -> Int {
        
        var start = 0
        var sr = r
        var sc = c
        
        
        while(start > -1 && start < xmas.count &&
              sr > -1 && sc > -1 &&
              sr < input.count && sc < input[sr].count) {
            
            if (input[sr][sc] == xmas[start]) {
                start += 1
                sr += diffR
                sc += diffC
            }
            else {
                start = -1
            }
        }
        
        if start == xmas.count {
            return 1
            
        }
        else {
            return 0
        }
        
    }
    
    func part2() -> Int {
        var input = Array<Array<Character>>()
        _ = FileReader(name: inputFile) { line in
            input.append(Array(line))
        }
        
        
        var count = 0
        let rows = input.count
        var r = 0
        while (r < rows) {
            let columns = input[r].count
            var c = 0
            while (c < columns) {
                if (input[r][c] == "A") {
                    count += findX(r: r, c: c, input: input)
                }
                c += 1
                
            }
            r += 1
        }
        
        return count
    }
    
    /*
        A  B
         A
        E  D
     */
    
    func findX(r: Int, c: Int, input:  Array<Array<Character>>) -> Int {
        
        var didFind = false
        let a = (r - 1, c - 1)
        let b = (r - 1, c + 1)
        let e = (r + 1 ,c - 1)
        let d = (r + 1 , c + 1)
        
        if (//a
            a.0 > -1 && a.0 < input.count &&
            a.1 > -1 && a.1 < input[a.0].count &&
            //b
            b.0 > -1 && b.0 < input.count &&
            b.1 > -1 && b.1 < input[b.0].count &&
            //e
            e.0 > -1 && e.0 < input.count &&
            e.1 > -1 && e.1 < input[e.0].count &&
            //d
            d.0 > -1 && d.0 < input.count &&
            d.1 > -1 && d.1 < input[d.0].count
        ) {
            let A = input[a.0][a.1]
            let B = input[b.0][b.1]
            let E = input[e.0][e.1]
            let D = input[d.0][d.1]
            
            didFind = ((A == "M" && D == "S") || (A == "S" && D == "M")) && (
                (B == "M" && E == "S") || (B == "S" && E == "M")
            )
            
        }
        
        
        
        
         if (didFind) {
            return 1
        }
        else {
            return 0
        }
    }

}
