import Foundation

class Solution {

    private var input: [Int] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let string = try String(contentsOf: url) 
            input = string.replacingOccurrences(of: "target area: x=", with: "")
                .replacingOccurrences(of: " y=", with: "")
                .replacingOccurrences(of: "..", with: ",")
                .components(separatedBy: ",")
                .compactMap(Int.init)
            print(input)
        } catch {
            print(error)
        }
    }

    func solve() -> Int {
        print("1111")
        let vx = 2
        let vy = 2
        let t = 3
        
        let y = vy * t - t * t / 2
        print("t:", t, "y:", y)
        
        return 0
    }

    func sumOfNumbers(_ n: Int) -> Int {
        n * (n + 1) / 2
    }
}

let solution = Solution()
print(solution.solve())
