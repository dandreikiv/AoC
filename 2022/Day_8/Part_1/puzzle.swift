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
        var count = 0
        for row in 0..<rows {
            for cell in 0..<cells {
                let isHidden = isTreeHidden(at: row, cell)
                if isHidden == false {
                    count += 1
                }
            }
        } 
        return count
    }

    private func isTreeHidden(at row: Int, _ cell: Int) -> Bool {
        let rows = input.count
        let cells = input[0].count
        // check up
        var r = row
        var up = false
        while r > 0 {
            if input[r - 1][cell] >= input[row][cell] { up = true; break }
            r -= 1
        }
        // check down
        r = row
        var down = false
        while r < rows - 1 {
            if input[r + 1][cell] >= input[row][cell] { down = true; break }
            r += 1
        }
        // check left
        var c = cell
        var left = false
        while c > 0 {
            if input[row][c - 1] >= input[row][cell] { left = true; break }
            c -= 1
        }
        // check right
        c = cell
        var right = false
        while c < cells - 1 {
            if input[row][c + 1] >= input[row][cell] { right = true; break }
            c += 1
        }
        return up && down && left && right
    }
 }

let puzzle = Puzzle()
print(puzzle.solve())

