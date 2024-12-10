
import Foundation

struct Aoc2024Day9 {
    
    private let inputFile = "2024/day9.txt"
    
    func part1() -> Int {
        
        let output = parseInput()
        var files = output.0
        let freeBlocks = output.1
        
        var disk = Array<Int>()
        var freeSpace = 0
        var first = 0
        var last = files.count - 1
        
        while (last >= first) {
            
            if (freeSpace == 0) {
                let size = files[first]
                disk.append(contentsOf: [Int](repeating:first, count: size))
                if (first < freeBlocks.count) {
                    freeSpace = freeBlocks[first]
                }
                first += 1
            }
            else if (freeSpace >= files[last]) {
                let size = files[last]
                disk.append(contentsOf: [Int](repeating: last, count: size))
                freeSpace = freeSpace - size
                last = last  - 1
            }
            else {
                let size = files[last]
                disk.append(contentsOf: [Int](repeating: last, count: freeSpace))
                files[last] = size - freeSpace
                freeSpace = 0
            }
        }
        var sum = 0
        for (index, fid) in disk.enumerated() {
            sum += index * fid
        }
        return sum
    }
    
    func part2() -> Int {
        
        let input = parseInput()
        let disk = parseInputPart2(input: input)
        
        let fileSize = disk.fileSize
        var freeSpace = disk.freeSpace
        var prev = disk.prev
        var next = disk.next
        var fdNext = input.0.count - 1
        
        while (fdNext > 0) {
        
        let fdNextFileSize = fileSize[fdNext] ?? 0
        let afterfd = DiskInfo(fileSize: fileSize,
                          freeSpace: freeSpace,
                          prev: prev,
                          next: next).findFreeSpace(size: fdNextFileSize,
                                                    start: 0,
                                                    fd: fdNext)
            if let afterfd = afterfd {
                
                //the file that comes before fdNext
                let fdPrev = prev[fdNext] ?? -1
                
                //existing free space after fdPrev
                let fdPrevFree = freeSpace[fdPrev] ?? 0
                
                //free space after fdNext
                let fdNextFree = freeSpace[fdNext] ?? 0
               
                //new amount of free space after fdNext is moved
                let totalSpace = fdPrevFree + fdNextFree + fdNextFileSize
                
                //set new totalSpace amount after fdPrev
                freeSpace[fdPrev] = totalSpace
                
                //move fdNext
                next[fdPrev] = next[fdNext]
                prev[fdNext] = afterfd
                
                //free space afer afterfd to be moved to fdNext
                let afterFdFree = freeSpace[afterfd] ?? 0
                freeSpace[afterfd] = 0
                freeSpace[fdNext] = afterFdFree - fdNextFileSize
                
                //file that comes after afterfd
                let afterFdNext = next[afterfd] ?? -1
                
                //set afterFdNext to come after fdNext
                next[fdNext] = afterFdNext
                prev[afterFdNext] = fdNext
                
                //set fdNext to come after afterfd
                next[afterfd] = fdNext
                
              
               
                
            }
            fdNext = fdNext - 1
        }
        return  DiskInfo(fileSize: fileSize,
                         freeSpace: freeSpace,
                         prev: prev,
                         next: next).checksum()
    }
}


fileprivate struct DiskInfo {

    let fileSize:[Int:Int]
    let freeSpace: [Int: Int]
    let prev: [Int: Int]
    let next: [Int: Int]
    
    func findFreeSpace(size: Int, start: Int, fd: Int) -> Int? {
        if start == fd {
            return nil
        }
        else if (freeSpace[start] ?? 0 >= size) {
            return start
        }
        else {
            return findFreeSpace(size: size,
                                 start: next[start] ?? -1,
                                 fd: fd)
        }
        
        
        
    }
    
    func printDisk() {
        
        var output = Array<Character>()
        var start: Int? = 0
       
        while (start != nil) {
            if let start = start {
                let size = fileSize[start] ?? 0
                let space = freeSpace[start] ?? 0
                output.append(contentsOf: [Character](repeating: intToCharMap[start] ?? ".", count: size))
                output.append(contentsOf: [Character](repeating: ".", count: space))
            }
            start = next[start ?? -1]
        }
        print(String(output))
    }
    
    func checksum() -> Int {
        
        var output = Array<Int>()
        var start: Int? = 0
        
        while (start != nil) {
            if let start = start {
                let size = fileSize[start] ?? 0
                let space = freeSpace[start] ?? 0
                output.append(contentsOf: [Int](repeating: start, count: size))
                output.append(contentsOf: [Int](repeating: 0, count: space))
            }
            start = next[start ?? -1]
        }
        
        var sum = 0
        
        for (index,value) in output.enumerated() {
            sum += index * value
        }
        
        return sum
    }
}



extension Aoc2024Day9 {
    
    fileprivate func parseInputPart2(input: (Array<Int>, Array<Int>)) -> DiskInfo {
        
        var fileSize = Dictionary<Int, Int>()
        var freeSpace = Dictionary<Int, Int>()
        var prev = Dictionary<Int,Int>()
        var next = Dictionary<Int,Int>()
        
        let files = input.0
        let space = input.1
        
        for (fd, size) in files.enumerated() {
            
            fileSize[fd] = size
            freeSpace[fd] = space[fd]
            
            let n = fd + 1
            let p = fd - 1
            if (p >= 0) {
                prev[fd] = p
            }
            
            if (n < files.count) {
                next[fd] = n
            }
        }
        return DiskInfo(fileSize: fileSize,
                        freeSpace: freeSpace,
                        prev: prev,
                        next: next)
    }
    
    func parseInput() -> (Array<Int>, Array<Int>) {
        
        var files = Array<Int>()
        var freeBlocks = Array<Int>()
        var i = 0
        _ = FileReader.init(name: inputFile) {line in
            Array(line).forEach {c in
                let size = charToIntMap[c] ?? 0
                if (i.isEven()) {
                    files.append(size)
                } else {
                    freeBlocks.append(size)
                }
                i += 1
            }
        }
        freeBlocks.append(0)
        return (files, freeBlocks)
    }
}





