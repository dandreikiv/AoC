import Foundation

class Puzzle {

    private var input: [[Int]] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            let lines = try String(contentsOf: url).components(separatedBy: "\n")
            input = lines.map { $0.compactMap { Int(String($0)) } }
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> Int {
        let rows = input.count
        let cells = input[0].count
        var result = 0
        for row in 0..<rows {
            for cell in 0..<cells {
                result = max(scenicStore(at: row, cell), result)
            }
        } 
        return result
    }

    private func scenicStore(at row: Int, _ cell: Int) -> Int {
        let rows = input.count
        let cells = input[0].count
        // check up
        var r = row
        var up = 0
        while r > 0 {
            if input[r - 1][cell] >= input[row][cell] { up += 1; break }
            up += 1
            r -= 1
        }
        // check down
        r = row
        var down = 0
        while r < rows - 1 {
            if input[r + 1][cell] >= input[row][cell] { down += 1; break }
            down += 1
            r += 1
        }
        // check left
        var c = cell
        var left = 0
        while c > 0 {
            if input[row][c - 1] >= input[row][cell] { left += 1; break }
            left += 1
            c -= 1
        }
        // check right
        c = cell
        var right = 0
        while c < cells - 1 {
            if input[row][c + 1] >= input[row][cell] { right += 1; break }
            right += 1
            c += 1
        }
        return up * down * left * right
    }
 }

let puzzle = Puzzle()
print(puzzle.solve())

