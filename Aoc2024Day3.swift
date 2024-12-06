

import Foundation

    
enum Token {
    case M //m
    case U //u
    case L //l
    case OP // (
    case N1 //first digit first part
    case NC //optional digits first part or ,
    case N2 //first digit second part
    case NCP // optional digit second part or )
    case DONE
    
}

private class State {
    
    private var num1 = Array<Character>()
    private var num2 = Array<Character>()
    
    func mul() -> Int {
        let n1 = Int(String(num1) ) ?? 0
        let n2 = Int(String(num2) ) ?? 0
        
        return n1 * n2
    }
}

class Aoc2024Day3 {
    
    
    private let inputFile = "2024/day3.txt"
    private let numbers = Set(Array("0123456789"))
    
    
    func part1() -> Int {
        
            var input = Array<Character>()
        _ = FileReader(name: inputFile) {line in
            input.append(contentsOf: Array(line))
        }
        return parseProblem1(input: input)
    }
    
    func part2() -> Int {
        
        var input = Array<Character>()
    _ = FileReader(name: inputFile) {line in
        input.append(contentsOf: Array(line))
    }
    return parseProblem2(input: input)
        
    }
    
    func parseProblem1(input: Array<Character>) -> Int {
        
        var index = 0
        var sum = 0
        while(index < input.count) {
            if hasMulFunction(at: index, from: input) {
                index += 4
                let result = calc(start: index, input: input)
                index = result.0
                sum += result.1
                
            } else {
                index += 1
            }
        }
        
        return sum
        
    }
    
    func parseProblem2(input: Array<Character>) -> Int {
        
        var index = 0
        var sum = 0
        var enabled = true
       
        while(index < input.count) {
            if hasDoFunction(at: index, from: input) {
                enabled = true
                index += 4
            }
            else if hasDontFunction(at: index, from: input) {
                enabled = false
                index += 7
            }
           else if enabled && hasMulFunction(at: index, from: input) {
                index += 4
                let result = calc(start: index, input: input)
                index = result.0
                sum += result.1
                
            } else {
                index += 1
            }
        }
        
        return sum
        
    }
    
    func hasDoFunction(at index: Int, from input: Array<Character>) -> Bool {
        
        guard (index + 3 < input.count) else {
            return false
        }
        
        return      input[index]     == "d" &&
                    input[index + 1] == "o" &&
                    input[index + 2] == "(" &&
                    input[index + 3] == ")"

    }
    
    func hasDontFunction(at index: Int, from input: Array<Character>) -> Bool {
        
        guard (index + 6 < input.count) else {
            return false
        }
        
        return      input[index]     == "d" &&
                    input[index + 1] == "o" &&
                    input[index + 2] == "n" &&
                    input[index + 3] == "'" &&
                    input[index + 4] == "t" &&
                    input[index + 5] == "(" &&
                    input[index + 6] == ")"




    }
    
    
    
     func hasMulFunction(at index:Int, from input: Array<Character>) -> Bool {
        
        guard (index + 3 < input.count) else {
            return false
        }
        
        return  input[index]     == "m" &&
                input[index + 1] == "u" &&
                input[index + 2] == "l" &&
                input[index + 3] == "("
        
    }
    
     func calc(start: Int, input: Array<Character>) -> (Int, Int) {
        
        var valid = true
        var index = start
        var state = Token.N1
        
        var num1 = Array<Character>()
        var num2 = Array<Character>()
        
        while(valid &&  index < input.count && state != .DONE) {
            
            let char = input[index]
            
            if(state == .N1 && numbers.contains(char)) {
                state = .NC
                num1.append(char)
            }
            else if (state == .NC && numbers.contains(char)) {
                num1.append(char)
            }
            else if (state == .NC && char == ",") {
                state = .N2
            }
            else if (state == .N2 && numbers.contains(char)) {
                state = .NCP
                num2.append(char)
            }
            else if (state == .NCP && numbers.contains(char)) {
                num2.append(char)
            }
            else if (state == .NCP && char == ")") {
                state = .DONE
            }
            else {
                valid = false
            }
            index += 1
                        
        }
       
        if (!valid || state != .DONE) {
            return (start, 0)
        }
        else {
            let n = Int(String(num1)) ?? 0
            let n2 = Int(String(num2)) ?? 0
            
            return (index, n * n2)
        }
    }

}
