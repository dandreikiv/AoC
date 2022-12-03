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
        var group: [Set<Character>] = []
        for line in input {
            group.append(Set(line))
            if group.count == 3 {
                if let char = group[0].intersection(group[1]).intersection(group[2]).first { 
                    let code = Int(char.asciiValue!)
                    result += (char.isUppercase ? code - 65 + 26 : code - 97) + 1
                    group = []
                }
            }
        }
        return result
    }
}

let solution = Solution()
print(solution.solve())


