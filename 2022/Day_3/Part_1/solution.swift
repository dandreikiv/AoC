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
        var result: Int = 0
        for line in input { 
            let chars = Array(line)
            let length = chars.count
            let left = Set(chars.prefix(length / 2))
            let right = Set(chars.suffix(from: length / 2))
            if let char = left.intersection(right).first, let code = char.asciiValue {
                let priority = (char.isUppercase ? code - 65 + 26 : code - 97) + 1
                result += Int(priority)
            }
            
        }
        return result
    }
 }

let solution = Solution()
print(solution.solve())

