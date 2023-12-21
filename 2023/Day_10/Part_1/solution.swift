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
        let rows = input.count
        let cols = input[0].count
        let map: [[Character]] = input.map { $0.map { $0 } }
        var si = 0
        var sj = 0
        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "S" {
                    si = i
                    sj = j
                    break
                }
            }
        }
        // print(map, si, sj)

        let directionsMap: [Character: [[Int]]] = [
            "|": [[1,  0], [-1, 0]],
            "-": [[0, -1], [0,  1]],
            "F": [[0,  1], [1,  0]],
            "L": [[0,  1], [-1, 0]],
            "7": [[0, -1], [1,  0]],
            "J": [[0, -1], [-1, 0]],
        ]

        var visited = Set<[Int]>()
        visited.insert([si, sj])
        var i = si
        var j = sj + 1 
        var prev = [si, sj]

        while true {
            visited.insert([i, j])
            let char = map[i][j]

            if char == "S" { break }

            let directions = directionsMap[char]!
            let next = [i + directions[0][0], j + directions[0][1]]
            
            if prev == next {
                prev = [i, j]
                i = i + directions[1][0]
                j = j + directions[1][1]
            } else {
                prev = [i, j]
                i = i + directions[0][0]
                j = j + directions[0][1]
            }

            if i < 0 || i > rows - 1 || j < 0 || j > cols - 1 {
                break
            }
        }
        return visited.count / 2
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())