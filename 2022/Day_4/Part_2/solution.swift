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
                    let range = $0.split(separator: "-").compactMap { Int($0) }
                    return Set(range[0]...range[1])
                }
            if !parts[0].intersection(parts[1]).isEmpty || !parts[1].intersection(parts[0]).isEmpty {
                result += 1
            }
        }
        return result
    }
 }

let puzzle = Puzzle()
print(puzzle.solve())

