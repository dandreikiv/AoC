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

            var isPossible = true
            for set in sets {
                var cubes: [String: Int] = [:]
                for color in ["red", "green", "blue"] {
                    let pattern =  Regex {
                        Capture { OneOrMore(.digit) }
                        OneOrMore(.whitespace)
                        color
                    }
                    if let match = set.firstMatch(of: pattern) {
                        cubes[color] = Int(match.1)
                    }           
                }
                if let red = cubes["red"] {
                    isPossible = isPossible && (red <= 12)
                }
                if let green = cubes["green"] {
                    isPossible = isPossible && green <= 13
                }
                if let blue = cubes["blue"] {
                    isPossible = isPossible && blue <= 14
                }
            }

            if isPossible {
                result += gameId
            }
        }
        return result
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())


