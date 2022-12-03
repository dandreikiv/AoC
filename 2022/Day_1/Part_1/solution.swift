import Foundation

class Solution {

    private var input: [Int?] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url).replacingOccurrences(of: "\n", with: "--").components(separatedBy: "--")
            input = string.map { Int($0) }
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> Int {
        var result = 0
        var acc = 0
        for amount in input {
            if let calories = amount {
                acc += calories
            } else {
                result = max(acc, result)
                acc = 0
            }
        }
        return result
    }
}

let solution = Solution()
// solution.printInput()
print(solution.solve())


