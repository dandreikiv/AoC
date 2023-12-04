import Foundation
import RegexBuilder

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
        print(input)
    }

    func solve() -> Int {
        var result = 0
        for line in input {
            let parts = line.components(separatedBy: ":")
            let gameId = Int(parts[0].components(separatedBy: " ")[1])!

            let sets = parts[1].components(separatedBy: ";")

            var cubes: [String: Int] = [:]
            for set in sets {
                for color in ["red", "green", "blue"] {
                    let pattern =  Regex {
                        Capture { OneOrMore(.digit) }
                        OneOrMore(.whitespace)
                        color
                    }
                    if let match = set.firstMatch(of: pattern) {
                        cubes[color] = max(cubes[color, default: 0], Int(match.1)!)
                    }           
                }
            }
            result += cubes.values.reduce(1, *)
        }
        return result
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())


