import Foundation

class Solver {

    private var input: [String] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            input = try String(contentsOf: url).components(separatedBy: "\n")
        } catch {
            print(error)
        }
    }

    func printInput() {
        for line in input {
            print(line)
        }
    }

    func solve() -> Int {
        var matrix: [[Character]] = []

        for line in input {
            matrix.append(line.map { $0 })
        }

        let rows = matrix.count
        let cols = matrix[0].count
        
        var dict: [Set<String>: Int] = [:]
        
        for i in 0..<rows {
            var acc = 0
            var numSet = Set<String>()
            for j in 0..<cols {
                let char = matrix[i][j]
                if char.isNumber {
                    let digit = Int(char.asciiValue! - 48)
                    acc = acc * 10 + digit
                    numSet.insert("r\(i)c\(j)")
                } else {
                    if acc > 0 {
                        dict[numSet] = acc
                    }
                    acc = 0
                    numSet = Set<String>()
                }
            }
            if acc > 0 {
                dict[numSet] = acc
                acc = 0
                numSet = Set<String>()
            }
        }

        var resultSet = Set<Set<String>>()
        var result = 0
        for i in 0..<rows {
            var numsSet = Set<String>()
            for j in 0..<cols {
                let char = matrix[i][j]
                if !char.isNumber && char != "." {
                    numsSet.insert("r\(i - 1)c\(j - 1)")
                    numsSet.insert("r\(i - 1)c\(j)")
                    numsSet.insert("r\(i - 1)c\(j + 1)")
                    numsSet.insert("r\(i)c\(j - 1)")
                    numsSet.insert("r\(i)c\(j + 1)")
                    numsSet.insert("r\(i + 1)c\(j - 1)")
                    numsSet.insert("r\(i + 1)c\(j)")
                    numsSet.insert("r\(i + 1)c\(j + 1)")

                    for key in dict.keys {
                        if numsSet.intersection(key).count > 0 {
                            resultSet.insert(key)
                        }
                    }

                    numsSet = Set<String>()
                }
            }
        }

        result += resultSet.map { dict[$0]! }.reduce(0, +)
        
        return result
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())


