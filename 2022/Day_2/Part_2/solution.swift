import Foundation

class Solution {

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
        let plays = input
            .map { $0.split(separator: " ").map(String.init) }
            .map { matchPlay(left: $0[0], right: $0[1]) }
            .reduce(0, +)

        return plays
    }


    func matchPlay(left: String, right: String) -> Int {
        switch (left, right) {
            // Rock
            case ("A", "X"): return 0 + 3
            case ("A", "Y"): return 3 + 1
            case ("A", "Z"): return 6 + 2

            // Paper
            case ("B", "X"): return 0 + 1
            case ("B", "Y"): return 3 + 2
            case ("B", "Z"): return 6 + 3

            // Scissors
            case ("C", "X"): return 0 + 2 
            case ("C", "Y"): return 3 + 3 
            case ("C", "Z"): return 6 + 1
            default:
                return 0
        }
    }
 }

let solution = Solution()
print(solution.solve())


