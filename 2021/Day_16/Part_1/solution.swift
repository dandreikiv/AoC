import Foundation

class Solution {

    private let mapping: [Character: String] = [
        "0": "0000",
        "1": "0001",
        "2": "0010",
        "3": "0011",
        "4": "0100",
        "5": "0101",
        "6": "0110",
        "7": "0111",
        "8": "1000",
        "9": "1001",
        "A": "1010",
        "B": "1011",
        "C": "1100",
        "D": "1101",
        "E": "1110",
        "F": "1111",
    ]

    private var input: [Character] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.map { $0 }.reduce(into: input) { result, next in result.append(contentsOf: mapping[next, default: ""]) }
        } catch {
            print(error)
        }
    }

    func solve() -> Int {
        print(input)
        print(input.count)
        return 0
    }
}

let solution = Solution()
print(solution.solve())
