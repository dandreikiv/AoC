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
        var sum = 0
        for line in input {
            let digits = line.compactMap { ch in 
                if ch.isNumber {
                    let asciiValue = Int(ch.asciiValue ?? 0)
                    return asciiValue - 48
                } else {
                    return nil
                }
            }
            guard let first = digits.first, let last = digits.last else {
                return -1
            }

            sum += first * 10 + last
        }
        return sum
    }
}

let solution = Solution()
print(solution.solve())


