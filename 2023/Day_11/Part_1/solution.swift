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
        let map: [[Character]] = input.map { $0.map { $0 } }
        
        let rows = map.count
        let cols = map[0].count
        var points: [[Int]] = []
        var rowAcc = 0
        for row in 0..<rows {
            var count = 0
            for col in 0..<cols {
                if map[row][col] == "#" {
                    count += 1
                    points.append([row + rowAcc, col])
                }
            }

            if count == 0 {
                rowAcc += 1
            }
        }

        var colAcc = 0
        for col in 0..<cols {
            var count = 0
            for row in 0..<rows {
                if map[row][col] == "#" {
                    count += 1
                }
            }

            if count == 0 { 
                colAcc += 1
                for i in 0..<points.count {
                    if points[i][1] >= col + colAcc {
                        points[i][1] += 1
                    }
                }
            }
        }

        var result = 0
        for i in 0..<points.count - 1 {
            let p1 = points[i]
            for j in i + 1..<points.count {
                if i == j { continue }
                let p2 = points[j]
                let path = abs(p2[0] - p1[0]) + abs(p2[1] - p1[1])
                result += path
            }
        }
    
        return result
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())