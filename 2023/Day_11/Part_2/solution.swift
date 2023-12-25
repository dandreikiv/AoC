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

        for row in 0..<rows {
            for col in 0..<cols {
                if map[row][col] == "#" {
                    points.append([row, col])
                }
            }
        }

        let expansionSpeed = 1000000
        points.sort { point1, point2 in
            point1[1] < point2[1]
        }

        for i in 0..<points.count - 1 {
            let diff = points[i + 1][1] - points[i][1] - 1
            if diff > 0 {
                for j in i + 1..<points.count {
                    points[j][1] += diff * (expansionSpeed - 1)
                }
            }
        }

        points.sort { point1, point2 in
            point1[0] < point2[0]
        }

        for i in 0..<points.count - 1 {
            let diff = points[i + 1][0] - points[i][0] - 1 
            if diff > 0 {
                for j in i + 1..<points.count {
                    points[j][0] += diff * (expansionSpeed - 1)
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