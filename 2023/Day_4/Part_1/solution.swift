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
        for line in input {
            print(line)
        }
    }

    func solve() -> Int {
        let winningNumbersPattern = Regex {
                ":"
                OneOrMore(.whitespace)
                Capture { OneOrMore(.anyNonNewline) }
                OneOrMore(.whitespace)
                "|"
        }

        let availableNumbersPattern = Regex {
               "|"
                OneOrMore(.whitespace)
                Capture { OneOrMore(.anyNonNewline) }
                ZeroOrMore(.whitespace)
        }

        var result = 0
        for line in input {
            var winningNumbers = Set<Int>()
            var availableNumbers = Set<Int>()
            if let match = line.firstMatch(of: winningNumbersPattern) {
                let numbers = match.1.components(separatedBy: " ").compactMap { Int($0) }
                winningNumbers = Set(numbers)
                
            }

            if let match = line.firstMatch(of: availableNumbersPattern) {
                let numbers = match.1.components(separatedBy: " ").compactMap { Int($0) }
                availableNumbers = Set(numbers)
            }
            
            let intersectionCount = availableNumbers.intersection(winningNumbers).count
            result += Int(pow(Double(2), Double(intersectionCount - 1)))
       }
       return result
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())


