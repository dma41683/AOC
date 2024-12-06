


import Foundation
// https://adventofcode.com/2024/day/1


class Aoc2024Day1 {
    
    func part1() {
        var list1 = Array<Int>()
        var list2 = Array<Int>()
        
        _ =  FileReader(name:"2024/day1.txt") { line in
            let numbs = line.components(separatedBy: [" "])
            let first = numbs.first
            let last = numbs.last
            
            if let first = first,
               let last = last,
               let num1 = Int(first),
               let num2 = Int(last) {
                
                list1.append(num1)
                list2.append(num2)
            }
        }
        calculateDistance1(list1: list1.sorted(),
                           list2: list2.sorted())
    }
    
    func part2() {
        var list1 = Array<Int>()
        var dict2 = Dictionary<Int, Int>()
        
        _ =  FileReader(name:"day1.txt") { line in
            let numbs = line.components(separatedBy: [" "])
            let first = numbs.first
            let last = numbs.last
            
            if let first = first, let last = last, let num1 = Int(first),  let num2 = Int(last) {
                
                list1.append(num1)
                if let count = dict2[num2] {
                    dict2[num2] = count + 1
                }
                else {
                    dict2[num2] = 1
                }
            }
        }
        calculateDistance2(list1: list1, dict2: dict2)
    }
    
    private func calculateDistance1(list1: Array<Int>, list2: Array<Int>) {
        var sum = 0
        list1.indices.forEach {i in
            let num1 = list1[i]
            let num2 = list2[i]
            sum += abs(num1 - num2)
        }
        print("Day 1 - problem 1: \(sum)")
    }
    
    private func calculateDistance2(list1: Array<Int>, dict2: Dictionary<Int,Int>) {
        
        var sum = 0
        list1.forEach {num in
            if let count = dict2[num] {
                sum += num * count
            }
        }
        print("Day 1 - problem 2: \(sum)")
    }
}

