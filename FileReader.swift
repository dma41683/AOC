import Foundation

let test = "/test.txt"


class FileReader {
    
    let filename: String
    
    let path = "/Users/dma/development/AdventOfCode/input/"
    
    
    init(name: String, cb: (String) -> Void) {
        self.filename = "\(path)/\(name)"
        readFileByLine(cb: cb)
    }
    
  private func readFileByLine(cb: (String) -> Void) {
        
        guard let file = freopen(filename, "r", stdin) else {
            return
        }
        defer {
            fclose(file)
        }

        while let line = readLine() {
            cb(line)
        }

    }
}
