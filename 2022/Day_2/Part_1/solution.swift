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
        // "X": "A",  Rock
        // "Y": "B",  Paper
        // "Z": "C",  Scissors

        // Score: 
        // rock: x, 1
        // paper: y, 2
        // scissors: z, 3

        // Outcome: 
        // lost: 0
        // draw: 3
        // won: 6

        // winning combinations
        // rock -> scissors X -> C
        // paper -> rock Y -> A
        // scissors -> paper Z -> B

        let plays = input
            .map { $0.split(separator: " ").map(String.init) } // A Y -> ["A", "Y]
            .map { [mapPlay($0[0]), mapPlay($0[1])] }
            .map { matchPlay(left: $0[1], right: $0[0]) }
            .reduce(0, +)

        return plays
    }

    func mapPlay(_ play: String) -> String {
        switch play {
            case "A", "X": return "r"
            case "B", "Y": return "p"
            case "C", "Z": return "s"
            default: return ""
        }
    }

    func matchPlay(left: String, right: String) -> Int {
        switch (left, right) {
            case ("r", "p"): return 0 + 1
            case ("r", "r"): return 3 + 1
            case ("r", "s"): return 6 + 1

            case ("p", "s"): return 0 + 2
            case ("p", "p"): return 3 + 2
            case ("p", "r"): return 6 + 2

            case ("s", "r"): return 0 + 3 
            case ("s", "s"): return 3 + 3 
            case ("s", "p"): return 6 + 3
            default:
                return 0
        }
    }
 }

let solution = Solution()
print(solution.solve())


