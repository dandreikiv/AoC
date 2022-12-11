import Foundation

class Puzzle {

    private var input: String = ""
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            input = try String(contentsOf: url)
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> Int {
        let chars = Array(input)
        var i = 4
        var key = Array(chars[0...13])
        while i < chars.count, Set(key).count != 14 {
            _ = key.removeFirst()
            key.append(chars[i])
            i += 1
        }
        return i
    }
 }

let puzzle = Puzzle()
print(puzzle.solve())

