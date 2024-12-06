import Foundation

class Node {
    var entries: Dictionary<Character, Node> = [:]
    var value: Character? = nil
    
}


func buildTrie2() -> Node {
    let data: Dictionary<String, Character> = [
       "0" : "0",
       "1" : "1",
       "2" : "2",
       "3" : "3",
       "4" : "4",
       "5" : "5",
       "6" : "6",
       "7" : "7",
       "8" : "8",
       "9" : "9",
       "one": "1",
       "two": "2",
       "three": "3",
       "four": "4",
       "five": "5",
       "six": "6",
       "seven": "7",
       "eight" : "8",
       "nine": "9",
       "one".revStr(): "1",
       "two".revStr(): "2",
       "three".revStr(): "3",
       "four".revStr(): "4",
       "five".revStr(): "5",
       "six".revStr(): "6",
       "seven".revStr(): "7",
       "eight".revStr() : "8",
       "nine".revStr(): "9"
   ]
    return buildTrie(data: data)
}



func buildTrie1() -> Node {
    let data: Dictionary<String, Character> = [
       "0" : "0",
       "1" : "1",
       "2" : "2",
       "3" : "3",
       "4" : "4",
       "5" : "5",
       "6" : "6",
       "7" : "7",
       "8" : "8",
       "9" : "9",
    ]
    return buildTrie(data: data)
}

private func buildTrie(data: Dictionary<String, Character>) -> Node {
    
    let root = Node()
    
    for (k,v) in data {
        var child = root
        for c in k {
            if let node: Node = child.entries[c] {
                child = node
            }
            else {
                let node = Node()
                child.entries[c] = node
                child = node
            }
        }
        child.value = v
    }
   
    
    return root
}

extension String {
    func revStr() -> String {
        return String(reversed())
    }
}

class Aoc2023Day1 {

    func problem1() -> Int {
        return calculate(root: buildTrie1())
    }
    
    func problem2() -> Int {
        return calculate(root: buildTrie2())
    }
    
    private func calculate(root: Node) -> Int {
       
        var sum = 0
        _ =  FileReader(name:"2023/day1.txt") { line in
            let charArray = Array(line)
            let first = findFirst(line: charArray,
                                  root: root,
                                  start: 0)
            let last = findLast(line: charArray,
                                root: root,
                                start: charArray.count - 1)
            if let first = first, let last = last {
                if let num = Int(
                    "\(String(first))\(String(last))"
                ) {
                    sum += num
                }
            }
        }
        return sum
    }
    
     func findFirst(line: Array<Character>,
                    root: Node,
                    start: Int) -> Character? {
         
         var child: Node? = root
         var value: Character? = nil
         var index = findFirstStart(line: line,
                                   root: root,
                                   start: start)
         var restart: Int? = nil
         
         while (index < line.count && value == nil && child != nil) {
           
             let c = line[index]
             if let next = child?.entries[c] {
                 index += 1
                 child = next
                 if (index < line.count && restart == nil && root.entries[line[index]] != nil) {
                     restart = index
                 }
                 if let v = child?.value {
                     value = v
                 }
             }
             else {
                 if restart == nil {
                     restart = index
                 }
                 child = nil
             }
         }
         return value
         ?? findFirst(line: line,
                      root: root,
                      start: restart ?? line.count)
     }
       
    
    
    private func findLastStart(
        line: Array<Character>,
        root: Node,
        start: Int
    ) -> Int {
        
        
        if (start < 0 || start >= line.count) {
            return -1
        }
        
        var index = start
        var char = line[index]
        while (index > -1 && root.entries[char] == nil) {
            index -= 1
            char = line[index]
        }
        
        return index
    }
    
    
     func findFirstStart(
        line: Array<Character>,
        root: Node,
        start: Int
    ) -> Int {
        
        
        if (start < 0 || start >= line.count) {
            return line.count
        }
        
        var index = start
        var char = line[index]
        while (index > -1 && root.entries[char] == nil) {
            index += 1
            char = line[index]
        }
        
        return index
    }
    
    
    func findLast(line: Array<Character>,
                  root: Node,
                  start: Int) -> Character? {
        
        var child: Node? = root
        var value: Character? = nil
        var index = findLastStart(line: line,
                                  root: root,
                                  start: start)
        var restart: Int? = nil
        
        
        
        while (index > -1 && value == nil && child != nil) {
          
            let c = line[index]
            if let next = child?.entries[c] {
                index -= 1
                child = next
                if (index > -1 && restart == nil && root.entries[line[index]] != nil) {
                    restart = index
                }
                if let v = child?.value {
                    value = v
                }
            }
            else {
                if restart == nil {
                    restart = index
                }
                child = nil
            }
        }
        return value
    ?? findLast(line: line,
                root: root,
                start: restart ?? -1)
    }
}
