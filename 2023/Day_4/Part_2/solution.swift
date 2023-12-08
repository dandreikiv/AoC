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
        let start = CFAbsoluteTimeGetCurrent()

        for i in 0..<input.count {
            countCards(index: i, cards: input, level: 0)
        }

        let diff = CFAbsoluteTimeGetCurrent() - start
        return countNumbers
    }

    var countNumbers = 0
    func countCards(index: Int, cards: [String], level: Int) {
        countNumbers += 1
        let card = cards[index] 
        let count = amountOfWinningNumbers(in: card)
        if count == 0 { return }

            
        for i in (index + 1)...min(cards.count - 1, index + count) {
            countCards(index: i, cards: cards, level: level + 1)
        }
    }

    var cache: [String: Int] = [:]
    func amountOfWinningNumbers(in card: String) -> Int {
        if let amount = cache[card] {
            return amount
        }
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

        var availableNumbers = Set<Int>()
        var winningNumbers = Set<Int>()
        
        if let match = card.firstMatch(of: winningNumbersPattern) {
            let numbers = match.1.components(separatedBy: " ").compactMap { Int($0) }
            winningNumbers = Set(numbers)
        }

        if let match = card.firstMatch(of: availableNumbersPattern) {
            let numbers = match.1.components(separatedBy: " ").compactMap { Int($0) }
            availableNumbers = Set(numbers)
        }

        let result = availableNumbers.intersection(winningNumbers).count 

        cache[card] = result
            
        return result
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())