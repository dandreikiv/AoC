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
        let digitsMap: [String: Int] = [
            "1": 1,
            "2": 2,
            "3": 3,
            "4": 4,
            "5": 5,
            "6": 6,
            "7": 7,
            "8": 8,
            "9": 9,
            "0": 0,
            "one": 1,
            "two": 2,
            "three": 3,
            "four": 4,
            "five": 5,
            "six": 6,
            "seven": 7,
            "eight": 8,
            "nine": 9
        ]

        let digits: [String] = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"
        ]
        
        
        for line in input {
            var lineDigits: [Int] = []
            var acc: [Character] = []

            for ch in line {
                acc.append(ch)
                let accString = String(acc)

                for key in digits {
                    if accString.hasSuffix(key) {
                        if let digit = digitsMap[key] {
                            lineDigits.append(digit)
                        }
                        break
                    }
                }
            }

            if let first = lineDigits.first, let last = lineDigits.last  {
                sum += first * 10 + last
            }
        }
        return sum
    }
}

let solution = Solution()
print(solution.solve())


