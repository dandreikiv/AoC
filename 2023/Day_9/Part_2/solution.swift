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
        var result = 0
        for line in input {
            let history = line.components(separatedBy: " ").map { Int($0)! }
            let nextValue = predictNextValue(for: history)

            result += nextValue
        }

        return result
    }

    func predictNextValue(for history: [Int]) -> Int {
        var result = history
        var elements: [Int] = [result[0]]
        
        while true {
            var index = 0
            var nextResult: [Int] = []
            var allZeros = true
            while index < result.count - 1 {
                let nextValue = result[index + 1] - result[index]
                nextResult.append(nextValue)

                allZeros = allZeros && nextValue == 0

                index = index + 1
            }
            elements.append(nextResult[0])
            result = nextResult
            if allZeros { break }
        }

        var index = elements.count - 1
        var element = 0
        while index >= 0 {
            element = elements[index] - element
            index -= 1
        }

        return element
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())