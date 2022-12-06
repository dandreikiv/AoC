import Foundation

class Puzzle {

    private var input: [String] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            input = try String(contentsOf: url).components(separatedBy: "\n\n")
        } catch {
            print(error)
        }
    }

    func printInput() {
        print(input)
    }

    func solve() -> String {
        let piles = parsePiles()
        let instructions = parseInstructions()
        var result = piles
        for instruction in instructions { 
            result = move(result, with: instruction)
        }
        return String(result.map { $0[0] }) 
    }

    private func parsePiles() -> [[Character]] {
        let lines = input[0]
            .replacingOccurrences(of: "    [", with: "[-] [")
            .replacingOccurrences(of: "     ", with: " [-] ")
            .replacingOccurrences(of: "]    ", with: "] [-]")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: "[", with: "")
            .components(separatedBy: "\n")
            .map { $0.map { $0 } }
            .dropLast()

        let rows = lines.count
        let cells = lines[0].count

        var piles: [[Character]] = []
        for j in 0..<cells {
            var i = rows - 1
            var line: [Character] = []
            while i >= 0 && lines[i][j] != "-" {
                line.insert(lines[i][j], at: 0)
                i = i - 1
            }
            piles.append(line)
        }

        return piles
    }

    private func parseInstructions() -> [[Int]] {
        let instructions = input[1]
            .replacingOccurrences(of: "move ", with: "")
            .replacingOccurrences(of: " from ", with: ",")
            .replacingOccurrences(of: " to ", with: ",")
            .components(separatedBy: "\n")
            .map { $0
                    .components(separatedBy: ",")
                    .compactMap { Int($0)} 
            }
        return instructions
    }

    private func move(_ piles: [[Character]], with instructions: [Int]) -> [[Character]] {
        var result = piles
        let amount = instructions[0]
        let from = instructions[1] - 1
        let to = instructions[2] - 1

        var bunch: [Character] = []
        for _ in 0..<amount {
            bunch.append(result[from].removeFirst()) 
        }
        result[to] = bunch + result[to]
        return result
    }
 }

let puzzle = Puzzle()
print(puzzle.solve())

