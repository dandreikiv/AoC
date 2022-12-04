import Foundation

class Puzzle {

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
        print(input)
    }

    func solve() -> Int {
        var result = 0
        for line in input {
            let parts = line
                .split(separator: ",")
                .map { 
                    $0.split(separator: "-")
                    .compactMap { Int($0) } 
                }
            if (parts[0][0] <= parts[1][0] && parts[0][1] >= parts[1][1]) || (parts[1][0] <= parts[0][0] && parts[1][1] >= parts[0][1]) {
                result += 1
            }
        }
        return result
    }
 }

let puzzle = Puzzle()
print(puzzle.solve())

