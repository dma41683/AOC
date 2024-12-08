
import Foundation

struct Aoc2015Day25 {
    
    private let startValue = 20151125
    private let mulValue = 252533
    private let divValue = 33554393
    
    func calcRowStartValue(row: Int) -> Int {
       return  (row * (row - 1)) / 2 + 1
    }
    
    func calcColValue(row: Int, col: Int, rowStart:Int) -> Int {
        let startDiff = row + 1
        let offset = row * (row + 1) / 2
        let colDiff = col - 2 + startDiff
        let icrease = colDiff * (colDiff  + 1) / 2
        
        return rowStart + icrease - offset
    }
    
    func part1(row: Int, col: Int) -> Int {
        
        let rowStartValue = calcRowStartValue(row: row)
        let term = calcColValue(row: row, col: col, rowStart: rowStartValue)
        
        var current = startValue
        var index = 1
        while(index < term) {
            current =  (current * mulValue) % divValue
            index += 1
        }
        
        
        
        return current
    }
    
}
