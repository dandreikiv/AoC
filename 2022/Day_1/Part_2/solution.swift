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
        var acc = 0
        var elves: [Int] = []
        for amount in input {
            if let calories = amount {
                acc += calories
            } else {
                elves.append(acc)
                acc = 0
            }
        }
        if acc != 0 {
            elves.append(acc)
        }
        return elves.sorted(by: >).prefix(3).reduce(0, +)
    }
}

let solution = Solution()
solution.printInput()
print(solution.solve())


