
import Foundation

class Aoc2024Day5 {
    
    private let inputFile = "2024/day5.txt"
    
    func part1() -> Int {
        
        var dependentPages = Dictionary<String, Array<String>>()
        
        var parseQueue = false
        var sum = 0
        
       _ = FileReader(name: inputFile
       )  {line in
           if (parseQueue) {
               let pages = line.components(separatedBy: ",")
               if (isValidPrintOrder(dependensOnPages: dependentPages, pages: pages)) {
                   
                   let middle = pages.count / 2
                   sum += Int(pages[middle]) ?? 0
               }
               
           }
           else if (!line.isEmpty) {
              
               let comp = line.components(separatedBy: "|")
               dependentPages.addDependsOnPage(
                page: comp.last ?? "",
                depensOn: comp.first ?? "")
           }
           else {
               parseQueue = true
           }
        }
        return sum
    }
    
    func part2() ->  Int {
        
        var dependentPages = Dictionary<String, Array<String>>()
        
        var parseQueue = false
        
        var incorrectOrderPages = Array<Array<String>>()
        
        var sum = 0
        
       _ = FileReader(name: inputFile
       )  {line in
           if (parseQueue) {
               let pages = line.components(separatedBy: ",")
               if (!isValidPrintOrder(dependensOnPages: dependentPages, pages: pages)) {
                   
                   incorrectOrderPages.append(pages)
               }
               
           }
           else if (!line.isEmpty) {
              
               let comp = line.components(separatedBy: "|")
               dependentPages.addDependsOnPage(
                page: comp.last ?? "",
                depensOn: comp.first ?? "")
           }
           else {
               parseQueue = true
           }
        }
        
        incorrectOrderPages.forEach {page  in
            let order = page.sorted { dependentPages[$1]?.contains($0) == true
                
            }
            let middle = order.count / 2
            sum += Int(order[middle]) ?? 0
        }
        
        return sum
    }
}


extension Dictionary<String, Array<String>> {
    
    mutating func addDependsOnPage(page: String, depensOn: String) {
        
        var d = self[page] ?? Array<String>()
        if (!d.contains(depensOn)) {
            d.append(depensOn)
        }
        self[page] = d
        
    }
}

extension Aoc2024Day5 {
    
    func isValidPrintOrder(
     dependensOnPages: Dictionary<String,Array<String>>,
     pages: Array<String>) -> Bool {
         
         var shouldAlreadyBePrinted = Set<String>()
         var printed = Set<String>()
         var i = 0
         var valid = true
         
         while (valid && i < pages.count) {
                
             let page = pages[i]
             
             valid = !shouldAlreadyBePrinted.contains(page)
             
             dependensOnPages[page]?.forEach { d in
                 if (!printed.contains(d)) {
                     shouldAlreadyBePrinted.insert(d)
                 }
             }
             
             printed.insert(page)
             i += 1
                
         }
        return valid
    }
    
}
